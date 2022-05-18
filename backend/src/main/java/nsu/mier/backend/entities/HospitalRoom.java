package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "hospital_room")
public class HospitalRoom implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "department_id")
    private Long departmentId;

    @Column(name = "bed_number")
    private Long bedNumber;

}
