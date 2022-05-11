package nsu.mier.backend.VOs;


import lombok.Data;

import java.io.Serializable;
import java.sql.Date;

@Data
public class HospitalRoomExpiringQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long record;

    private Date date;

}
