package com.DesingEngineering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.DesingEngineering.entity.FacultyEntity;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.FacultyRepository;
import com.DesingEngineering.repository.HodRepository;  // <-- ADD THIS IMPORT

@Controller
public class FacultyController {

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private BranchRepository branchRepository;

    @Autowired
    private HodRepository hodRepository;  // <-- ADD THIS TO GET HOD COUNT

    // Helper method to add common sidebar attributes
    private void addSidebarAttributes(Model model) {
        model.addAttribute("facultyCount", facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
    }

    // -------------------- Show Signup Form --------------------
    @GetMapping("/facultysignup")
    public String showSignupForm(Model model) {
        model.addAttribute("branchList", branchRepository.findAll());
        addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS
        return "facultySignup";
    }

    // -------------------- Save Faculty --------------------
    @PostMapping("/savefaculty")
    public String saveFaculty(
            @RequestParam("facultyName") String facultyName,
            @RequestParam("facultyEmail") String facultyEmail,
            @RequestParam("branch") String branch,
            @RequestParam("fpassWord") String fpassWord,
            Model model) {

        try {
            // Check if email already exists
            if (facultyRepository.findByFacultyEmail(facultyEmail) != null) {
                model.addAttribute("error", "Email already registered!");
                model.addAttribute("branchList", branchRepository.findAll());
                addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS
                return "facultySignup";
            }

            // Create new Faculty
            FacultyEntity faculty = new FacultyEntity();
            faculty.setFacultyName(facultyName);
            faculty.setFacultyEmail(facultyEmail);
            faculty.setBranch(branch);
            faculty.setFpassWord(fpassWord); // In production, encrypt!

            facultyRepository.save(faculty);

            model.addAttribute("success", "Faculty registered successfully!");
            return "facultyLogin";

        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            model.addAttribute("branchList", branchRepository.findAll());
            addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS
            return "facultySignup";
        }
    }

    // -------------------- Show Login Form --------------------
    @GetMapping("/facultylogin")
    public String showLoginForm(Model model) {
        addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS (if login page has sidebar)
        return "facultyLogin";
    }

    // -------------------- Process Login --------------------
    @PostMapping("/facultylogin")
    public String processLogin(
            @RequestParam("facultyEmail") String facultyEmail,
            @RequestParam("fpassWord") String fpassWord,
            Model model) {

        FacultyEntity faculty = facultyRepository.findByFacultyEmail(facultyEmail);

        if (faculty != null && faculty.getFpassWord().equals(fpassWord)) {
            model.addAttribute("faculty", faculty);
            return "redirect:/faculty/dashboard"; // optional dashboard
        } else {
            model.addAttribute("error", "Invalid email or password!");
            addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS
            return "facultyLogin";
        }
    }

    // -------------------- List All Faculty --------------------
    @GetMapping("/listfaculty")
    public String listAllFaculty(Model model) {
        List<FacultyEntity> facultyList = facultyRepository.findAll();
        model.addAttribute("facultyList", facultyList);
        addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS
        return "facultyList";
    }

    // -------------------- Delete Faculty --------------------
    @GetMapping("/deletefaculty/{id}")
    public String deleteFaculty(@PathVariable("id") Integer id) {
        facultyRepository.deleteById(id);
        return "redirect:/listfaculty";
    }

    // -------------------- Show Edit Form --------------------
    @GetMapping("/editfaculty/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        FacultyEntity faculty = facultyRepository.findById(id).orElse(null);
        if (faculty == null) {
            return "redirect:/listfaculty";
        }
        model.addAttribute("faculty", faculty);
        model.addAttribute("branchList", branchRepository.findAll());
        addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS
        return "editFaculty";
    }

    // -------------------- Update Faculty --------------------
    @PostMapping("/updatefaculty")
    public String updateFaculty(
            @RequestParam("facultyId") Integer facultyId,
            @RequestParam("facultyName") String facultyName,
            @RequestParam("facultyEmail") String facultyEmail,
            @RequestParam("branch") String branch,
            @RequestParam("fpassWord") String fpassWord) {

        FacultyEntity faculty = facultyRepository.findById(facultyId).orElse(null);
        if (faculty != null) {
            faculty.setFacultyName(facultyName);
            faculty.setFacultyEmail(facultyEmail);
            faculty.setBranch(branch);
            faculty.setFpassWord(fpassWord);
            facultyRepository.save(faculty);
        }
        return "redirect:/listfaculty";
    }

    // -------------------- Faculty Dashboard (optional) --------------------
    @GetMapping("/faculty/dashboard")
    public String facultyDashboard(Model model) {
        addSidebarAttributes(model);   // <-- ADD SIDEBAR COUNTS
        return "facultyDashboard";
    }
}