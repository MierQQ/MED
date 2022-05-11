package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.LaboratoryDTO;
import nsu.mier.backend.VOs.LaboratoryQueryVO;
import nsu.mier.backend.VOs.LaboratoryUpdateVO;
import nsu.mier.backend.VOs.LaboratoryVO;
import nsu.mier.backend.entities.Laboratory;
import nsu.mier.backend.servises.LaboratoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/laboratory")
public class LaboratoryController {

    private final LaboratoryService laboratoryService;

    @Autowired
    public LaboratoryController(LaboratoryService laboratoryService) {
        this.laboratoryService = laboratoryService;
    }

    @PostMapping
    public String save(@Valid @RequestBody LaboratoryVO vO) {
        return laboratoryService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        laboratoryService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody LaboratoryUpdateVO vO) {
        laboratoryService.update(id, vO);
    }

    @GetMapping("/{id}")
    public LaboratoryDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return laboratoryService.getById(id);
    }

    @GetMapping
    public List<Laboratory> getAll() {
        return laboratoryService.getAll();
    }
}
