package com.DesingEngineering.controller;

import org.springframework.stereotype.Controller;
import java.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.DesingEngineering.entity.AdminEntity;
import com.DesingEngineering.repository.AdminRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminSingController {
	
	@Autowired
    private AdminRepository adminRepository;
    
    @GetMapping("/adminsignup")
    public String showAdminSignupForm(Model model) {
        return "adminSignup";
    }
    
    @PostMapping("/saveadmin")
    public String saveAdmin(
            @RequestParam("adminName") String adminName,
            @RequestParam("adminEmail") String adminEmail,
            @RequestParam("apassWord") String apassWord,
            Model model) {
        
        try {
            // Check if email already exists
            if (adminRepository.findByAdminEmail(adminEmail) != null) {
                model.addAttribute("error", "Email already registered!");
                return "adminSignup";
            }
            
            // Create new admin entity
            AdminEntity admin = new AdminEntity();
            admin.setAdminName(adminName);
            admin.setAdminEmail(adminEmail);
            admin.setApassWord(apassWord); // In production, encrypt this!
            
            // Save to database
            adminRepository.save(admin);
            
            model.addAttribute("success", "Admin registered successfully!");
            return "adminLogin"; // Redirect to login page
            
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "adminSignup";
        }
    }
    
    @GetMapping("/adminlogin")
    public String showAdminLoginForm() {
        return "adminLogin";
    }
    
    @PostMapping("/adminlogin")
    public String loginAdmin(
            @RequestParam("adminEmail") String adminEmail,
            @RequestParam("apassWord") String apassWord,
            Model model,HttpSession session) {
        
        AdminEntity admin = adminRepository.findByAdminEmail(adminEmail);
        
        if (admin != null && admin.getApassWord().equals(apassWord)) {
            // Successful login
            model.addAttribute("admin", admin);
            session.setAttribute("admin", admin);
            return "redirect:/admin/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "adminLogin";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
    	session.invalidate();
    	return "adminLogin";
    }
}


