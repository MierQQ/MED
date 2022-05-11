package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.HospitalRoomExpiringDTO;
import nsu.mier.backend.VOs.HospitalRoomExpiringQueryVO;
import nsu.mier.backend.VOs.HospitalRoomExpiringUpdateVO;
import nsu.mier.backend.VOs.HospitalRoomExpiringVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.HospitalRoomExpiring;
import nsu.mier.backend.repositories.HospitalRoomExpiringRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class HospitalRoomExpiringService {

    private final HospitalRoomExpiringRepository hospitalRoomExpiringRepository;

    @Autowired
    public HospitalRoomExpiringService(HospitalRoomExpiringRepository hospitalRoomExpiringRepository) {
        this.hospitalRoomExpiringRepository = hospitalRoomExpiringRepository;
    }

    public Long save(HospitalRoomExpiringVO vO) {
        HospitalRoomExpiring bean = new HospitalRoomExpiring();
        BeanUtils.copyProperties(vO, bean);
        bean = hospitalRoomExpiringRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        hospitalRoomExpiringRepository.deleteById(id);
    }

    public void update(Long id, HospitalRoomExpiringUpdateVO vO) {
        HospitalRoomExpiring bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        hospitalRoomExpiringRepository.save(bean);
    }

    public HospitalRoomExpiringDTO getById(Long id) {
        HospitalRoomExpiring original = requireOne(id);
        return toDTO(original);
    }

    public Page<HospitalRoomExpiringDTO> query(HospitalRoomExpiringQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private HospitalRoomExpiringDTO toDTO(HospitalRoomExpiring original) {
        HospitalRoomExpiringDTO bean = new HospitalRoomExpiringDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private HospitalRoomExpiring requireOne(Long id) {
        return hospitalRoomExpiringRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<HospitalRoomExpiring> getAll() {
        return hospitalRoomExpiringRepository.findAll();
    }
}
