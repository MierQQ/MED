package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Data
@Entity
@Table(name = "hospital_room_expiring")
public class HospitalRoomExpiring implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "record", nullable = false)
    private Long record;

    @Column(name = "date", nullable = false)
    private Date date;

}
