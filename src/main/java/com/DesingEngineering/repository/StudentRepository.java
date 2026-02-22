package com.DesingEngineering.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.StudentEntity;



@Repository
public interface StudentRepository extends JpaRepository<StudentEntity, Integer> {
	
	// Find students by both branch and batch
    List<StudentEntity> findByBranchAndBatch(String branch, String batch);

    // Find students by branch only
    List<StudentEntity> findByBranch(String branch);

    // Find students by batch only
    List<StudentEntity> findByBatch(String batch);
    
    // Count active/inactive students
    long countByActive(boolean active);
    
    // Get recent students (last 5) - Using correct table name "students"
    @Query(value = "SELECT * FROM students ORDER BY created_at DESC LIMIT 5", nativeQuery = true)
    List<StudentEntity> findRecentStudents();
    
    // Optional: Get students by branch with count
    @Query(value = "SELECT branch, COUNT(*) FROM students GROUP BY branch", nativeQuery = true)
    List<Object[]> countStudentsByBranch();

}
