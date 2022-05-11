package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.LabMedicalInstitutionDTO;
import nsu.mier.backend.VOs.LabMedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.LabMedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.LabMedicalInstitutionVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.LabMedicalInstitution;
import nsu.mier.backend.repositories.LabMedicalInstitutionRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class LabMedicalInstitutionService {

    private final LabMedicalInstitutionRepository labMedicalInstitutionRepository;

    @Autowired
    public LabMedicalInstitutionService(LabMedicalInstitutionRepository labMedicalInstitutionRepository) {
        this.labMedicalInstitutionRepository = labMedicalInstitutionRepository;
    }

    public Long save(LabMedicalInstitutionVO vO) {
        LabMedicalInstitution bean = new LabMedicalInstitution();
        BeanUtils.copyProperties(vO, bean);
        bean = labMedicalInstitutionRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        labMedicalInstitutionRepository.deleteById(id);
    }

    public void update(Long id, LabMedicalInstitutionUpdateVO vO) {
        LabMedicalInstitution bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        labMedicalInstitutionRepository.save(bean);
    }

    public LabMedicalInstitutionDTO getById(Long id) {
        LabMedicalInstitution original = requireOne(id);
        return toDTO(original);
    }

    public Page<LabMedicalInstitutionDTO> query(LabMedicalInstitutionQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private LabMedicalInstitutionDTO toDTO(LabMedicalInstitution original) {
        LabMedicalInstitutionDTO bean = new LabMedicalInstitutionDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private LabMedicalInstitution requireOne(Long id) {
        return labMedicalInstitutionRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<LabMedicalInstitution> getAll() {
        return labMedicalInstitutionRepository.findAll();
    }
}
