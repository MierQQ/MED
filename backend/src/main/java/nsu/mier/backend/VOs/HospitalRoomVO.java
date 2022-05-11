package nsu.mier.backend.VOs;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class HospitalRoomVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "id can not null")
    private Long id;

    private Long departmentId;

    private Long bedNumber;

}
