package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.MedicalInstitutionDTO;
import nsu.mier.backend.VOs.MedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.MedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.MedicalInstitutionVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.MedicalInstitution;
import nsu.mier.backend.repositories.MedicalInstitutionRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class MedicalInstitutionService {

    private final MedicalInstitutionRepository medicalInstitutionRepository;

    @Autowired
    public MedicalInstitutionService(MedicalInstitutionRepository medicalInstitutionRepository) {
        this.medicalInstitutionRepository = medicalInstitutionRepository;
    }

    public Long save(MedicalInstitutionVO vO) {
        MedicalInstitution bean = new MedicalInstitution();
        BeanUtils.copyProperties(vO, bean);
        bean = medicalInstitutionRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        medicalInstitutionRepository.deleteById(id);
    }

    public void update(Long id, MedicalInstitutionUpdateVO vO) {
        MedicalInstitution bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        medicalInstitutionRepository.save(bean);
    }

    public MedicalInstitutionDTO getById(Long id) {
        MedicalInstitution original = requireOne(id);
        return toDTO(original);
    }

    public Page<MedicalInstitutionDTO> query(MedicalInstitutionQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private MedicalInstitutionDTO toDTO(MedicalInstitution original) {
        MedicalInstitutionDTO bean = new MedicalInstitutionDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private MedicalInstitution requireOne(Long id) {
        return medicalInstitutionRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<MedicalInstitution> getAll() {
        return medicalInstitutionRepository.findAll();
    }
}
