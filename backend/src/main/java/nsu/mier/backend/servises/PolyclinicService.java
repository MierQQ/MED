package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.PolyclinicDTO;
import nsu.mier.backend.VOs.PolyclinicQueryVO;
import nsu.mier.backend.VOs.PolyclinicUpdateVO;
import nsu.mier.backend.VOs.PolyclinicVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.Polyclinic;
import nsu.mier.backend.repositories.PolyclinicRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class PolyclinicService {

    private final PolyclinicRepository polyclinicRepository;

    @Autowired
    public PolyclinicService(PolyclinicRepository polyclinicRepository) {
        this.polyclinicRepository = polyclinicRepository;
    }

    public Long save(PolyclinicVO vO) {
        Polyclinic bean = new Polyclinic();
        BeanUtils.copyProperties(vO, bean);
        bean = polyclinicRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        polyclinicRepository.deleteById(id);
    }

    public void update(Long id, PolyclinicUpdateVO vO) {
        Polyclinic bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        polyclinicRepository.save(bean);
    }

    public PolyclinicDTO getById(Long id) {
        Polyclinic original = requireOne(id);
        return toDTO(original);
    }

    public Page<PolyclinicDTO> query(PolyclinicQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private PolyclinicDTO toDTO(Polyclinic original) {
        PolyclinicDTO bean = new PolyclinicDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Polyclinic requireOne(Long id) {
        return polyclinicRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Polyclinic> getAll() {
        return polyclinicRepository.findAll();
    }
}
