package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@Entity
@Table(name = "med_staff")
public class MedStaff implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "salary_coefficient")
    private Double salaryCoefficient;

    @Column(name = "vocation_bonus")
    private Long vocationBonus;

    @Column(name = "condidate_degree")
    private Boolean condidateDegree;

    @Column(name = "phd")
    private Boolean phd;

    @Column(name = "professor")
    private Boolean professor;

    @Column(name = "docent")
    private Boolean docent;

    @Column(name = "polyclinic_id")
    private Long polyclinicId;

    @Column(name = "hospital_id")
    private Long hospitalId;

}
