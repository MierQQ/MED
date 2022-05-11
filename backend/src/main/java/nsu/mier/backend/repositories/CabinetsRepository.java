package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.Cabinets;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface CabinetsRepository extends JpaRepository<Cabinets, Long>, JpaSpecificationExecutor<Cabinets> {

}