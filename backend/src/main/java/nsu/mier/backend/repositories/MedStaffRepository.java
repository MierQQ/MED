package nsu.mier.backend.repositories;

import nsu.mier.backend.DTOs.StaffQueryDTO;
import nsu.mier.backend.entities.MedStaff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MedStaffRepository extends JpaRepository<MedStaff, Long>, JpaSpecificationExecutor<MedStaff> {
    @Query(nativeQuery = true, value = "SELECT * FROM find_med_staff(" +
            "CAST(:institutionIds AS INTEGER[])," +
            "CAST(:specializations AS VARCHAR []))")
    List<StaffQueryDTO> findQuery1(@Param("institutionIds") String institutionIds,
                                   @Param("specializations") String specializations);

    @Query(nativeQuery = true, value = "SELECT * FROM find_med_staff_with_operations(" +
            "CAST(:institutionIds AS INTEGER[])," +
            "CAST(:specializations AS VARCHAR [])," +
            ":surgeriesNumber)")
    List<StaffQueryDTO> findQuery3(@Param("institutionIds") String institutionIds,
                                   @Param("specializations") String specializations,
                                   @Param("surgeriesNumber") Integer surgeriesNumber);

    @Query(nativeQuery = true, value = "SELECT * FROM find_med_staff_with_standing(" +
            "CAST(:institutionIds AS INTEGER[])," +
            "CAST(:specializations AS VARCHAR [])," +
            "CAST(:standing AS INTERVAL))")
    List<StaffQueryDTO> findQuery4(@Param("institutionIds") String institutionIds,
                                   @Param("specializations") String specializations,
                                   @Param("standing") String standing);

    @Query(nativeQuery = true, value = "SELECT * FROM find_med_staff_with_regalia(" +
            "CAST(:institutionIds AS INTEGER[])," +
            "CAST(:specializations AS VARCHAR []))")
    List<StaffQueryDTO> findQuery5(@Param("institutionIds") String institutionIds,
                                   @Param("specializations") String specializations);
}