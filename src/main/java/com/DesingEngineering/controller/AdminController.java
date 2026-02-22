package com.DesingEngineering.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.DesingEngineering.entity.StudentEntity;
import com.DesingEngineering.repository.*;

@Controller
public class AdminController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private BranchRepository branchRepository;

    @Autowired
    private BatchRepository batchRepository;

    // Add these two new fields
    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private HodRepository hodRepository;

    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {

        // Basic counts
        long totalStudents = studentRepository.count();
        long activeStudents = studentRepository.countByActive(true);
        long inactiveStudents = studentRepository.countByActive(false);

        long totalBatches = batchRepository.count();
        long totalBranches = branchRepository.count();

        // Faculty & HOD counts
        long totalFaculty = facultyRepository.count();
        long totalHod = hodRepository.count();

        // Recent students
        List<StudentEntity> recentStudents = studentRepository.findRecentStudents();

        // Students by branch (for chart)
        List<Object[]> studentsByBranch = studentRepository.countStudentsByBranch();

        model.addAttribute("totalStudents", totalStudents);
        model.addAttribute("activeStudents", activeStudents);
        model.addAttribute("inactiveStudents", inactiveStudents);
        model.addAttribute("totalBatches", totalBatches);
        model.addAttribute("totalBranches", totalBranches);
        model.addAttribute("recentStudents", recentStudents);
        model.addAttribute("studentsByBranch", studentsByBranch);

        // Sidebar badges (including faculty and hod)
        model.addAttribute("studentCount", totalStudents);
        model.addAttribute("batchCount", totalBatches);
        model.addAttribute("branchCount", totalBranches);
        model.addAttribute("facultyCount", totalFaculty);
        model.addAttribute("hodCount", totalHod);

        return "adminDashboard";
    }
}