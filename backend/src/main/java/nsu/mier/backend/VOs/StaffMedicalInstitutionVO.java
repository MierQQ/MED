package nsu.mier.backend.VOs;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class StaffMedicalInstitutionVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "id can not null")
    private Long id;

    @NotNull(message = "staffId can not null")
    private Long staffId;

    @NotNull(message = "medicalInstitutionId can not null")
    private Long medicalInstitutionId;

}
