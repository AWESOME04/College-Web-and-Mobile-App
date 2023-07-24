package com.lab2.lab_two.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lab2.lab_two.model.StudentInfo;
import com.lab2.lab_two.service.StudentInfoService;

@RestController
@RequestMapping("/api/student-info")
@CrossOrigin(origins = "*")
public class StudentInfoController {
    private final StudentInfoService studentInfoService;

    @Autowired
    public StudentInfoController(StudentInfoService studentInfoService) {
        this.studentInfoService = studentInfoService;
    }

    @PostMapping
    public ResponseEntity<StudentInfo> createStudentInfo(@RequestBody StudentInfo studentInfo) {
        StudentInfo createdStudentInfo = studentInfoService.createStudentInfo(studentInfo);
        return new ResponseEntity<>(createdStudentInfo, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<StudentInfo> getStudentInfo(@PathVariable("id") Long id) {
        StudentInfo studentInfo = studentInfoService.getStudentInfo(id);
        if (studentInfo != null) {
            return new ResponseEntity<>(studentInfo, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<StudentInfo> updateStudentInfo(@PathVariable("id") Long id, @RequestBody StudentInfo updatedStudentInfo) {
        StudentInfo existingStudentInfo = studentInfoService.getStudentInfo(id);
        if (existingStudentInfo != null) {
            existingStudentInfo.setName(updatedStudentInfo.getName());
            existingStudentInfo.setDateOfBirth(updatedStudentInfo.getDateOfBirth());
            existingStudentInfo.setGender(updatedStudentInfo.getGender());
            existingStudentInfo.setAddress(updatedStudentInfo.getAddress());
            existingStudentInfo.setPhone(updatedStudentInfo.getPhone());
            existingStudentInfo.setEmail(updatedStudentInfo.getEmail());
            existingStudentInfo.setHighSchool(updatedStudentInfo.getHighSchool());
            existingStudentInfo.setGrade(updatedStudentInfo.getGrade());
            existingStudentInfo.setGpa(updatedStudentInfo.getGpa());
            existingStudentInfo.setFinancialAidStatus(updatedStudentInfo.getFinancialAidStatus());
            existingStudentInfo.setDisability(updatedStudentInfo.getDisability());
            existingStudentInfo.setScholarships(updatedStudentInfo.getScholarships());
            existingStudentInfo.setExtracurricularActivities(updatedStudentInfo.getExtracurricularActivities());
            existingStudentInfo.setInterests(updatedStudentInfo.getInterests());
            existingStudentInfo.setGoals(updatedStudentInfo.getGoals());

            StudentInfo updatedStudent = studentInfoService.updateStudentInfo(existingStudentInfo);
            return new ResponseEntity<>(updatedStudent, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteStudentInfo(@PathVariable("id") Long id) {
        StudentInfo existingStudentInfo = studentInfoService.getStudentInfo(id);
        if (existingStudentInfo != null) {
            studentInfoService.deleteStudentInfo(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

