package com.AttendanceManager.att_man.Service;

import com.AttendanceManager.att_man.Repository.StudentRepository;
import com.AttendanceManager.att_man.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    public Student saveStudent(Student student) {
        return studentRepository.save(student);
    }

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    // Other CRUD operations as needed
}
