package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.StaffMedicalInstitutionDTO;
import nsu.mier.backend.VOs.StaffMedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.StaffMedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.StaffMedicalInstitutionVO;
import nsu.mier.backend.entities.StaffMedicalInstitution;
import nsu.mier.backend.servises.StaffMedicalInstitutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/staffMedicalInstitution")
public class StaffMedicalInstitutionController {

    private final StaffMedicalInstitutionService staffMedicalInstitutionService;

    @Autowired
    public StaffMedicalInstitutionController(StaffMedicalInstitutionService staffMedicalInstitutionService) {
        this.staffMedicalInstitutionService = staffMedicalInstitutionService;
    }

    @PostMapping
    public String save(@Valid @RequestBody StaffMedicalInstitutionVO vO) {
        return staffMedicalInstitutionService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        staffMedicalInstitutionService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody StaffMedicalInstitutionUpdateVO vO) {
        staffMedicalInstitutionService.update(id, vO);
    }

    @GetMapping("/{id}")
    public StaffMedicalInstitutionDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return staffMedicalInstitutionService.getById(id);
    }

    @GetMapping
    public List<StaffMedicalInstitution> getAll() {
        return staffMedicalInstitutionService.getAll();
    }
}
