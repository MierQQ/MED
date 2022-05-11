package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.MedStaffPatientDTO;
import nsu.mier.backend.VOs.MedStaffPatientQueryVO;
import nsu.mier.backend.VOs.MedStaffPatientUpdateVO;
import nsu.mier.backend.VOs.MedStaffPatientVO;
import nsu.mier.backend.entities.MedStaffPatient;
import nsu.mier.backend.servises.MedStaffPatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/medStaffPatient")
public class MedStaffPatientController {

    private final MedStaffPatientService medStaffPatientService;

    @Autowired
    public MedStaffPatientController(MedStaffPatientService medStaffPatientService) {
        this.medStaffPatientService = medStaffPatientService;
    }

    @PostMapping
    public String save(@Valid @RequestBody MedStaffPatientVO vO) {
        return medStaffPatientService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        medStaffPatientService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody MedStaffPatientUpdateVO vO) {
        medStaffPatientService.update(id, vO);
    }

    @GetMapping("/{id}")
    public MedStaffPatientDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return medStaffPatientService.getById(id);
    }

    @GetMapping
    public List<MedStaffPatient> getAll() {
        return medStaffPatientService.getAll();
    }
}
