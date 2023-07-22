package com.lab2.lab_two.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "studentInfo")
public class StudentInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "date_of_birth", nullable = false)
    private Date dateOfBirth;

    @Column(name = "gender", nullable = false)
    private String gender;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "phone", nullable = false)
    private String phone;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "high_school", nullable = false)
    private String highSchool;

    @Column(name = "grade", nullable = false)
    private String grade;

    @Column(name = "gpa", nullable = false)
    private String gpa;

    @Column(name = "financial_aid_status", nullable = false)
    private String financialAidStatus;

    @Column(name = "disability", nullable = false)
    private String disability;

    @Column(name = "scholarships", nullable = false)
    private String scholarships;

    @Column(name = "extracurricular_activities", nullable = false, columnDefinition = "TEXT")
    private String extracurricularActivities;

    @Column(name = "interests", nullable = false, columnDefinition = "TEXT")
    private String interests;

    @Column(name = "goals", nullable = false, columnDefinition = "TEXT")
    private String goals;

    // Constructors
    public StudentInfo() {
    }

    public StudentInfo(String name, Date dateOfBirth, String gender, String address, String phone, String email,
                       String highSchool, String grade, String gpa, String financialAidStatus, String disability,
                       String scholarships, String extracurricularActivities, String interests, String goals) {
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.highSchool = highSchool;
        this.grade = grade;
        this.gpa = gpa;
        this.financialAidStatus = financialAidStatus;
        this.disability = disability;
        this.scholarships = scholarships;
        this.extracurricularActivities = extracurricularActivities;
        this.interests = interests;
        this.goals = goals;
    }

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHighSchool() {
        return highSchool;
    }

    public void setHighSchool(String highSchool) {
        this.highSchool = highSchool;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getGpa() {
        return gpa;
    }

    public void setGpa(String gpa) {
        this.gpa = gpa;
    }

    public String getFinancialAidStatus() {
        return financialAidStatus;
    }

    public void setFinancialAidStatus(String financialAidStatus) {
        this.financialAidStatus = financialAidStatus;
    }

    public String getDisability() {
        return disability;
    }

    public void setDisability(String disability) {
        this.disability = disability;
    }

    public String getScholarships() {
        return scholarships;
    }

    public void setScholarships(String scholarships) {
        this.scholarships = scholarships;
    }

    public String getExtracurricularActivities() {
        return extracurricularActivities;
    }

    public void setExtracurricularActivities(String extracurricularActivities) {
        this.extracurricularActivities = extracurricularActivities;
    }

    public String getInterests() {
        return interests;
    }

    public void setInterests(String interests) {
        this.interests = interests;
    }

    public String getGoals() {
        return goals;
    }

    public void setGoals(String goals) {
        this.goals = goals;
    }

    // Other necessary methods (e.g., toString, equals, hashCode)
    // ...
}
