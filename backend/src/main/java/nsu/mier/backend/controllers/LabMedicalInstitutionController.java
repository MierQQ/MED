package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.LabMedicalInstitutionDTO;
import nsu.mier.backend.VOs.LabMedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.LabMedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.LabMedicalInstitutionVO;
import nsu.mier.backend.entities.LabMedicalInstitution;
import nsu.mier.backend.servises.LabMedicalInstitutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/labMedicalInstitution")
public class LabMedicalInstitutionController {

    private final LabMedicalInstitutionService labMedicalInstitutionService;

    @Autowired
    public LabMedicalInstitutionController(LabMedicalInstitutionService labMedicalInstitutionService) {
        this.labMedicalInstitutionService = labMedicalInstitutionService;
    }

    @PostMapping
    public String save(@Valid @RequestBody LabMedicalInstitutionVO vO) {
        return labMedicalInstitutionService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        labMedicalInstitutionService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody LabMedicalInstitutionUpdateVO vO) {
        labMedicalInstitutionService.update(id, vO);
    }

    @GetMapping("/{id}")
    public LabMedicalInstitutionDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return labMedicalInstitutionService.getById(id);
    }

    @GetMapping
    public List<LabMedicalInstitution> getAll() {
        return labMedicalInstitutionService.getAll();
    }
}
