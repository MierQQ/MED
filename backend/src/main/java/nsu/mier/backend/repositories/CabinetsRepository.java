package nsu.mier.backend.repositories;

import nsu.mier.backend.DTOs.CabinetCountDTO;
import nsu.mier.backend.DTOs.CountDTO;
import nsu.mier.backend.DTOs.PatientNameDTO;
import nsu.mier.backend.entities.Cabinets;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CabinetsRepository extends JpaRepository<Cabinets, Long>, JpaSpecificationExecutor<Cabinets> {

    @Query(nativeQuery = true, value = "SELECT * FROM get_count_of_cabinets(" +
            "CAST(:institutionIds AS INTEGER[]))")
    List<CountDTO> findQuery101(@Param("institutionIds") String institutionIds);

    @Query(nativeQuery = true, value = "SELECT * FROM get_count_of_cabinets_usage(" +
            "CAST(:startDate AS DATE)," +
            "CAST(:endDate AS DATE))")
    List<CabinetCountDTO> findQuery102(@Param("startDate") String startDate, @Param("endDate") String endDate);
}