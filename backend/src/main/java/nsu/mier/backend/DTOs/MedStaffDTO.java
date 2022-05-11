package nsu.mier.backend.DTOs;


import lombok.Data;

import java.io.Serializable;

@Data
public class MedStaffDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;

    private Double salaryCoefficient;

    private Long vocationBonus;

    private Boolean condidateDegree;

    private Boolean phd;

    private Boolean professor;

    private Boolean docent;

    private Long polyclinicId;

    private Long hospitalId;

}
