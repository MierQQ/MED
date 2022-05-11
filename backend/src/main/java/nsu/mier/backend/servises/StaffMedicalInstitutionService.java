package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.StaffMedicalInstitutionDTO;
import nsu.mier.backend.VOs.StaffMedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.StaffMedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.StaffMedicalInstitutionVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.StaffMedicalInstitution;
import nsu.mier.backend.repositories.StaffMedicalInstitutionRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class StaffMedicalInstitutionService {

    private final StaffMedicalInstitutionRepository staffMedicalInstitutionRepository;

    @Autowired
    public StaffMedicalInstitutionService(StaffMedicalInstitutionRepository staffMedicalInstitutionRepository) {
        this.staffMedicalInstitutionRepository = staffMedicalInstitutionRepository;
    }

    public Long save(StaffMedicalInstitutionVO vO) {
        StaffMedicalInstitution bean = new StaffMedicalInstitution();
        BeanUtils.copyProperties(vO, bean);
        bean = staffMedicalInstitutionRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        staffMedicalInstitutionRepository.deleteById(id);
    }

    public void update(Long id, StaffMedicalInstitutionUpdateVO vO) {
        StaffMedicalInstitution bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        staffMedicalInstitutionRepository.save(bean);
    }

    public StaffMedicalInstitutionDTO getById(Long id) {
        StaffMedicalInstitution original = requireOne(id);
        return toDTO(original);
    }

    public Page<StaffMedicalInstitutionDTO> query(StaffMedicalInstitutionQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private StaffMedicalInstitutionDTO toDTO(StaffMedicalInstitution original) {
        StaffMedicalInstitutionDTO bean = new StaffMedicalInstitutionDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private StaffMedicalInstitution requireOne(Long id) {
        return staffMedicalInstitutionRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<StaffMedicalInstitution> getAll() {
        return staffMedicalInstitutionRepository.findAll();
    }
}
