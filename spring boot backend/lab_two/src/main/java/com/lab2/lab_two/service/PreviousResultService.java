package com.lab2.lab_two.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab2.lab_two.model.PreviousResult;
import com.lab2.lab_two.repository.PreviousResultRepository;

@Service
public class PreviousResultService {
    private final PreviousResultRepository previousResultRepository;

    @Autowired
    public PreviousResultService(PreviousResultRepository previousResultRepository) {
        this.previousResultRepository = previousResultRepository;
    }

    public PreviousResult createPreviousResult(int studentId,String department, String level, String course, int credit, String grade) {
        PreviousResult previousResult = new PreviousResult();
        previousResult.setStudentId(studentId);
        previousResult.setDepartment(department);
        previousResult.setLevel(level);
        previousResult.setCourse(course);
        previousResult.setCredit(credit);
        previousResult.setGrade(grade);
        return previousResultRepository.save(previousResult);
    }

    public PreviousResult getPreviousResult(int id) {
        return previousResultRepository.findById(id).orElse(null);
    }

    // Additional methods for updating and deleting previous results can be implemented here
    // ...
}
