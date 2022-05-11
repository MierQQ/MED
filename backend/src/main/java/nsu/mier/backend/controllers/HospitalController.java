package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.HospitalDTO;
import nsu.mier.backend.VOs.HospitalQueryVO;
import nsu.mier.backend.VOs.HospitalUpdateVO;
import nsu.mier.backend.VOs.HospitalVO;
import nsu.mier.backend.entities.Hospital;
import nsu.mier.backend.servises.HospitalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/hospital")
public class HospitalController {

    private final HospitalService hospitalService;

    @Autowired
    public HospitalController(HospitalService hospitalService) {
        this.hospitalService = hospitalService;
    }

    @PostMapping
    public String save(@Valid @RequestBody HospitalVO vO) {
        return hospitalService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        hospitalService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody HospitalUpdateVO vO) {
        hospitalService.update(id, vO);
    }

    @GetMapping("/{id}")
    public HospitalDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return hospitalService.getById(id);
    }

    @GetMapping
    public List<Hospital> getAll() {
        return hospitalService.getAll();
    }
}
