package com.DesingEngineering.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.StudentEntity;



@Repository
public interface StudentRepository extends JpaRepository<StudentEntity, Integer> {

}
