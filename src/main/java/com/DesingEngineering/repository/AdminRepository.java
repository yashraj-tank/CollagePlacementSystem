package com.DesingEngineering.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.AdminEntity;

@Repository
public interface AdminRepository extends JpaRepository<AdminEntity, Integer> {
	
	//Find admin by email
    AdminEntity findByAdminEmail(String adminEmail);
    
    // Check if email exists
    boolean existsByAdminEmail(String adminEmail);

}
