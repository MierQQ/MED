package nsu.mier.backend.VOs;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;


@Data
public class PatientRecordsVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "id can not null")
    private Long id;

    private Long patientId;

    private Long medicalInstitutionId;

    private String data;

    private String type;

    private Date date;

    private Long doctorId;

    private Long hospitalRoomId;

    private Long cabinet;

    @NotNull(message = "grouping can not null")
    private Long grouping;

}
