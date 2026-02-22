package com.DesingEngineering.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "hod")
public class HodEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer hodId;
	private String hodName;
	private String hodEmail;
	private String hpassWord;
	private String branch; //fk
	
	public Integer getHodId() {
		return hodId;
	}
	public void setHodId(Integer hodId) {
		this.hodId = hodId;
	}
	public String getHodName() {
		return hodName;
	}
	public void setHodName(String hodName) {
		this.hodName = hodName;
	}
	public String getHodEmail() {
		return hodEmail;
	}
	public void setHodEmail(String hodEmail) {
		this.hodEmail = hodEmail;
	}
	public String getHpassWord() {
		return hpassWord;
	}
	public void setHpassWord(String hpassWord) {
		this.hpassWord = hpassWord;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
		
	
}
