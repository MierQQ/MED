package nsu.mier.backend.VOs;


import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
public class CabinetsUpdateVO extends CabinetsVO implements Serializable {
    private static final long serialVersionUID = 1L;

}
