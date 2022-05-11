package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.ProfOrDocentMedicalInstitution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProfOrDocentMedicalInstitutionRepository extends JpaRepository<ProfOrDocentMedicalInstitution, Long>, JpaSpecificationExecutor<ProfOrDocentMedicalInstitution> {

}