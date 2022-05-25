package nsu.mier.backend.DTOs;


import lombok.Data;

import java.io.Serializable;
import java.sql.Date;

@Data
public class PatientDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;

    private String name;

    private Date birthDay;

}
