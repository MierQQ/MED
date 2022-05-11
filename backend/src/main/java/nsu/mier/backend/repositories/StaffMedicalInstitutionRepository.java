package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.StaffMedicalInstitution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface StaffMedicalInstitutionRepository extends JpaRepository<StaffMedicalInstitution, Long>, JpaSpecificationExecutor<StaffMedicalInstitution> {

}