package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.HospitalRoomExpiring;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface HospitalRoomExpiringRepository extends JpaRepository<HospitalRoomExpiring, Long>, JpaSpecificationExecutor<HospitalRoomExpiring> {

}