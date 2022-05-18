package nsu.mier.backend.repositories;

import nsu.mier.backend.DTOs.CountDTO;
import nsu.mier.backend.DTOs.DepartmentCountDTO;
import nsu.mier.backend.entities.HospitalRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface HospitalRoomRepository extends JpaRepository<HospitalRoom, Long>, JpaSpecificationExecutor<HospitalRoom> {

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room(CAST(:hospitalIds AS INTEGER[]))")
    List<CountDTO> findQuery91(@Param("hospitalIds") String hospitalIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room_beds(CAST(:hospitalIds AS INTEGER[]))")
    List<CountDTO> findQuery92(@Param("hospitalIds") String hospitalIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room_by_departments(CAST(:hospitalIds AS INTEGER[]))")
    List<DepartmentCountDTO> findQuery93(@Param("hospitalIds") String hospitalIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_hospital_room_beds_by_departments(CAST(:hospitalIds AS INTEGER[]))")
    List<DepartmentCountDTO> findQuery94(@Param("hospitalIds") String hospitalIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_free_hospital_room_by_departments(CAST(:hospitalIds AS INTEGER[]))")
    List<DepartmentCountDTO> findQuery95(@Param("hospitalIds") String hospitalIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_number_of_free_hospital_room_beds_by_departments(CAST(:hospitalIds AS INTEGER[]))")
    List<DepartmentCountDTO> findQuery96(@Param("hospitalIds") String hospitalIds);
}