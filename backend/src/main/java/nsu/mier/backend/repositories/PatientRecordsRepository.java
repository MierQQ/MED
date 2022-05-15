package nsu.mier.backend.repositories;

import nsu.mier.backend.DTOs.LabProductivityDTO;
import nsu.mier.backend.DTOs.PatientNameDTO;
import nsu.mier.backend.DTOs.PatientQuery6DTO;
import nsu.mier.backend.DTOs.StaffQueryDTO;
import nsu.mier.backend.entities.PatientRecords;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface PatientRecordsRepository extends JpaRepository<PatientRecords, Long>, JpaSpecificationExecutor<PatientRecords> {

    @Query(nativeQuery = true, value = "SELECT * FROM find_patients_hospital(" +
            "CAST(:hospitalIds AS INTEGER[])," +
            "CAST(:departmentIds AS INTEGER [])," +
            "CAST(:hospitalRoomIds AS INTEGER []))")
    List<PatientQuery6DTO> findQuery6(@Param("hospitalIds") String hospitalIds,
                                   @Param("departmentIds") String departmentIds,
                                   @Param("hospitalRoomIds") String hospitalRoomIds);

    @Query(nativeQuery = true, value = "SELECT * FROM find_patient_between_date(" +
            "CAST(:institutionIds AS INTEGER[])," +
            "CAST(:medStaffIds AS INTEGER [])," +
            "CAST(:startDate AS DATE)," +
            "CAST(:endDate AS DATE))")
    List<PatientNameDTO> findQuery7(@Param("institutionIds") String institutionIds,
                                    @Param("medStaffIds") String medStaffIds,
                                    @Param("startDate") String startDate,
                                    @Param("endDate") String endDate);

    @Query(nativeQuery = true, value = "SELECT * FROM find_patient_by_specialization(" +
            "CAST(:specializations AS VARCHAR[])," +
            "CAST(:institutionIds AS INTEGER []))")
    List<PatientNameDTO> findQuery8(@Param("specializations") String specializations,
                                    @Param("institutionIds") String institutionIds);


    @Query(nativeQuery = true, value = "SELECT * FROM get_surgeon_patients(" +
            "CAST(:startDate AS DATE)," +
            "CAST(:endDate AS DATE)," +
            "CAST(:doctorIds AS INTEGER[])," +
            "CAST(:medIds AS INTEGER[]))")
    List<PatientNameDTO> findQuery13(@Param("startDate") String startDate,
                                     @Param("endDate") String endDate,
                                     @Param("doctorIds") String doctorIds,
                                     @Param("medIds") String medIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_lab_productivity(" +
            "CAST(:startDate AS DATE)," +
            "CAST(:endDate AS DATE)," +
            "CAST(:medIds AS INTEGER[]))")
    List<LabProductivityDTO> findQuery14(@Param("startDate") String startDate,
                                         @Param("endDate") String endDate,
                                         @Param("medIds") String medIds);
}