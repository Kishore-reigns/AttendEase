package com.AttendanceManager.att_man.Repository;

import com.AttendanceManager.att_man.model.Student;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentRepository extends MongoRepository<Student,Long> {

}
