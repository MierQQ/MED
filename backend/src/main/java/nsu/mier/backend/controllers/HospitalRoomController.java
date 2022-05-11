package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.HospitalRoomDTO;
import nsu.mier.backend.VOs.HospitalRoomQueryVO;
import nsu.mier.backend.VOs.HospitalRoomUpdateVO;
import nsu.mier.backend.VOs.HospitalRoomVO;
import nsu.mier.backend.entities.HospitalRoom;
import nsu.mier.backend.servises.HospitalRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/hospitalRoom")
public class HospitalRoomController {

    private final HospitalRoomService hospitalRoomService;

    @Autowired
    public HospitalRoomController(HospitalRoomService hospitalRoomService) {
        this.hospitalRoomService = hospitalRoomService;
    }

    @PostMapping
    public String save(@Valid @RequestBody HospitalRoomVO vO) {
        return hospitalRoomService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        hospitalRoomService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody HospitalRoomUpdateVO vO) {
        hospitalRoomService.update(id, vO);
    }

    @GetMapping("/{id}")
    public HospitalRoomDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return hospitalRoomService.getById(id);
    }

    @GetMapping
    public List<HospitalRoom> getAll() {
        return hospitalRoomService.getAll();
    }
}
