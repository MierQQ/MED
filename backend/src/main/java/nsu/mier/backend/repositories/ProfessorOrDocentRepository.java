package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.ProfessorOrDocent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProfessorOrDocentRepository extends JpaRepository<ProfessorOrDocent, Long>, JpaSpecificationExecutor<ProfessorOrDocent> {

}