package com.DesingEngineering.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.DesingEngineering.entity.HodEntity;

@Repository
public interface HodRepository extends JpaRepository<HodEntity, Integer> {
    
    // Find HOD by email
    HodEntity findByHodEmail(String hodEmail);
    
    // Find HOD by branch
    HodEntity findByBranch(String branch);
    
    // Check if email exists
    boolean existsByHodEmail(String hodEmail);
    
    // Find all HODs for a specific branch
    List<HodEntity> findAllByBranch(String branch);
}