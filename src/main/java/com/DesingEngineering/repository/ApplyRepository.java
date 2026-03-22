package com.DesingEngineering.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.ApplyEntity;

@Repository
public interface ApplyRepository extends JpaRepository <ApplyEntity,Integer>{
	
	ApplyEntity findByStudentIdAndCompanyId(Integer studentId, Integer companyId);
	
	// Fetch all applications with student and company details
    @Query("SELECT a, s, c FROM ApplyEntity a, StudentEntity s, CompanyEntity c " +
           "WHERE a.studentId = s.studentId AND a.companyId = c.companyId")
    List<Object[]> findAllApplicationsWithDetails();
    
    List<ApplyEntity> findByCompanyId(Integer companyId);
    
 // In ApplyRepository.java
    @Query("SELECT a, s, c FROM ApplyEntity a, StudentEntity s, CompanyEntity c " +
           "WHERE a.studentId = s.studentId AND a.companyId = c.companyId AND a.companyId = :companyId")
    List<Object[]> findApplicationsByCompanyId(@Param("companyId") Integer companyId);
    
 // Count applications per company
    @Query("SELECT c.name, COUNT(a) FROM ApplyEntity a JOIN CompanyEntity c ON a.companyId = c.companyId GROUP BY c.name")
    List<Object[]> countApplicationsByCompany();

}
