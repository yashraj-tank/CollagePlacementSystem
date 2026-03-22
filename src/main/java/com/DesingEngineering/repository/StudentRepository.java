package com.DesingEngineering.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.StudentEntity;

@Repository
public interface StudentRepository extends JpaRepository<StudentEntity, Integer> {

    // ========== Authentication ==========
    StudentEntity findByEmail(String email);

    // ========== Filters (branch, batch, faculty) ==========
    List<StudentEntity> findByBranch(String branch);
    List<StudentEntity> findByBatch(String batch);
    List<StudentEntity> findByBranchAndBatch(String branch, String batch);
    List<StudentEntity> findByBranchAndFaculty(String branch, String facultyName);
    List<StudentEntity> findByBranchAndFacultyIsNull(String branch);

    // ========== Counts ==========
    long countByActive(boolean active);
    long countByBranchAndFacultyIsNull(String branch);

    // ========== Aggregated Reports ==========
    @Query(value = "SELECT branch, COUNT(*) FROM students GROUP BY branch", nativeQuery = true)
    List<Object[]> countStudentsByBranch();

    // ========== Recent Records ==========
    @Query(value = "SELECT * FROM students ORDER BY created_at DESC LIMIT 5", nativeQuery = true)
    List<StudentEntity> findRecentStudents();
    
   
    
 // Count verified (status = true)
    long countByStatusTrue();

    // Count rejected (status = false)
    long countByStatusFalse();

    // Count pending (status is null)
    @Query("SELECT COUNT(s) FROM StudentEntity s WHERE s.status IS NULL")
    long countByStatusIsNull();
}