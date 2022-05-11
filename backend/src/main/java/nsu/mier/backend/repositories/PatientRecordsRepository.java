package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.PatientRecords;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface PatientRecordsRepository extends JpaRepository<PatientRecords, Long>, JpaSpecificationExecutor<PatientRecords> {

}