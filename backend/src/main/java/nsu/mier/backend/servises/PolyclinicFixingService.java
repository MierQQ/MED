package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.PolyclinicFixingDTO;
import nsu.mier.backend.VOs.PolyclinicFixingQueryVO;
import nsu.mier.backend.VOs.PolyclinicFixingUpdateVO;
import nsu.mier.backend.VOs.PolyclinicFixingVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.PolyclinicFixing;
import nsu.mier.backend.repositories.PolyclinicFixingRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class PolyclinicFixingService {

    private final PolyclinicFixingRepository polyclinicFixingRepository;

    @Autowired
    public PolyclinicFixingService(PolyclinicFixingRepository polyclinicFixingRepository) {
        this.polyclinicFixingRepository = polyclinicFixingRepository;
    }

    public Long save(PolyclinicFixingVO vO) {
        PolyclinicFixing bean = new PolyclinicFixing();
        BeanUtils.copyProperties(vO, bean);
        bean = polyclinicFixingRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        polyclinicFixingRepository.deleteById(id);
    }

    public void update(Long id, PolyclinicFixingUpdateVO vO) {
        PolyclinicFixing bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        polyclinicFixingRepository.save(bean);
    }

    public PolyclinicFixingDTO getById(Long id) {
        PolyclinicFixing original = requireOne(id);
        return toDTO(original);
    }

    public Page<PolyclinicFixingDTO> query(PolyclinicFixingQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private PolyclinicFixingDTO toDTO(PolyclinicFixing original) {
        PolyclinicFixingDTO bean = new PolyclinicFixingDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private PolyclinicFixing requireOne(Long id) {
        return polyclinicFixingRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<PolyclinicFixing> getAll() {
        return polyclinicFixingRepository.findAll();
    }
}
