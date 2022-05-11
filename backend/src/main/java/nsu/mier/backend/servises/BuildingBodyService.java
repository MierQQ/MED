package nsu.mier.backend.servises;

import nsu.mier.backend.DTOs.BuildingBodyDTO;
import nsu.mier.backend.VOs.BuildingBodyQueryVO;
import nsu.mier.backend.VOs.BuildingBodyUpdateVO;
import nsu.mier.backend.VOs.BuildingBodyVO;
import nsu.mier.backend.entities.BuildingBody;
import nsu.mier.backend.repositories.BuildingBodyRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class BuildingBodyService {

    private final BuildingBodyRepository buildingBodyRepository;

    @Autowired
    public BuildingBodyService(BuildingBodyRepository buildingBodyRepository) {
        this.buildingBodyRepository = buildingBodyRepository;
    }

    public Long save(BuildingBodyVO vO) {
        BuildingBody bean = new BuildingBody();
        BeanUtils.copyProperties(vO, bean);
        bean = buildingBodyRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        buildingBodyRepository.deleteById(id);
    }

    public void update(Long id, BuildingBodyUpdateVO vO) {
        BuildingBody bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        buildingBodyRepository.save(bean);
    }

    public BuildingBodyDTO getById(Long id) {
        BuildingBody original = requireOne(id);
        return toDTO(original);
    }

    public Page<BuildingBodyDTO> query(BuildingBodyQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private BuildingBodyDTO toDTO(BuildingBody original) {
        BuildingBodyDTO bean = new BuildingBodyDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private BuildingBody requireOne(Long id) {
        return buildingBodyRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<BuildingBody> getAll() {
        return buildingBodyRepository.findAll();
    }
}
