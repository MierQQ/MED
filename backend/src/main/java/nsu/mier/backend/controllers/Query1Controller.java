package nsu.mier.backend.controllers;

import nsu.mier.backend.entities.Query1Entity;
import nsu.mier.backend.servises.Query1Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class Query1Controller {
    private final Query1Service service;

    @Autowired
    public Query1Controller(Query1Service service) {
        this.service = service;
    }

    @GetMapping(value = "/query1")
    public ResponseEntity<List<Query1Entity>> read() {
        var query1Entities = service.readAll();
        return query1Entities != null ? new ResponseEntity<>(query1Entities, HttpStatus.OK) : new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}
