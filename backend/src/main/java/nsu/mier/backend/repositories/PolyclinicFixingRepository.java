package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.PolyclinicFixing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface PolyclinicFixingRepository extends JpaRepository<PolyclinicFixing, Long>, JpaSpecificationExecutor<PolyclinicFixing> {

}