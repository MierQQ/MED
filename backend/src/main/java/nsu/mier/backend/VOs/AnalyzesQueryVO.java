package nsu.mier.backend.VOs;


import lombok.Data;

import java.io.Serializable;

@Data
public class AnalyzesQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long record;

    private Long labId;

}
