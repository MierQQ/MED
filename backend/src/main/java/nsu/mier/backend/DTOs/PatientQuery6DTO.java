package nsu.mier.backend.DTOs;

import java.time.LocalDate;

public interface PatientQuery6DTO {
    Integer getId();
    String getName();
    String getData();
    LocalDate getDate();
    Integer getVisit();
}
