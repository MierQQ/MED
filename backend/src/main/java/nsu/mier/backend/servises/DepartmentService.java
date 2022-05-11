package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.DepartmentDTO;
import nsu.mier.backend.VOs.DepartmentQueryVO;
import nsu.mier.backend.VOs.DepartmentUpdateVO;
import nsu.mier.backend.VOs.DepartmentVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.entities.Department;
import nsu.mier.backend.repositories.DepartmentRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class DepartmentService {

    private final DepartmentRepository departmentRepository;

    @Autowired
    public DepartmentService(DepartmentRepository departmentRepository) {
        this.departmentRepository = departmentRepository;
    }

    public Long save(DepartmentVO vO) {
        Department bean = new Department();
        BeanUtils.copyProperties(vO, bean);
        bean = departmentRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        departmentRepository.deleteById(id);
    }

    public void update(Long id, DepartmentUpdateVO vO) {
        Department bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        departmentRepository.save(bean);
    }

    public DepartmentDTO getById(Long id) {
        Department original = requireOne(id);
        return toDTO(original);
    }

    public Page<DepartmentDTO> query(DepartmentQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private DepartmentDTO toDTO(Department original) {
        DepartmentDTO bean = new DepartmentDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Department requireOne(Long id) {
        return departmentRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<Department> getAll() {
        return departmentRepository.findAll();
    }
}
