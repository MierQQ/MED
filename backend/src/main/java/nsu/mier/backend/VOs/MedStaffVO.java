package nsu.mier.backend.VOs;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class MedStaffVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "id can not null")
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
