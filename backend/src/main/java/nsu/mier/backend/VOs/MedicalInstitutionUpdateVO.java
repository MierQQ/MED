package nsu.mier.backend.VOs;


import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
public class MedicalInstitutionUpdateVO extends MedicalInstitutionVO implements Serializable {
    private static final long serialVersionUID = 1L;

}
