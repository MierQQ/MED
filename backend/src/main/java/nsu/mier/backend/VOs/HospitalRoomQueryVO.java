package nsu.mier.backend.VOs;


import lombok.Data;

import java.io.Serializable;

@Data
public class HospitalRoomQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long departmentId;

    private Long bedNumber;

}
