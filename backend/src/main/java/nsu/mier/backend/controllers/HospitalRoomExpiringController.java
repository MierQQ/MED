package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.HospitalRoomExpiringDTO;
import nsu.mier.backend.VOs.HospitalRoomExpiringQueryVO;
import nsu.mier.backend.VOs.HospitalRoomExpiringUpdateVO;
import nsu.mier.backend.VOs.HospitalRoomExpiringVO;
import nsu.mier.backend.entities.HospitalRoomExpiring;
import nsu.mier.backend.servises.HospitalRoomExpiringService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/hospitalRoomExpiring")
public class HospitalRoomExpiringController {

    private final HospitalRoomExpiringService hospitalRoomExpiringService;

    @Autowired
    public HospitalRoomExpiringController(HospitalRoomExpiringService hospitalRoomExpiringService) {
        this.hospitalRoomExpiringService = hospitalRoomExpiringService;
    }

    @PostMapping
    public String save(@Valid @RequestBody HospitalRoomExpiringVO vO) {
        return hospitalRoomExpiringService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        hospitalRoomExpiringService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody HospitalRoomExpiringUpdateVO vO) {
        hospitalRoomExpiringService.update(id, vO);
    }

    @GetMapping("/{id}")
    public HospitalRoomExpiringDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return hospitalRoomExpiringService.getById(id);
    }

    @GetMapping
    public List<HospitalRoomExpiring> getAll() {
        return hospitalRoomExpiringService.getAll();
    }
}
