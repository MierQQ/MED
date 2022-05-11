package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.Polyclinic;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface PolyclinicRepository extends JpaRepository<Polyclinic, Long>, JpaSpecificationExecutor<Polyclinic> {

}