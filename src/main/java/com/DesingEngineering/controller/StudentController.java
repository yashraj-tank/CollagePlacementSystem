package com.DesingEngineering.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.DesingEngineering.entity.StudentEntity;
import com.DesingEngineering.repository.BatchRepository;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.StudentRepository;

@Controller
public class StudentController {
	
	@Autowired
	StudentRepository studentRepository;
	
	@Autowired
	BranchRepository branchRepository;
	
	@Autowired
	BatchRepository batchRepository;
	
	@GetMapping("/studentsingup")
	public String opensavestudentsingup(Model model) {
		
		model.addAttribute("branchList",branchRepository.findAll());
		model.addAttribute("batchList",batchRepository.findAll());
		return "Studentsingup";
	}
	
	@PostMapping("savestudent")
	public String savestudent(StudentEntity studentEntity) {
		
		studentEntity.setActive(true);
		studentEntity.setCreatedAt(LocalDate.now());
		studentRepository.save(studentEntity);
		
		return "StudentLogin";
	}	
	
	@GetMapping("/filterStudents")
	public String filterStudents(
	        @RequestParam(required = false) String branch,
	        @RequestParam(required = false) String batch,
	        Model model) {
	    
	    model.addAttribute("branchList", branchRepository.findAll());
	    model.addAttribute("batchList", batchRepository.findAll());
	    
	    List<StudentEntity> students;
	    if (branch != null && !branch.isEmpty() && batch != null && !batch.isEmpty()) {
	        students = studentRepository.findByBranchAndBatch(branch, batch);
	    } else if (branch != null && !branch.isEmpty()) {
	        students = studentRepository.findByBranch(branch);
	    } else if (batch != null && !batch.isEmpty()) {
	        students = studentRepository.findByBatch(batch);
	    } else {
	        students = studentRepository.findAll(); // or empty list
	    }
	    
	    model.addAttribute("studentList", students);
	    return "studentList"; // your JSP name
	}


}
