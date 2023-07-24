package com.lab2.lab_two.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab2.lab_two.model.EnrolledCourse;
import com.lab2.lab_two.repository.EnrolledCourseRepository;

@Service
public class EnrolledCourseService {
    private final EnrolledCourseRepository enrolledCourseRepository;

    @Autowired
    public EnrolledCourseService(EnrolledCourseRepository enrolledCourseRepository) {
        this.enrolledCourseRepository = enrolledCourseRepository;
    }

    public EnrolledCourse createEnrolledCourse(int studentId,String department, String level, String name, int credit) {
        EnrolledCourse enrolledCourse = new EnrolledCourse();
        enrolledCourse.setStudentId(studentId);
        enrolledCourse.setDepartment(department);
        enrolledCourse.setLevel(level);
        enrolledCourse.setName(name);
        enrolledCourse.setCredit(credit);
        return enrolledCourseRepository.save(enrolledCourse);
    }

    public EnrolledCourse getEnrolledCourse(int id) {
        return enrolledCourseRepository.findById(id).orElse(null);
    }

    // Additional methods for updating and deleting enrolled courses can be implemented here
    // ...
}
