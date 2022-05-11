package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.PatientRecordsDTO;
import nsu.mier.backend.VOs.PatientRecordsQueryVO;
import nsu.mier.backend.VOs.PatientRecordsUpdateVO;
import nsu.mier.backend.VOs.PatientRecordsVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.PatientRecords;
import nsu.mier.backend.repositories.PatientRecordsRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class PatientRecordsService {

    private final PatientRecordsRepository patientRecordsRepository;

    @Autowired
    public PatientRecordsService(PatientRecordsRepository patientRecordsRepository) {
        this.patientRecordsRepository = patientRecordsRepository;
    }

    public Long save(PatientRecordsVO vO) {
        PatientRecords bean = new PatientRecords();
        BeanUtils.copyProperties(vO, bean);
        bean = patientRecordsRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        patientRecordsRepository.deleteById(id);
    }

    public void update(Long id, PatientRecordsUpdateVO vO) {
        PatientRecords bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        patientRecordsRepository.save(bean);
    }

    public PatientRecordsDTO getById(Long id) {
        PatientRecords original = requireOne(id);
        return toDTO(original);
    }

    public Page<PatientRecordsDTO> query(PatientRecordsQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private PatientRecordsDTO toDTO(PatientRecords original) {
        PatientRecordsDTO bean = new PatientRecordsDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private PatientRecords requireOne(Long id) {
        return patientRecordsRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<PatientRecords> getAll() {
        return patientRecordsRepository.findAll();
    }
}
