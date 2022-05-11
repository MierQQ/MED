package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.LabMedicalInstitution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface LabMedicalInstitutionRepository extends JpaRepository<LabMedicalInstitution, Long>, JpaSpecificationExecutor<LabMedicalInstitution> {

}