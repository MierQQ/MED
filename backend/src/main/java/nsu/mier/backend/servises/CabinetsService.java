package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.CabinetCountDTO;
import nsu.mier.backend.DTOs.CabinetsDTO;
import nsu.mier.backend.DTOs.CountDTO;
import nsu.mier.backend.DTOs.PatientNameDTO;
import nsu.mier.backend.VOs.CabinetsQueryVO;
import nsu.mier.backend.VOs.CabinetsUpdateVO;
import nsu.mier.backend.VOs.CabinetsVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.Cabinets;
import nsu.mier.backend.repositories.CabinetsRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class CabinetsService {

    private final CabinetsRepository cabinetsRepository;

    @Autowired
    public CabinetsService(CabinetsRepository cabinetsRepository) {
        this.cabinetsRepository = cabinetsRepository;
    }

    public Long save(CabinetsVO vO) {
        Cabinets bean = new Cabinets();
        BeanUtils.copyProperties(vO, bean);
        bean = cabinetsRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        cabinetsRepository.deleteById(id);
    }

    public void update(Long id, CabinetsUpdateVO vO) {
        Cabinets bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        cabinetsRepository.save(bean);
    }

    public CabinetsDTO getById(Long id) {
        Cabinets original = requireOne(id);
        return toDTO(original);
    }

    public Page<CabinetsDTO> query(CabinetsQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private CabinetsDTO toDTO(Cabinets original) {
        CabinetsDTO bean = new CabinetsDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Cabinets requireOne(Long id) {
        return cabinetsRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Cabinets> getAll() {
        return cabinetsRepository.findAll();
    }

    public List<CountDTO> findQuery101(String institutionIds) {
        return cabinetsRepository.findQuery101(institutionIds);
    }

    public List<CabinetCountDTO> findQuery102(String startDate, String endDate) {
        return cabinetsRepository.findQuery102(startDate, endDate);
    }
}
