package com.lab2.lab_two.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab2.lab_two.model.Student;
import com.lab2.lab_two.repository.StudentRepository;

@Service
public class StudentService {
    private final StudentRepository studentRepository;

    @Autowired
    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public Student createStudent(String name, String bio, String email, Date dateOfBirth, String department,
                                 int level, String semester) {
        Student student = new Student();
        student.setName(name);
        student.setBio(bio);
        student.setEmail(email);
        student.setDateOfBirth(dateOfBirth);
        student.setDepartment(department);
        student.setLevel(level);
        student.setSemester(semester);
        return studentRepository.save(student);
    }

    public Student getStudent(int id) {
        return studentRepository.findById(id).orElse(null);
    }

    public Student createStudent(String name, String sid, char sex) {
        return null;
    }

    // Additional methods for updating and deleting students can be implemented here
    // ...
}
