package nsu.mier.backend.VOs;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.sql.Date;


@Data
public class HospitalRoomExpiringVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "id can not null")
    private Long id;

    @NotNull(message = "record can not null")
    private Long record;

    @NotNull(message = "date can not null")
    private Date date;

}
