package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.PatientDTO;
import nsu.mier.backend.VOs.PatientQueryVO;
import nsu.mier.backend.VOs.PatientUpdateVO;
import nsu.mier.backend.VOs.PatientVO;
import nsu.mier.backend.entities.Patient;
import nsu.mier.backend.servises.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/patient")
public class PatientController {

    private final PatientService patientService;

    @Autowired
    public PatientController(PatientService patientService) {
        this.patientService = patientService;
    }

    @PostMapping
    public String save(@Valid @RequestBody PatientVO vO) {
        return patientService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        patientService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody PatientUpdateVO vO) {
        patientService.update(id, vO);
    }

    @GetMapping("/{id}")
    public PatientDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return patientService.getById(id);
    }

    @GetMapping
    public List<Patient> getAll() {
        return patientService.getAll();
    }
}
