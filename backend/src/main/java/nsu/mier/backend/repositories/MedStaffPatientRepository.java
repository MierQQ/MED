package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.MedStaffPatient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MedStaffPatientRepository extends JpaRepository<MedStaffPatient, Long>, JpaSpecificationExecutor<MedStaffPatient> {

}