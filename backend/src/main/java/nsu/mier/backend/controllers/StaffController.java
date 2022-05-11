package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.StaffDTO;
import nsu.mier.backend.VOs.StaffQueryVO;
import nsu.mier.backend.VOs.StaffUpdateVO;
import nsu.mier.backend.VOs.StaffVO;
import nsu.mier.backend.entities.Staff;
import nsu.mier.backend.servises.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/staff")
public class StaffController {

    private final StaffService staffService;

    @Autowired
    public StaffController(StaffService staffService) {
        this.staffService = staffService;
    }

    @PostMapping
    public String save(@Valid @RequestBody StaffVO vO) {
        return staffService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        staffService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody StaffUpdateVO vO) {
        staffService.update(id, vO);
    }

    @GetMapping("/{id}")
    public StaffDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return staffService.getById(id);
    }

    @GetMapping
    public List<Staff> getAll() {
        return staffService.getAll();
    }
}
