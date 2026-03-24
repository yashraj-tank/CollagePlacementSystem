package com.DesingEngineering.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.FacultyEntity;

@Repository
public interface FacultyRepository extends JpaRepository<FacultyEntity, Integer>{
	
	FacultyEntity findByFacultyEmail(String facultyEmail);

    List<FacultyEntity> findAllByBranch(String branch);

    boolean existsByFacultyEmail(String facultyEmail);

    List<FacultyEntity> findByBranch(String branch);
    
    
}
