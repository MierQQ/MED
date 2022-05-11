package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.CabinetsDTO;
import nsu.mier.backend.VOs.CabinetsQueryVO;
import nsu.mier.backend.VOs.CabinetsUpdateVO;
import nsu.mier.backend.VOs.CabinetsVO;
import nsu.mier.backend.entities.Cabinets;
import nsu.mier.backend.servises.CabinetsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/cabinets")
public class CabinetsController {

    private final CabinetsService cabinetsService;

    @Autowired
    public CabinetsController(CabinetsService cabinetsService) {
        this.cabinetsService = cabinetsService;
    }

    @PostMapping
    public String save(@Valid @RequestBody CabinetsVO vO) {
        return cabinetsService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        cabinetsService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody CabinetsUpdateVO vO) {
        cabinetsService.update(id, vO);
    }

    @GetMapping("/{id}")
    public CabinetsDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return cabinetsService.getById(id);
    }

    @GetMapping
    public List<Cabinets> getAll() {
        return cabinetsService.getAll();
    }
}
