package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.AnalyzesDTO;
import nsu.mier.backend.VOs.AnalyzesQueryVO;
import nsu.mier.backend.VOs.AnalyzesUpdateVO;
import nsu.mier.backend.VOs.AnalyzesVO;
import nsu.mier.backend.entities.Analyzes;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.servises.AnalyzesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping( "api/v1/analyzes")
public class AnalyzesController {

    private final AnalyzesService analyzesService;

    @Autowired
    public AnalyzesController(AnalyzesService analyzesService) {
        this.analyzesService = analyzesService;
    }

    @PostMapping
    public String save(@Valid @RequestBody AnalyzesVO vO) {
        return analyzesService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        analyzesService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody AnalyzesUpdateVO vO) {
        analyzesService.update(id, vO);
    }

    @GetMapping("/{id}")
    public AnalyzesDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return analyzesService.getById(id);
    }

    @GetMapping
    public List<Analyzes> getAll() {
        return analyzesService.getAll();
    }
}
