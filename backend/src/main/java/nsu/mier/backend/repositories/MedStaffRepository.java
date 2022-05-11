package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.MedStaff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MedStaffRepository extends JpaRepository<MedStaff, Long>, JpaSpecificationExecutor<MedStaff> {

}