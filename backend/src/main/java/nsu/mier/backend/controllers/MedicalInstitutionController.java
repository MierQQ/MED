package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.MedicalInstitutionDTO;
import nsu.mier.backend.VOs.MedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.MedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.MedicalInstitutionVO;
import nsu.mier.backend.entities.MedicalInstitution;
import nsu.mier.backend.servises.MedicalInstitutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/medicalInstitution")
public class MedicalInstitutionController {

    private final MedicalInstitutionService medicalInstitutionService;

    @Autowired
    public MedicalInstitutionController(MedicalInstitutionService medicalInstitutionService) {
        this.medicalInstitutionService = medicalInstitutionService;
    }

    @PostMapping
    public String save(@Valid @RequestBody MedicalInstitutionVO vO) {
        return medicalInstitutionService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        medicalInstitutionService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody MedicalInstitutionUpdateVO vO) {
        medicalInstitutionService.update(id, vO);
    }

    @GetMapping("/{id}")
    public MedicalInstitutionDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return medicalInstitutionService.getById(id);
    }

    @GetMapping
    public List<MedicalInstitution> getAll() {
        return medicalInstitutionService.getAll();
    }
}
