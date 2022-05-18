package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "cabinets")
public class Cabinets implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "polyclinic_id", nullable = false)
    private Long polyclinicId;

    @Column(name = "number", nullable = false)
    private Long number;

}
