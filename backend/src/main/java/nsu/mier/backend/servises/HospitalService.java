package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.HospitalDTO;
import nsu.mier.backend.VOs.HospitalQueryVO;
import nsu.mier.backend.VOs.HospitalUpdateVO;
import nsu.mier.backend.VOs.HospitalVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.Hospital;
import nsu.mier.backend.repositories.HospitalRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class HospitalService {

    private final HospitalRepository hospitalRepository;

    @Autowired
    public HospitalService(HospitalRepository hospitalRepository) {
        this.hospitalRepository = hospitalRepository;
    }

    public Long save(HospitalVO vO) {
        Hospital bean = new Hospital();
        BeanUtils.copyProperties(vO, bean);
        bean = hospitalRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        hospitalRepository.deleteById(id);
    }

    public void update(Long id, HospitalUpdateVO vO) {
        Hospital bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        hospitalRepository.save(bean);
    }

    public HospitalDTO getById(Long id) {
        Hospital original = requireOne(id);
        return toDTO(original);
    }

    public Page<HospitalDTO> query(HospitalQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private HospitalDTO toDTO(Hospital original) {
        HospitalDTO bean = new HospitalDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Hospital requireOne(Long id) {
        return hospitalRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Hospital> getAll() {
        return hospitalRepository.findAll();
    }
}
