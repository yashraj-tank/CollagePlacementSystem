package com.DesingEngineering.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "faculty")
public class FacultyEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer facultyId;
	private String facultyName;
	@Column(unique = true,nullable = false)
	private String facultyEmail;
	private String fpassWord;
	private String branch; //fk
	
	public Integer getFacultyId() {
		return facultyId;
	}
	public void setFacultyId(Integer facultyId) {
		this.facultyId = facultyId;
	}
	public String getFacultyName() {
		return facultyName;
	}
	public void setFacultyName(String facultyName) {
		this.facultyName = facultyName;
	}
	public String getFacultyEmail() {
		return facultyEmail;
	}
	public void setFacultyEmail(String facultyEmail) {
		this.facultyEmail = facultyEmail;
	}
	public String getFpassWord() {
		return fpassWord;
	}
	public void setFpassWord(String fpassWord) {
		this.fpassWord = fpassWord;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	
	
	

}
