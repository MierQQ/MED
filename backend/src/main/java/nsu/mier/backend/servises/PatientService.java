package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.PatientDTO;
import nsu.mier.backend.VOs.PatientQueryVO;
import nsu.mier.backend.VOs.PatientUpdateVO;
import nsu.mier.backend.VOs.PatientVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.Patient;
import nsu.mier.backend.repositories.PatientRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class PatientService {

    private final PatientRepository patientRepository;

    @Autowired
    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public Long save(PatientVO vO) {
        Patient bean = new Patient();
        BeanUtils.copyProperties(vO, bean);
        bean = patientRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        patientRepository.deleteById(id);
    }

    public void update(Long id, PatientUpdateVO vO) {
        Patient bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        patientRepository.save(bean);
    }

    public PatientDTO getById(Long id) {
        Patient original = requireOne(id);
        return toDTO(original);
    }

    public Page<PatientDTO> query(PatientQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private PatientDTO toDTO(Patient original) {
        PatientDTO bean = new PatientDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Patient requireOne(Long id) {
        return patientRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Patient> getAll() {
        return patientRepository.findAll();
    }
}
