package com.lab2.lab_two.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.*;

import com.lab2.lab_two.model.PreviousResult;
import com.lab2.lab_two.service.PreviousResultService;

@RestController
@RequestMapping("/api/previous-results")
@CrossOrigin(origins = "*")
public class PreviousResultController {
    private final PreviousResultService previousResultService;

    @Autowired
    public PreviousResultController(PreviousResultService previousResultService) {
        this.previousResultService = previousResultService;
    }

    @PostMapping
    public ResponseEntity<PreviousResult> createPreviousResult(@RequestBody PreviousResult previousResult) {
        final PreviousResult createdPreviousResult = previousResultService.createPreviousResult(previousResult.getStudentId(),previousResult.getDepartment(),
        previousResult.getLevel(), previousResult.getCourse(), previousResult.getCredit(), previousResult.getGrade());
        return new ResponseEntity<>(createdPreviousResult, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PreviousResult> getPreviousResult(@PathVariable("id") int id) {
        PreviousResult previousResult = previousResultService.getPreviousResult(id);
        if (previousResult != null) {
            return new ResponseEntity<>(previousResult, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Additional methods for updating and deleting previous results can be implemented here
    // ...
}
