package nsu.mier.backend.VOs;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;


@Data
public class StaffVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "id can not null")
    private Long id;

    private String name;

    private String specialization;

    private Long salary;

    private String type;

    private Date employmentDate;

}
