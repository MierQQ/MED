package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.AnalyzesDTO;
import nsu.mier.backend.VOs.AnalyzesQueryVO;
import nsu.mier.backend.VOs.AnalyzesUpdateVO;
import nsu.mier.backend.VOs.AnalyzesVO;
import nsu.mier.backend.entities.Analyzes;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.repositories.AnalyzesRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class AnalyzesService {

    private final AnalyzesRepository analyzesRepository;

    @Autowired
    public AnalyzesService(AnalyzesRepository analyzesRepository) {
        this.analyzesRepository = analyzesRepository;
    }

    public Long save(AnalyzesVO vO) {
        Analyzes bean = new Analyzes();
        BeanUtils.copyProperties(vO, bean);
        bean = analyzesRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        analyzesRepository.deleteById(id);
    }

    public void update(Long id, AnalyzesUpdateVO vO) {
        Analyzes bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        analyzesRepository.save(bean);
    }

    public AnalyzesDTO getById(Long id) {
        Analyzes original = requireOne(id);
        return toDTO(original);
    }

    public Page<AnalyzesDTO> query(AnalyzesQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private AnalyzesDTO toDTO(Analyzes original) {
        AnalyzesDTO bean = new AnalyzesDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Analyzes requireOne(Long id) {
        return analyzesRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Analyzes> getAll() {
        return analyzesRepository.findAll();
    }
}
