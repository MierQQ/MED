package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.MedStaffDTO;
import nsu.mier.backend.VOs.MedStaffQueryVO;
import nsu.mier.backend.VOs.MedStaffUpdateVO;
import nsu.mier.backend.VOs.MedStaffVO;
import nsu.mier.backend.entities.MedStaff;
import nsu.mier.backend.servises.MedStaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/medStaff")
public class MedStaffController {

    private final MedStaffService medStaffService;

    @Autowired
    public MedStaffController(MedStaffService medStaffService) {
        this.medStaffService = medStaffService;
    }

    @PostMapping
    public String save(@Valid @RequestBody MedStaffVO vO) {
        return medStaffService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        medStaffService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody MedStaffUpdateVO vO) {
        medStaffService.update(id, vO);
    }

    @GetMapping("/{id}")
    public MedStaffDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return medStaffService.getById(id);
    }

    @GetMapping
    public List<MedStaff> getAll() {
        return medStaffService.getAll();
    }
}
