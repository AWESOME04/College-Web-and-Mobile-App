package com.lab2.lab_two.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.*;

import com.lab2.lab_two.model.Assignment;
import com.lab2.lab_two.service.AssignmentService;

@RestController
@RequestMapping("/api/assignments")
@CrossOrigin(origins = "*")
public class AssignmentController {
    private final AssignmentService assignmentService;

    @Autowired
    public AssignmentController(AssignmentService assignmentService) {
        this.assignmentService = assignmentService;
    }

    @PostMapping
    public ResponseEntity<Assignment> createAssignment(@RequestBody Assignment assignment) {
        final Assignment createdAssignment = assignmentService.createAssignment( assignment.getDepartment(),
        assignment.getLevel(),assignment.getTitle(), assignment.getDueDate());
        return new ResponseEntity<>(createdAssignment, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Assignment> getAssignment(@PathVariable("id") int id) {
        Assignment assignment = assignmentService.getAssignment(id);
        if (assignment != null) {
            return new ResponseEntity<>(assignment, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Additional methods for updating and deleting assignments can be implemented here
    // ...
}
