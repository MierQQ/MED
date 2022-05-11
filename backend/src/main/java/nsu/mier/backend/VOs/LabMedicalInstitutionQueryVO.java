package nsu.mier.backend.VOs;


import lombok.Data;

import java.io.Serializable;

@Data
public class LabMedicalInstitutionQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long medicalInstitutionId;

    private Long laboratoryId;

}
