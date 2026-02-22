package com.DesingEngineering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.DesingEngineering.entity.HodEntity;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.HodRepository;

@Controller
public class HodController {
    
    @Autowired
    private HodRepository hodRepository;
    
    @Autowired
    private BranchRepository branchRepository;
    
    // -------------------- Show Signup Form --------------------
    @GetMapping("/hodsignup")
    public String showSignupForm(Model model) {
        model.addAttribute("branchList", branchRepository.findAll());
        return "hodSignup"; // hodSignup.jsp
    }
    
    // -------------------- Save HOD --------------------
    @PostMapping("/savehod")
    public String saveHod(
            @RequestParam("hodName") String hodName,
            @RequestParam("hodEmail") String hodEmail,
            @RequestParam("branch") String branch,
            @RequestParam("hpassWord") String hpassWord,
            Model model) {
        
        try {
            // Check if email already exists
            if (hodRepository.findByHodEmail(hodEmail) != null) {
                model.addAttribute("error", "Email already registered!");
                model.addAttribute("branchList", branchRepository.findAll());
                return "hodSignup";
            }
            
            // Check if branch already has an HOD
            if (hodRepository.findByBranch(branch) != null) {
                model.addAttribute("error", "This branch already has an HOD assigned!");
                model.addAttribute("branchList", branchRepository.findAll());
                return "hodSignup";
            }
            
            // Create new HOD
            HodEntity hod = new HodEntity();
            hod.setHodName(hodName);
            hod.setHodEmail(hodEmail);
            hod.setBranch(branch);
            hod.setHpassWord(hpassWord); // In production, encrypt this!
            
            hodRepository.save(hod);
            
            model.addAttribute("success", "HOD registered successfully!");
            return "hodLogin"; // hodLogin.jsp
            
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            model.addAttribute("branchList", branchRepository.findAll());
            return "hodSignup";
        }
    }
    
    // -------------------- Show Login Form --------------------
    @GetMapping("/hodlogin")
    public String showLoginForm() {
        return "hodLogin"; // hodLogin.jsp
    }
    
    // -------------------- Process Login --------------------
    @PostMapping("/hodlogin")
    public String processLogin(
            @RequestParam("hodEmail") String hodEmail,
            @RequestParam("hpassWord") String hpassWord,
            Model model) {
        
        HodEntity hod = hodRepository.findByHodEmail(hodEmail);
        
        if (hod != null && hod.getHpassWord().equals(hpassWord)) {
            // Successful login – store in session if needed
            model.addAttribute("hod", hod);
            return "redirect:/hod/dashboard"; // or redirect to a dashboard page
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "hodLogin";
        }
    }
    
    // -------------------- List All HODs --------------------
    @GetMapping("/listhod")
    public String listAllHods(Model model) {
        List<HodEntity> hodList = hodRepository.findAll();
        model.addAttribute("hodList", hodList);
        return "hodList"; // hodList.jsp
    }
    
    // -------------------- Delete HOD --------------------
    @GetMapping("/deletehod/{id}")
    public String deleteHod(@PathVariable("id") Integer id) {
        hodRepository.deleteById(id);
        return "redirect:/listhod";
    }
    
    // -------------------- Show Edit Form --------------------
    @GetMapping("/edithod/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        HodEntity hod = hodRepository.findById(id).orElse(null);
        if (hod == null) {
            return "redirect:/listhod";
        }
        model.addAttribute("hod", hod);
        model.addAttribute("branchList", branchRepository.findAll());
        return "editHod"; // editHod.jsp
    }
    
    // -------------------- Update HOD --------------------
    @PostMapping("/updatehod")
    public String updateHod(
            @RequestParam("hodId") Integer hodId,
            @RequestParam("hodName") String hodName,
            @RequestParam("hodEmail") String hodEmail,
            @RequestParam("branch") String branch,
            @RequestParam("hpassWord") String hpassWord) {
        
        HodEntity hod = hodRepository.findById(hodId).orElse(null);
        if (hod != null) {
            hod.setHodName(hodName);
            // Email is usually not changed, but if you want to allow it, remove the read-only in JSP
            hod.setHodEmail(hodEmail);
            hod.setBranch(branch);
            hod.setHpassWord(hpassWord);
            hodRepository.save(hod);
        }
        return "redirect:/listhod";
    }
    
    // -------------------- HOD Dashboard (optional) --------------------
    @GetMapping("/hod/dashboard")
    public String hodDashboard(Model model) {
        // You can add any data needed for the HOD dashboard
        return "hodDashboard"; // hodDashboard.jsp (create if needed)
    }
}