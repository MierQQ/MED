package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "polyclinic_fixing")
public class PolyclinicFixing implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "polyclinic_id")
    private Long polyclinicId;

    @Column(name = "hospital_id")
    private Long hospitalId;

}
