package com.lab2.lab_two.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab2.lab_two.model.User;
import com.lab2.lab_two.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User validateUserCredentials(String schoolId, String password) {
        User user = userRepository.findBySchoolId(schoolId);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    // Other methods for user registration, retrieval, and management can be added here
    // ...
}
