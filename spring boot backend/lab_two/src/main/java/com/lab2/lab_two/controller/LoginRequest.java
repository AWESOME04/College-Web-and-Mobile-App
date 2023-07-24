package com.lab2.lab_two.controller;

public class LoginRequest {
    private String schoolId;
    private String password;

    // Getters and setters

    public String getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(String schoolId) {
        this.schoolId = schoolId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
