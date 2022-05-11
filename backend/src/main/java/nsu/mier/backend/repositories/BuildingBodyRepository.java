package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.BuildingBody;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface BuildingBodyRepository extends JpaRepository<BuildingBody, Long>, JpaSpecificationExecutor<BuildingBody> {

}