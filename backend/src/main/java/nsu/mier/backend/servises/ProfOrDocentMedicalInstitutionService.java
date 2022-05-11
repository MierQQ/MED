package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.ProfOrDocentMedicalInstitutionDTO;
import nsu.mier.backend.VOs.ProfOrDocentMedicalInstitutionQueryVO;
import nsu.mier.backend.VOs.ProfOrDocentMedicalInstitutionUpdateVO;
import nsu.mier.backend.VOs.ProfOrDocentMedicalInstitutionVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.ProfOrDocentMedicalInstitution;
import nsu.mier.backend.repositories.ProfOrDocentMedicalInstitutionRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class ProfOrDocentMedicalInstitutionService {

    private final ProfOrDocentMedicalInstitutionRepository profOrDocentMedicalInstitutionRepository;

    @Autowired
    public ProfOrDocentMedicalInstitutionService(ProfOrDocentMedicalInstitutionRepository profOrDocentMedicalInstitutionRepository) {
        this.profOrDocentMedicalInstitutionRepository = profOrDocentMedicalInstitutionRepository;
    }

    public Long save(ProfOrDocentMedicalInstitutionVO vO) {
        ProfOrDocentMedicalInstitution bean = new ProfOrDocentMedicalInstitution();
        BeanUtils.copyProperties(vO, bean);
        bean = profOrDocentMedicalInstitutionRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        profOrDocentMedicalInstitutionRepository.deleteById(id);
    }

    public void update(Long id, ProfOrDocentMedicalInstitutionUpdateVO vO) {
        ProfOrDocentMedicalInstitution bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        profOrDocentMedicalInstitutionRepository.save(bean);
    }

    public ProfOrDocentMedicalInstitutionDTO getById(Long id) {
        ProfOrDocentMedicalInstitution original = requireOne(id);
        return toDTO(original);
    }

    public Page<ProfOrDocentMedicalInstitutionDTO> query(ProfOrDocentMedicalInstitutionQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private ProfOrDocentMedicalInstitutionDTO toDTO(ProfOrDocentMedicalInstitution original) {
        ProfOrDocentMedicalInstitutionDTO bean = new ProfOrDocentMedicalInstitutionDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private ProfOrDocentMedicalInstitution requireOne(Long id) {
        return profOrDocentMedicalInstitutionRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<ProfOrDocentMedicalInstitution> getAll() {
        return profOrDocentMedicalInstitutionRepository.findAll();
    }
}
