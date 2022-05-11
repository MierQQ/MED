package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.ProfOrDocentMedicalInstitutionDTO;
import nsu.mier.backend.VOs.ProfOrDocentMedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.ProfOrDocentMedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.ProfOrDocentMedicalInstitutionVO;
import nsu.mier.backend.entities.ProfOrDocentMedicalInstitution;
import nsu.mier.backend.servises.ProfOrDocentMedicalInstitutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/profOrDocentMedicalInstitution")
public class ProfOrDocentMedicalInstitutionController {

    private final ProfOrDocentMedicalInstitutionService profOrDocentMedicalInstitutionService;

    @Autowired
    public ProfOrDocentMedicalInstitutionController(ProfOrDocentMedicalInstitutionService profOrDocentMedicalInstitutionService) {
        this.profOrDocentMedicalInstitutionService = profOrDocentMedicalInstitutionService;
    }

    @PostMapping
    public String save(@Valid @RequestBody ProfOrDocentMedicalInstitutionVO vO) {
        return profOrDocentMedicalInstitutionService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        profOrDocentMedicalInstitutionService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody ProfOrDocentMedicalInstitutionUpdateVO vO) {
        profOrDocentMedicalInstitutionService.update(id, vO);
    }

    @GetMapping("/{id}")
    public ProfOrDocentMedicalInstitutionDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return profOrDocentMedicalInstitutionService.getById(id);
    }

    @GetMapping
    public List<ProfOrDocentMedicalInstitution> getAll() {
        return profOrDocentMedicalInstitutionService.getAll();
    }
}
