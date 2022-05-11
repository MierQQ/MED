package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.ProfessorOrDocentDTO;
import nsu.mier.backend.VOs.ProfessorOrDocentQueryVO;
import nsu.mier.backend.VOs.ProfessorOrDocentUpdateVO;
import nsu.mier.backend.VOs.ProfessorOrDocentVO;
import nsu.mier.backend.entities.ProfessorOrDocent;
import nsu.mier.backend.servises.ProfessorOrDocentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("api/v1/professorOrDocent")
public class ProfessorOrDocentController {

    private final ProfessorOrDocentService professorOrDocentService;

    @Autowired
    public ProfessorOrDocentController(ProfessorOrDocentService professorOrDocentService) {
        this.professorOrDocentService = professorOrDocentService;
    }

    @PostMapping
    public String save(@Valid @RequestBody ProfessorOrDocentVO vO) {
        return professorOrDocentService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        professorOrDocentService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody ProfessorOrDocentUpdateVO vO) {
        professorOrDocentService.update(id, vO);
    }

    @GetMapping("/{id}")
    public ProfessorOrDocentDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return professorOrDocentService.getById(id);
    }

    @GetMapping
    public List<ProfessorOrDocent> getAll() {
        return professorOrDocentService.getAll();
    }
}
