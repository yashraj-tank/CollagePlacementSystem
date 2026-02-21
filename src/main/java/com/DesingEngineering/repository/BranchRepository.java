package com.DesingEngineering.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.BranchEntity;

@Repository
public interface BranchRepository extends JpaRepository<BranchEntity, Integer> {

}
