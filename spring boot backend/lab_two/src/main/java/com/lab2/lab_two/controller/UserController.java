package com.lab2.lab_two.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lab2.lab_two.model.User;
import com.lab2.lab_two.service.UserService;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*") // This allows requests from any origin
public class UserController {
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginRequest loginRequest) {
        try {
            User user = userService.validateUserCredentials(loginRequest.getSchoolId(), loginRequest.getPassword());

            if (user != null) {
                // Authentication successful
                String authToken = generateAuthToken();
                user.setAuthToken(authToken);
                return ResponseEntity.ok().body(user);
            } else {
                // Authentication failed
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
            }
        } catch (Exception e) {
            // Handle any exception that may occur during the login process
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

    private String generateAuthToken() {
        return UUID.randomUUID().toString();
    }

    // Other methods for user registration, retrieval, and management can be added here
    // ...
}
