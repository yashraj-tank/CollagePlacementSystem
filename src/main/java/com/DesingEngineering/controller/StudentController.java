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
import com.DesingEngineering.service.EmailService;
import com.DesingEngineering.service.MailerService;

import jakarta.servlet.http.HttpSession;


@Controller
public class StudentController {
	
	@Autowired
	StudentRepository studentRepository;
	
	@Autowired
	BranchRepository branchRepository;
	
	@Autowired
	BatchRepository batchRepository;
	
	@Autowired
	MailerService mailerService;
	
	@Autowired
	private EmailService emailService;

	
	@GetMapping("/studentsingup")
	public String opensavestudentsingup(Model model) {
		model.addAttribute("branchList",branchRepository.findAll());
		model.addAttribute("batchList",batchRepository.findAll());
		return "Studentsingup";
	}
	
	@GetMapping("/studentlogin")
	public String openstudentlogin() {
		return  "StudentLogin";
	}
	@PostMapping("savestudent")
	public String savestudent(StudentEntity studentEntity) {
		studentEntity.setActive(true);
		studentEntity.setCreatedAt(LocalDate.now());
		studentRepository.save(studentEntity);
		
		//Welcome mail send to student
		mailerService.sendWelcomeMail(studentEntity);
		
		return "StudentLogin";
	}	
	
	// -------------------- Student Login --------------------
	@PostMapping("/studentlogin")
	public String studentLogin(
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			Model model,HttpSession session) {
		
		// Find student by email (you need to add this method in StudentRepository)
		StudentEntity student = studentRepository.findByEmail(email);
		
		if (student != null && student.getPassword().equals(password)) {
			// Successful login – store student in session
			session.setAttribute("student", student);
			return "redirect:/student/dashboard"; // Redirect to student dashboard (create later)
		} else {
			model.addAttribute("error", "Invalid email or password!");
			return "StudentLogin";
		}
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
	        students = studentRepository.findAll();
	    }
	    
	    model.addAttribute("studentList", students);
	    return "studentList";
	}
	
	//Student forget password
	@GetMapping("/studentforgetpassword")
	public String studentforgetpassword() {
		return "StudentForgetP";
	}
	
	@PostMapping("/forgot-password")
	public String processForgotPassword(@RequestParam("email") String email, Model model) {
	    // 1. Check if student exists
	    StudentEntity student = studentRepository.findByEmail(email);
	    if (student == null) {
	        model.addAttribute("error", "Email not registered!");
	        return "ForgotPassword";   // return to the same page with error
	    }

	    // 2. Generate 6-digit OTP
	    String otp = String.valueOf((int)(Math.random() * 900000) + 100000);

	    // 3. Save OTP to database
	    student.setOtp(otp);
	    studentRepository.save(student);

	    // 4. Send OTP via email
	    emailService.sendOtpEmail(email, otp);

	    // 5. Pass email to the next page (OTP verification)
	    model.addAttribute("email", email);
	    return "VerifyOtp";   // you will create this JSP next
	}
	
	@PostMapping("/verify-otp")
	public String verifyOtp(@RequestParam("email") String email,
	                        @RequestParam("otp") String otp,
	                        Model model) {
	    StudentEntity student = studentRepository.findByEmail(email);
	    if (student == null) {
	        return "redirect:/forgot-password"; // shouldn't happen, but safe
	    }

	    // Compare OTP (simple string equality)
	    if (otp.equals(student.getOtp())) {
	        // OTP correct – allow password reset
	        model.addAttribute("email", email);
	        return "ResetPassword";
	    } else {
	        model.addAttribute("error", "Invalid OTP. Please try again.");
	        model.addAttribute("email", email);
	        return "VerifyOtp";
	    }
	}
	
	@PostMapping("/reset-password")
	public String resetPassword(@RequestParam("email") String email,
	                            @RequestParam("newPassword") String newPassword,
	                            @RequestParam("confirmPassword") String confirmPassword,
	                            Model model) {
	    if (!newPassword.equals(confirmPassword)) {
	        model.addAttribute("error", "Passwords do not match.");
	        model.addAttribute("email", email);
	        return "ResetPassword";
	    }

	    StudentEntity student = studentRepository.findByEmail(email);
	    if (student == null) {
	        return "redirect:/forgot-password";
	    }

	    // Update password (in production, encode it!)
	    student.setPassword(newPassword);
	    // Clear OTP so it cannot be reused
	    student.setOtp(null);
	    studentRepository.save(student);

	    model.addAttribute("success", "Password updated successfully. Please login.");
	    return "StudentLogin"; // redirect to login page with success message
	}
	
	
}












