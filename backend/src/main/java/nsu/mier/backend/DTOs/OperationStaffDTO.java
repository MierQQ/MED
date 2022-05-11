package nsu.mier.backend.DTOs;


import lombok.Data;

import java.io.Serializable;

@Data
public class OperationStaffDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;

    private Long numOfSurgeries;

    private Long numOfFatalSurgeries;

}