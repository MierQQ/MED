package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.PatientRecordsDTO;
import nsu.mier.backend.VOs.PatientRecordsQueryVO;
import nsu.mier.backend.VOs.PatientRecordsUpdateVO;
import nsu.mier.backend.VOs.PatientRecordsVO;
import nsu.mier.backend.entities.PatientRecords;
import nsu.mier.backend.servises.PatientRecordsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/patientRecords")
public class PatientRecordsController {

    private final PatientRecordsService patientRecordsService;

    @Autowired
    public PatientRecordsController(PatientRecordsService patientRecordsService) {
        this.patientRecordsService = patientRecordsService;
    }

    @PostMapping
    public String save(@Valid @RequestBody PatientRecordsVO vO) {
        return patientRecordsService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        patientRecordsService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody PatientRecordsUpdateVO vO) {
        patientRecordsService.update(id, vO);
    }

    @GetMapping("/{id}")
    public PatientRecordsDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return patientRecordsService.getById(id);
    }

    @GetMapping
    public List<PatientRecords> getAll() {
        return patientRecordsService.getAll();
    }
}
