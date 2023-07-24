package com.lab2.lab_two.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "assignments")
public class Assignment {
    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "department", nullable = false)
    private String department;

    @Column(name = "level", nullable = false)
    private String level;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "due_date", nullable = false)
    private Date dueDate;

    // Constructors
    public Assignment() {
    }

    public Assignment(int id, String department, String level,String title, Date dueDate) {
        this.id = id;
        this.department = department;
        this.level = level;
        this.title = title;
        this.dueDate = dueDate;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    // Other necessary methods (e.g., toString, equals, hashCode)
    // ...
}
