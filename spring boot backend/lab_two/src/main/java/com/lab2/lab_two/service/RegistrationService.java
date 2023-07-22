package com.lab2.lab_two.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab2.lab_two.model.Registration;
import com.lab2.lab_two.repository.RegistrationRepository;

@Service
public class RegistrationService {
    private final RegistrationRepository registrationRepository;

    @Autowired
    public RegistrationService(RegistrationRepository registrationRepository) {
        this.registrationRepository = registrationRepository;
    }

    public Registration createRegistration(Registration registration) {
        return registrationRepository.save(registration);
    }

    public Registration getRegistration(Long id) {
        return registrationRepository.findById(id).orElse(null);
    }

    public Registration updateRegistration(Long id, Registration updatedRegistration) {
        Registration existingRegistration = registrationRepository.findById(id).orElse(null);
        if (existingRegistration != null) {
            existingRegistration.setFirstName(updatedRegistration.getFirstName());
            existingRegistration.setLastName(updatedRegistration.getLastName());
            existingRegistration.setEmail(updatedRegistration.getEmail());
            existingRegistration.setDepartment(updatedRegistration.getDepartment());
            existingRegistration.setLevel(updatedRegistration.getLevel());
            existingRegistration.setGender(updatedRegistration.getGender());
            existingRegistration.setDob(updatedRegistration.getDob());
            existingRegistration.setAddress(updatedRegistration.getAddress());
            existingRegistration.setPhone(updatedRegistration.getPhone());
            existingRegistration.setSchoolId(updatedRegistration.getSchoolId());
            existingRegistration.setPassword(updatedRegistration.getPassword());
            return registrationRepository.save(existingRegistration);
        }
        return null;
    }

    public boolean deleteRegistration(Long id) {
        Registration registration = registrationRepository.findById(id).orElse(null);
        if (registration != null) {
            registrationRepository.delete(registration);
            return true;
        }
        return false;
    }
}
