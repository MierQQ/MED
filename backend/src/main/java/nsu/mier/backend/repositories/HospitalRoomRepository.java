package nsu.mier.backend.repositories;

import nsu.mier.backend.DTOs.CountDTO;
import nsu.mier.backend.DTOs.DepartmentCountDTO;
import nsu.mier.backend.entities.HospitalRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HospitalRoomRepository extends JpaRepository<HospitalRoom, Long>, JpaSpecificationExecutor<HospitalRoom> {

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room()")
    List<CountDTO> findQuery91();

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room_beds()")
    List<CountDTO> findQuery92();

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room_by_departments()")
    List<DepartmentCountDTO> findQuery93();

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room_beds_by_departments()")
    List<DepartmentCountDTO> findQuery94();

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_free_hospital_room_by_departments()")
    List<DepartmentCountDTO> findQuery95();

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_free_hospital_room_beds_by_departments()")
    List<DepartmentCountDTO> findQuery96();
}