package com.lab2.lab_two.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab2.lab_two.model.StudentInfo;
import com.lab2.lab_two.repository.StudentInfoRepository;

@Service
public class StudentInfoService {
    private final StudentInfoRepository studentInfoRepository;

    @Autowired
    public StudentInfoService(StudentInfoRepository studentInfoRepository) {
        this.studentInfoRepository = studentInfoRepository;
    }

    public StudentInfo createStudentInfo(StudentInfo studentInfo) {
        return studentInfoRepository.save(studentInfo);
    }

    public StudentInfo getStudentInfo(Long id) {
        return studentInfoRepository.findById(id).orElse(null);
    }

    public StudentInfo updateStudentInfo(StudentInfo updatedStudentInfo) {
        return studentInfoRepository.save(updatedStudentInfo);
    }

    public void deleteStudentInfo(Long id) {
        studentInfoRepository.deleteById(id);
    }
}

