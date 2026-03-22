package com.DesingEngineering.repository;

import com.DesingEngineering.entity.CompanyEntity;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CompanyRepository extends JpaRepository<CompanyEntity, Integer> {
	
	List<CompanyEntity> findByBranch(String branch);
}