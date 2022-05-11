package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.PolyclinicDTO;
import nsu.mier.backend.VOs.PolyclinicQueryVO;
import nsu.mier.backend.VOs.PolyclinicUpdateVO;
import nsu.mier.backend.VOs.PolyclinicVO;
import nsu.mier.backend.entities.Polyclinic;
import nsu.mier.backend.servises.PolyclinicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/polyclinic")
public class PolyclinicController {

    private final PolyclinicService polyclinicService;

    @Autowired
    public PolyclinicController(PolyclinicService polyclinicService) {
        this.polyclinicService = polyclinicService;
    }

    @PostMapping
    public String save(@Valid @RequestBody PolyclinicVO vO) {
        return polyclinicService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        polyclinicService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody PolyclinicUpdateVO vO) {
        polyclinicService.update(id, vO);
    }

    @GetMapping("/{id}")
    public PolyclinicDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return polyclinicService.getById(id);
    }

    @GetMapping
    public List<Polyclinic> getAll() {
        return polyclinicService.getAll();
    }
}
