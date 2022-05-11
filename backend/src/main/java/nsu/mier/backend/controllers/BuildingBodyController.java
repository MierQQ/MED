package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.BuildingBodyDTO;
import nsu.mier.backend.VOs.BuildingBodyQueryVO;
import nsu.mier.backend.VOs.BuildingBodyUpdateVO;
import nsu.mier.backend.VOs.BuildingBodyVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.servises.BuildingBodyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/buildingBody")
public class BuildingBodyController {

    private final BuildingBodyService buildingBodyService;

    @Autowired
    public BuildingBodyController(BuildingBodyService buildingBodyService) {
        this.buildingBodyService = buildingBodyService;
    }

    @PostMapping
    public String save(@Valid @RequestBody BuildingBodyVO vO) {
        return buildingBodyService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        buildingBodyService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody BuildingBodyUpdateVO vO) {
        buildingBodyService.update(id, vO);
    }

    @GetMapping("/{id}")
    public BuildingBodyDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return buildingBodyService.getById(id);
    }

    @GetMapping
    public List<BuildingBody> getAll() {
        return buildingBodyService.getAll();
    }
}
