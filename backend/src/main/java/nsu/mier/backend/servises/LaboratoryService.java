package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.LaboratoryDTO;
import nsu.mier.backend.VOs.LaboratoryQueryVO;
import nsu.mier.backend.VOs.LaboratoryUpdateVO;
import nsu.mier.backend.VOs.LaboratoryVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.Laboratory;
import nsu.mier.backend.repositories.LaboratoryRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class LaboratoryService {

    private final LaboratoryRepository laboratoryRepository;

    @Autowired
    public LaboratoryService(LaboratoryRepository laboratoryRepository) {
        this.laboratoryRepository = laboratoryRepository;
    }

    public Long save(LaboratoryVO vO) {
        Laboratory bean = new Laboratory();
        BeanUtils.copyProperties(vO, bean);
        bean = laboratoryRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        laboratoryRepository.deleteById(id);
    }

    public void update(Long id, LaboratoryUpdateVO vO) {
        Laboratory bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        laboratoryRepository.save(bean);
    }

    public LaboratoryDTO getById(Long id) {
        Laboratory original = requireOne(id);
        return toDTO(original);
    }

    public Page<LaboratoryDTO> query(LaboratoryQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private LaboratoryDTO toDTO(Laboratory original) {
        LaboratoryDTO bean = new LaboratoryDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Laboratory requireOne(Long id) {
        return laboratoryRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Laboratory> getAll() {
        return laboratoryRepository.findAll();
    }
}
