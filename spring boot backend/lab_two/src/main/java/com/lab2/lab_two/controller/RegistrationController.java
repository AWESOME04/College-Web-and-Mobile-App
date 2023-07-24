package com.lab2.lab_two.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lab2.lab_two.model.Registration;
import com.lab2.lab_two.service.RegistrationService;

@RestController
@RequestMapping("/api/registrations")
@CrossOrigin(origins = "*")
public class RegistrationController {
    private final RegistrationService registrationService;

    @Autowired
    public RegistrationController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    @PostMapping
    public ResponseEntity<Registration> createRegistration(@RequestBody Registration registration) {
        Registration createdRegistration = registrationService.createRegistration(registration);
        return new ResponseEntity<>(createdRegistration, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Registration> getRegistration(@PathVariable("id") Long id) {
        Registration registration = registrationService.getRegistration(id);
        if (registration != null) {
            return new ResponseEntity<>(registration, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Registration> updateRegistration(@PathVariable("id") Long id, @RequestBody Registration registration) {
        Registration updatedRegistration = registrationService.updateRegistration(id, registration);
        if (updatedRegistration != null) {
            return new ResponseEntity<>(updatedRegistration, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRegistration(@PathVariable("id") Long id) {
        boolean deleted = registrationService.deleteRegistration(id);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
