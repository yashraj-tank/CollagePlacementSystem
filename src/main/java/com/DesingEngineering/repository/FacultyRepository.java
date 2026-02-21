package com.DesingEngineering.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.FacultyEntity;

@Repository
public interface FacultyRepository extends JpaRepository<FacultyEntity, Integer>{

}
