package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.MedicalInstitution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MedicalInstitutionRepository extends JpaRepository<MedicalInstitution, Long>, JpaSpecificationExecutor<MedicalInstitution> {

}