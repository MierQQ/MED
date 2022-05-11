package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.PolyclinicFixingDTO;
import nsu.mier.backend.VOs.PolyclinicFixingQueryVO;
import nsu.mier.backend.VOs.PolyclinicFixingUpdateVO;
import nsu.mier.backend.VOs.PolyclinicFixingVO;
import nsu.mier.backend.entities.PolyclinicFixing;
import nsu.mier.backend.servises.PolyclinicFixingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/polyclinicFixing")
public class PolyclinicFixingController {

    private final PolyclinicFixingService polyclinicFixingService;

    @Autowired
    public PolyclinicFixingController(PolyclinicFixingService polyclinicFixingService) {
        this.polyclinicFixingService = polyclinicFixingService;
    }

    @PostMapping
    public String save(@Valid @RequestBody PolyclinicFixingVO vO) {
        return polyclinicFixingService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        polyclinicFixingService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody PolyclinicFixingUpdateVO vO) {
        polyclinicFixingService.update(id, vO);
    }

    @GetMapping("/{id}")
    public PolyclinicFixingDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return polyclinicFixingService.getById(id);
    }

    @GetMapping
    public List<PolyclinicFixing> getAll() {
        return polyclinicFixingService.getAll();
    }
}
