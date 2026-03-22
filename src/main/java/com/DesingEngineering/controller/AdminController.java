package com.DesingEngineering.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.DesingEngineering.entity.CompanyEntity;
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
    
    @Autowired
    private ApplyRepository applyRepository;

    @Autowired
    private CompanyRepository companyRepository;

    @GetMapping("/admin/applications")
    public String listApplications(@RequestParam(required = false) Integer companyId,
                                   Model model) {
        List<Object[]> applications;
        if (companyId != null && companyId > 0) {
            applications = applyRepository.findApplicationsByCompanyId(companyId);
        } else {
            applications = applyRepository.findAllApplicationsWithDetails();
        }

        // For the filter dropdown
        List<CompanyEntity> allCompanies = companyRepository.findAll();
        model.addAttribute("companies", allCompanies);
        model.addAttribute("selectedCompanyId", companyId);
        model.addAttribute("applications", applications);
        model.addAttribute("facultyCount", facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
        model.addAttribute("studentCount", studentRepository.count());
        model.addAttribute("batchCount", batchRepository.count());
        model.addAttribute("branchCount", branchRepository.count());
        return "adminApplications";
    }
    
    @GetMapping("/admin/reports")
    public String showReports(Model model) {
        // Students by branch
        List<Object[]> studentsByBranch = studentRepository.countStudentsByBranch();
        model.addAttribute("studentsByBranch", studentsByBranch);

        // Applications by company
        List<Object[]> appsByCompany = applyRepository.countApplicationsByCompany();
        model.addAttribute("appsByCompany", appsByCompany);

        // Placement status – three categories
        long verified = studentRepository.countByStatusTrue();     // placed
        long rejected = studentRepository.countByStatusFalse();    // rejected
        long pending = studentRepository.countByStatusIsNull();    // pending

        model.addAttribute("verified", verified);
        model.addAttribute("rejected", rejected);
        model.addAttribute("pending", pending);

        model.addAttribute("facultyCount", facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
        model.addAttribute("studentCount", studentRepository.count());
        model.addAttribute("batchCount", batchRepository.count());
        model.addAttribute("branchCount", branchRepository.count());
        
        return "adminReports";
    }
}