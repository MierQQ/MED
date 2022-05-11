package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.MedStaffPatientDTO;
import nsu.mier.backend.VOs.MedStaffPatientQueryVO;
import nsu.mier.backend.VOs.MedStaffPatientUpdateVO;
import nsu.mier.backend.VOs.MedStaffPatientVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.MedStaffPatient;
import nsu.mier.backend.repositories.MedStaffPatientRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class MedStaffPatientService {

    private final MedStaffPatientRepository medStaffPatientRepository;

    @Autowired
    public MedStaffPatientService(MedStaffPatientRepository medStaffPatientRepository) {
        this.medStaffPatientRepository = medStaffPatientRepository;
    }

    public Long save(MedStaffPatientVO vO) {
        MedStaffPatient bean = new MedStaffPatient();
        BeanUtils.copyProperties(vO, bean);
        bean = medStaffPatientRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        medStaffPatientRepository.deleteById(id);
    }

    public void update(Long id, MedStaffPatientUpdateVO vO) {
        MedStaffPatient bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        medStaffPatientRepository.save(bean);
    }

    public MedStaffPatientDTO getById(Long id) {
        MedStaffPatient original = requireOne(id);
        return toDTO(original);
    }

    public Page<MedStaffPatientDTO> query(MedStaffPatientQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private MedStaffPatientDTO toDTO(MedStaffPatient original) {
        MedStaffPatientDTO bean = new MedStaffPatientDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private MedStaffPatient requireOne(Long id) {
        return medStaffPatientRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<MedStaffPatient> getAll() {
        return medStaffPatientRepository.findAll();
    }
}
