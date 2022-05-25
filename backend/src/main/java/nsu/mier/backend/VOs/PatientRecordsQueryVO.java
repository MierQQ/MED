package nsu.mier.backend.VOs;


import lombok.Data;

import java.io.Serializable;
import java.sql.Date;

@Data
public class PatientRecordsQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long patientId;

    private Long medicalInstitutionId;

    private String data;

    private String type;

    private Date date;

    private Long doctorId;

    private Long hospitalRoomId;

    private Long cabinet;

    private Long grouping;

}
