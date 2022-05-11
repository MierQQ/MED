package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.StaffDTO;
import nsu.mier.backend.VOs.StaffQueryVO;
import nsu.mier.backend.VOs.StaffUpdateVO;
import nsu.mier.backend.VOs.StaffVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.Staff;
import nsu.mier.backend.repositories.StaffRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class StaffService {

    private final StaffRepository staffRepository;

    @Autowired
    public StaffService(StaffRepository staffRepository) {
        this.staffRepository = staffRepository;
    }

    public Long save(StaffVO vO) {
        Staff bean = new Staff();
        BeanUtils.copyProperties(vO, bean);
        bean = staffRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        staffRepository.deleteById(id);
    }

    public void update(Long id, StaffUpdateVO vO) {
        Staff bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        staffRepository.save(bean);
    }

    public StaffDTO getById(Long id) {
        Staff original = requireOne(id);
        return toDTO(original);
    }

    public Page<StaffDTO> query(StaffQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private StaffDTO toDTO(Staff original) {
        StaffDTO bean = new StaffDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Staff requireOne(Long id) {
        return staffRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Staff> getAll() {
        return staffRepository.findAll();
    }
}
