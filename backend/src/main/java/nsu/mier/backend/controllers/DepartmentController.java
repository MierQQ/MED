package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.DepartmentDTO;
import nsu.mier.backend.VOs.DepartmentQueryVO;
import nsu.mier.backend.VOs.DepartmentUpdateVO;
import nsu.mier.backend.VOs.DepartmentVO;
import nsu.mier.backend.entities.Department;
import nsu.mier.backend.servises.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/department")
public class DepartmentController {

    private final DepartmentService departmentService;

    @Autowired
    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    @PostMapping
    public String save(@Valid @RequestBody DepartmentVO vO) {
        return departmentService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        departmentService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody DepartmentUpdateVO vO) {
        departmentService.update(id, vO);
    }

    @GetMapping("/{id}")
    public DepartmentDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return departmentService.getById(id);
    }

    @GetMapping
    public List<Department> getAll() {
        return departmentService.getAll();
    }

}
