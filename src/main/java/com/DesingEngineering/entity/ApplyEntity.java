package com.DesingEngineering.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "apply")
public class ApplyEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer applyId;
	
	private Integer companyId; //fk company
	private Integer studentId;// fk student
	
	@Column(name = "application_date")
    private LocalDateTime applicationDate;
    
    @PrePersist
    protected void onCreate() {
        applicationDate = LocalDateTime.now();
    }
	
	
	public Integer getApplyId() {
		return applyId;
	}
	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}	

	public LocalDateTime getApplicationDate() { return applicationDate; }
    public void setApplicationDate(LocalDateTime applicationDate) { this.applicationDate = applicationDate; }
}
