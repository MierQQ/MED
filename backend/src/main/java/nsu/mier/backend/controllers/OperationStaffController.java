package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.OperationStaffDTO;
import nsu.mier.backend.VOs.OperationStaffQueryVO;
import nsu.mier.backend.VOs.OperationStaffUpdateVO;
import nsu.mier.backend.VOs.OperationStaffVO;
import nsu.mier.backend.entities.OperationStaff;
import nsu.mier.backend.servises.OperationStaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/operationStaff")
public class OperationStaffController {

    private final OperationStaffService operationStaffService;

    @Autowired
    public OperationStaffController(OperationStaffService operationStaffService) {
        this.operationStaffService = operationStaffService;
    }

    @PostMapping
    public String save(@Valid @RequestBody OperationStaffVO vO) {
        return operationStaffService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        operationStaffService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody OperationStaffUpdateVO vO) {
        operationStaffService.update(id, vO);
    }

    @GetMapping("/{id}")
    public OperationStaffDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return operationStaffService.getById(id);
    }

    @GetMapping
    public List<OperationStaff> getAll() {
        return operationStaffService.getAll();
    }
}
