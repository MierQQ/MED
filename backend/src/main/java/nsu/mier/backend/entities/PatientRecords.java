package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "patient_records")
public class PatientRecords implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "patient_id")
    private Long patientId;

    @Column(name = "medical_institution_id")
    private Long medicalInstitutionId;

    @Column(name = "data")
    private String data;

    @Column(name = "type")
    private String type;

    @Column(name = "date")
    private Date date;

    @Column(name = "doctor_id")
    private Long doctorId;

    @Column(name = "hospital_room_id")
    private Long hospitalRoomId;

    @Column(name = "cabinet")
    private Long cabinet;

    @Column(name = "grouping", nullable = false)
    private Long grouping;

}
