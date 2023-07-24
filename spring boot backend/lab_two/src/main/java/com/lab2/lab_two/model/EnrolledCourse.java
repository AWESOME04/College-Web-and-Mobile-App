package com.lab2.lab_two.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "enrolled_courses")
public class EnrolledCourse {
    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "student_id")
    private int studentId;

    @Column(name = "department", nullable = false)
    private String department;

    @Column(name = "level", nullable = false)
    private String level;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "credit", nullable = false)
    private int credit;

    // Constructors
    public EnrolledCourse() {
    }

    public EnrolledCourse(int id, int studentId,String department, String level, String name, int credit) {
        this.id = id;
        this.studentId = studentId;
        this.department = department;
        this.level = level;
        this.name = name;
        this.credit = credit;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

     public String getDepartment() {
        return department;
    }

    public void setDepartment(String department){
        this.department= department;
    }

    public String getLevel(){
        return level;
    }

    public void setLevel(String level){
        this.level = level;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    // Other necessary methods (e.g., toString, equals, hashCode)
    // ...
}
