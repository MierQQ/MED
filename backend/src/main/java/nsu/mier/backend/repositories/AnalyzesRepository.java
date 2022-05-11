package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.Analyzes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface AnalyzesRepository extends JpaRepository<Analyzes, Long>, JpaSpecificationExecutor<Analyzes> {

}