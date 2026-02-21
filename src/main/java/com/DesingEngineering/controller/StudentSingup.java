package com.DesingEngineering.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class StudentSingup {

	@GetMapping("/studentlogin")
	public String openStudentlogin() {
		return "StudentLogin";
	}
	
	
	@GetMapping("/studentsingup")
	public String openStudentsingupPage() {
		return"Studentsingup";
	}
}
