package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.OperationStaff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface OperationStaffRepository extends JpaRepository<OperationStaff, Long>, JpaSpecificationExecutor<OperationStaff> {

}