package com.DesingEngineering.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DesingEngineering.entity.HodEntity;

@Repository
public interface HodRepository extends JpaRepository<HodEntity, Integer> {

}
