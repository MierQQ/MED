package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.MedStaffDTO;
import nsu.mier.backend.VOs.MedStaffQueryVO;
import nsu.mier.backend.VOs.MedStaffUpdateVO;
import nsu.mier.backend.VOs.MedStaffVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.MedStaff;
import nsu.mier.backend.repositories.MedStaffRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class MedStaffService {

    private final MedStaffRepository medStaffRepository;

    @Autowired
    public MedStaffService(MedStaffRepository medStaffRepository) {
        this.medStaffRepository = medStaffRepository;
    }

    public Long save(MedStaffVO vO) {
        MedStaff bean = new MedStaff();
        BeanUtils.copyProperties(vO, bean);
        bean = medStaffRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        medStaffRepository.deleteById(id);
    }

    public void update(Long id, MedStaffUpdateVO vO) {
        MedStaff bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        medStaffRepository.save(bean);
    }

    public MedStaffDTO getById(Long id) {
        MedStaff original = requireOne(id);
        return toDTO(original);
    }

    public Page<MedStaffDTO> query(MedStaffQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private MedStaffDTO toDTO(MedStaff original) {
        MedStaffDTO bean = new MedStaffDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private MedStaff requireOne(Long id) {
        return medStaffRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<MedStaff> getAll() {
        return medStaffRepository.findAll();
    }
}
