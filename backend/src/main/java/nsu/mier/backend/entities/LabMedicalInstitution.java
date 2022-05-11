package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "lab_medical_institution")
public class LabMedicalInstitution implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "medical_institution_id")
    private Long medicalInstitutionId;

    @Column(name = "laboratory_id")
    private Long laboratoryId;

}
