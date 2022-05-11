package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.OperationStaffDTO;
import nsu.mier.backend.VOs.OperationStaffQueryVO;
import nsu.mier.backend.VOs.OperationStaffUpdateVO;
import nsu.mier.backend.VOs.OperationStaffVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.OperationStaff;
import nsu.mier.backend.repositories.OperationStaffRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class OperationStaffService {

    private final OperationStaffRepository operationStaffRepository;

    @Autowired
    public OperationStaffService(OperationStaffRepository operationStaffRepository) {
        this.operationStaffRepository = operationStaffRepository;
    }

    public Long save(OperationStaffVO vO) {
        OperationStaff bean = new OperationStaff();
        BeanUtils.copyProperties(vO, bean);
        bean = operationStaffRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        operationStaffRepository.deleteById(id);
    }

    public void update(Long id, OperationStaffUpdateVO vO) {
        OperationStaff bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        operationStaffRepository.save(bean);
    }

    public OperationStaffDTO getById(Long id) {
        OperationStaff original = requireOne(id);
        return toDTO(original);
    }

    public Page<OperationStaffDTO> query(OperationStaffQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private OperationStaffDTO toDTO(OperationStaff original) {
        OperationStaffDTO bean = new OperationStaffDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private OperationStaff requireOne(Long id) {
        return operationStaffRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<OperationStaff> getAll() {
        return operationStaffRepository.findAll();
    }
}
