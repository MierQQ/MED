package nsu.mier.backend.VOs;


import lombok.Data;

import java.io.Serializable;

@Data
public class StaffMedicalInstitutionQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long staffId;

    private Long medicalInstitutionId;

}
