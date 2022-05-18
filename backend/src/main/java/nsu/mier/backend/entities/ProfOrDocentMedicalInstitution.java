package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "prof_or_docent_medical_institution")
public class ProfOrDocentMedicalInstitution implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "prof_or_docent_id", nullable = false)
    private Long profOrDocentId;

    @Column(name = "medical_institution_id", nullable = false)
    private Long medicalInstitutionId;

}
