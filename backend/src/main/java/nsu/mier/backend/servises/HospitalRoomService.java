package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.CountDTO;
import nsu.mier.backend.DTOs.DepartmentCountDTO;
import nsu.mier.backend.DTOs.HospitalRoomDTO;
import nsu.mier.backend.VOs.HospitalRoomQueryVO;
import nsu.mier.backend.VOs.HospitalRoomUpdateVO;
import nsu.mier.backend.VOs.HospitalRoomVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.HospitalRoom;
import nsu.mier.backend.repositories.HospitalRoomRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class HospitalRoomService {

    private final HospitalRoomRepository hospitalRoomRepository;

    @Autowired
    public HospitalRoomService(HospitalRoomRepository hospitalRoomRepository) {
        this.hospitalRoomRepository = hospitalRoomRepository;
    }

    public Long save(HospitalRoomVO vO) {
        HospitalRoom bean = new HospitalRoom();
        BeanUtils.copyProperties(vO, bean);
        bean = hospitalRoomRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        hospitalRoomRepository.deleteById(id);
    }

    public void update(Long id, HospitalRoomUpdateVO vO) {
        HospitalRoom bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        hospitalRoomRepository.save(bean);
    }

    public HospitalRoomDTO getById(Long id) {
        HospitalRoom original = requireOne(id);
        return toDTO(original);
    }

    public Page<HospitalRoomDTO> query(HospitalRoomQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private HospitalRoomDTO toDTO(HospitalRoom original) {
        HospitalRoomDTO bean = new HospitalRoomDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private HospitalRoom requireOne(Long id) {
        return hospitalRoomRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<HospitalRoom> getAll() {
        return hospitalRoomRepository.findAll();
    }

    public List<CountDTO> findQuery91() {
        return hospitalRoomRepository.findQuery91();
    }

    public List<CountDTO> findQuery92() {
        return hospitalRoomRepository.findQuery92();
    }

    public List<DepartmentCountDTO> findQuery93() {
        return hospitalRoomRepository.findQuery93();
    }

    public List<DepartmentCountDTO> findQuery94() {
        return hospitalRoomRepository.findQuery94();
    }

    public List<DepartmentCountDTO> findQuery95() {
        return hospitalRoomRepository.findQuery95();
    }

    public List<DepartmentCountDTO> findQuery96() {
        return hospitalRoomRepository.findQuery96();
    }
}
