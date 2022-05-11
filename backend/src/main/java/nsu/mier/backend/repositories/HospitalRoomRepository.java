package nsu.mier.backend.repositories;

import nsu.mier.backend.entities.HospitalRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface HospitalRoomRepository extends JpaRepository<HospitalRoom, Long>, JpaSpecificationExecutor<HospitalRoom> {

}