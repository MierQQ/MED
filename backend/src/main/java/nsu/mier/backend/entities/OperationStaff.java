package nsu.mier.backend.entities;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@Entity
@Table(name = "operation_staff")
public class OperationStaff implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "num_of_surgeries")
    private Long numOfSurgeries;

    @Column(name = "num_of_fatal_surgeries")
    private Long numOfFatalSurgeries;

}
