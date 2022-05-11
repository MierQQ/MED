package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.ProfessorOrDocentDTO;
import nsu.mier.backend.VOs.ProfessorOrDocentQueryVO;
import nsu.mier.backend.VOs.ProfessorOrDocentUpdateVO;
import nsu.mier.backend.VOs.ProfessorOrDocentVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.ProfessorOrDocent;
import nsu.mier.backend.repositories.ProfessorOrDocentRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class ProfessorOrDocentService {

    private final ProfessorOrDocentRepository professorOrDocentRepository;

    @Autowired
    public ProfessorOrDocentService(ProfessorOrDocentRepository professorOrDocentRepository) {
        this.professorOrDocentRepository = professorOrDocentRepository;
    }

    public Long save(ProfessorOrDocentVO vO) {
        ProfessorOrDocent bean = new ProfessorOrDocent();
        BeanUtils.copyProperties(vO, bean);
        bean = professorOrDocentRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        professorOrDocentRepository.deleteById(id);
    }

    public void update(Long id, ProfessorOrDocentUpdateVO vO) {
        ProfessorOrDocent bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        professorOrDocentRepository.save(bean);
    }

    public ProfessorOrDocentDTO getById(Long id) {
        ProfessorOrDocent original = requireOne(id);
        return toDTO(original);
    }

    public Page<ProfessorOrDocentDTO> query(ProfessorOrDocentQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private ProfessorOrDocentDTO toDTO(ProfessorOrDocent original) {
        ProfessorOrDocentDTO bean = new ProfessorOrDocentDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private ProfessorOrDocent requireOne(Long id) {
        return professorOrDocentRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<ProfessorOrDocent> getAll() {
        return professorOrDocentRepository.findAll();
    }
}
