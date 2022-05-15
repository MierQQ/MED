package nsu.mier.backend.repositories;

import nsu.mier.backend.DTOs.StaffProductivityDTO;
import nsu.mier.backend.DTOs.StaffQueryDTO;
import nsu.mier.backend.entities.Staff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StaffRepository extends JpaRepository<Staff, Long>, JpaSpecificationExecutor<Staff> {

    @Query(nativeQuery = true, value = "SELECT * FROM find_service_staff(" +
            "CAST(:institutionIds AS INTEGER[])," +
            "CAST(:specializations AS VARCHAR []))")
    List<StaffQueryDTO> findQuery2(@Param("institutionIds") String institutionIds,
                                   @Param("specializations") String specializations);

    @Query(nativeQuery = true, value = "SELECT * FROM get_productivity_polyclinic(" +
            "CAST(:startDate AS DATE)," +
            "CAST(:endDate AS DATE)," +
            "CAST(:doctorIds AS INTEGER[])," +
            "CAST(:specializations AS VARCHAR[])," +
            "CAST(:polyclinicIds AS INTEGER[]))")
    List<StaffProductivityDTO> findQuery11(@Param("startDate") String startDate,
                                           @Param("endDate") String endDate,
                                           @Param("doctorIds") String doctorIds,
                                           @Param("specializations") String specializations,
                                           @Param("polyclinicIds") String polyclinicIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_productivity_hospital(" +
            "CAST(:doctorIds AS INTEGER[])," +
            "CAST(:specializations AS VARCHAR[])," +
            "CAST(:hospitalIds AS INTEGER[]))")
    List<StaffProductivityDTO> findQuery12(@Param("doctorIds") String doctorIds,
                                           @Param("specializations") String specializations,
                                           @Param("hospitalIds") String hospitalIds);
}