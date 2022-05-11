package nsu.mier.backend.servises;

import nsu.mier.backend.entities.Query1Entity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
public class Query1Service {
    public List<Query1Entity> readAll() {
        return new LinkedList<Query1Entity>();
    }
}
