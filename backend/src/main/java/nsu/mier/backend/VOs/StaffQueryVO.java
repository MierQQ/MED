package nsu.mier.backend.VOs;


import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class StaffQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;

    private String specialization;

    private Long salary;

    private String type;

    private Date employmentDate;

}
