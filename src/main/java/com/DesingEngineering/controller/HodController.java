package com.DesingEngineering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.DesingEngineering.entity.CompanyEntity;
import com.DesingEngineering.entity.FacultyEntity;
import com.DesingEngineering.entity.HodEntity;
import com.DesingEngineering.entity.StudentEntity;
import com.DesingEngineering.repository.BatchRepository;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.CompanyRepository;
import com.DesingEngineering.repository.FacultyRepository;
import com.DesingEngineering.repository.HodRepository;
import com.DesingEngineering.repository.StudentRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class HodController {
    
    @Autowired
    private HodRepository hodRepository;
    
    @Autowired
    private BranchRepository branchRepository;
    
    @Autowired
    private FacultyRepository facultyRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    BatchRepository batchRepository;
    
    @Autowired
    CompanyRepository companyRepository;
    
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
            HttpSession session,
            Model model) {

        HodEntity hod = hodRepository.findByHodEmail(hodEmail);

        if (hod != null && hod.getHpassWord().equals(hpassWord)) {
            // Store HOD in session
            session.setAttribute("hod", hod);
            return "redirect:/hod/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "hodLogin";
        }
    }
    @GetMapping("/hod/dashboard")
    public String hodDashboard(HttpSession session, Model model) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) {
            return "redirect:/hodlogin";
        }
        
        // Fetch faculty of same branch
        List<FacultyEntity> facultyList = facultyRepository.findAllByBranch(hod.getBranch());
        // Fetch students of same branch
        List<StudentEntity> studentList = studentRepository.findByBranch(hod.getBranch());
        
       // NEW: Fetch companies for this branch
        List<CompanyEntity> companies = companyRepository.findByBranch(hod.getBranch());

        
        model.addAttribute("facultyList", facultyList);
        model.addAttribute("studentList", studentList);
        model.addAttribute("companies", companies);
        model.addAttribute("hod", hod);
        
        // For sidebar badges
        model.addAttribute("facultyCount", facultyList.size());
        model.addAttribute("studentCount", studentList.size());
        
        return "hodDashboard";
    }
    
    @GetMapping("/hod/facultylist")
    public String hodFacultyList(HttpSession session, Model model) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) return "redirect:/hodlogin";
        
        List<StudentEntity> studentList = studentRepository.findByBranch(hod.getBranch());
        List<FacultyEntity> facultyList = facultyRepository.findAllByBranch(hod.getBranch());
        model.addAttribute("facultyList", facultyList);
        model.addAttribute("hod", hod);
        
     // For sidebar badges
        model.addAttribute("facultyCount", facultyList.size());
        model.addAttribute("studentCount", studentList.size());
        
        return "hodFacultyList"; // we'll create this JSP
    }

    @GetMapping("/hod/studentlist")
    public String hodStudentList(@RequestParam(required = false) String batch,
                                 HttpSession session, Model model) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) return "redirect:/hodlogin";

        List<StudentEntity> studentList;
        if (batch != null && !batch.isEmpty()) {
            studentList = studentRepository.findByBranchAndBatch(hod.getBranch(), batch);
        } else {
            studentList = studentRepository.findByBranch(hod.getBranch());
        }

        List<FacultyEntity> facultyList = facultyRepository.findAllByBranch(hod.getBranch());
        model.addAttribute("studentList", studentList);
        model.addAttribute("hod", hod);
        model.addAttribute("studentCount", studentList.size());
        model.addAttribute("facultyCount", facultyList.size());
        model.addAttribute("batches", batchRepository.findAll());      // all batches for dropdown
        model.addAttribute("selectedBatch", batch);                   // currently selected

        return "hodStudentList";
    }
    // -------------------- List All HODs --------------------
    @GetMapping("/listhod")
    public String listAllHods(Model model) {
        List<HodEntity> hodList = hodRepository.findAll();
        model.addAttribute("hodList", hodList);
        model.addAttribute("studentCount", studentRepository.count());
        model.addAttribute("batchCount", batchRepository.count());
        model.addAttribute("branchCount", branchRepository.count());
        model.addAttribute("facultyCount",facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
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
    
    @GetMapping("/hod/assign-faculty")
    public String showAssignFacultyPage(HttpSession session, Model model) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) return "redirect:/hodlogin";

        List<StudentEntity> students = studentRepository.findByBranch(hod.getBranch());
        List<FacultyEntity> facultyList = facultyRepository.findAllByBranch(hod.getBranch());
        List<StudentEntity> studentList = studentRepository.findByBranch(hod.getBranch());

        model.addAttribute("studentList", students);
        model.addAttribute("facultyList", facultyList);
        model.addAttribute("hod", hod);
        model.addAttribute("facultyCount", facultyList.size());
        model.addAttribute("studentCount", studentList.size());
        return "hodAssignFaculty";
    }
    
    @PostMapping("/hod/assign-faculty")
    public String assignFaculty(@RequestParam("studentId") Integer studentId,
                                @RequestParam("facultyId") Integer facultyId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) return "redirect:/hodlogin";

        StudentEntity student = studentRepository.findById(studentId).orElse(null);
        FacultyEntity faculty = facultyRepository.findById(facultyId).orElse(null);

        if (student != null && faculty != null && student.getBranch().equals(hod.getBranch()) && faculty.getBranch().equals(hod.getBranch())) {
            student.setFaculty(faculty.getFacultyName());
            studentRepository.save(student);
            redirectAttributes.addFlashAttribute("success", "Assigned " + faculty.getFacultyName() + " to " + student.getStudentName());
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid assignment.");
        }
        return "redirect:/hod/assign-faculty";
    }
    @GetMapping("/hod/auto-assign-faculty")
    public String autoAssignFaculty(HttpSession session, RedirectAttributes redirectAttributes) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) return "redirect:/hodlogin";

        // Get all students in branch with no faculty assigned (or all students if you want to reassign)
        List<StudentEntity> students = studentRepository.findByBranchAndFacultyIsNull(hod.getBranch());
        // Get all faculty in branch
        List<FacultyEntity> facultyList = facultyRepository.findAllByBranch(hod.getBranch());

        if (facultyList.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "No faculty available in this branch to assign.");
            return "redirect:/hod/assign-faculty";
        }

        if (students.isEmpty()) {
            redirectAttributes.addFlashAttribute("info", "All students already have assigned faculty.");
            return "redirect:/hod/assign-faculty";
        }

        // Round-robin assignment
        int facultyIndex = 0;
        for (StudentEntity student : students) {
            FacultyEntity faculty = facultyList.get(facultyIndex % facultyList.size());
            student.setFaculty(faculty.getFacultyName());
            studentRepository.save(student);
            facultyIndex++;
        }

        redirectAttributes.addFlashAttribute("success", "Automatically assigned faculty to " + students.size() + " student(s).");
        return "redirect:/hod/assign-faculty";
    }
    
    @GetMapping("/hod/unassigned-students")
    public String showUnassignedStudents(HttpSession session, Model model) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) return "redirect:/hodlogin";

        List<StudentEntity> unassigned = studentRepository.findByBranchAndFacultyIsNull(hod.getBranch());
        List<FacultyEntity> facultyList = facultyRepository.findAllByBranch(hod.getBranch());
        
        
        // Fetch students of same branch
        List<StudentEntity> studentList = studentRepository.findByBranch(hod.getBranch());

        model.addAttribute("studentList", unassigned);
        model.addAttribute("facultyList", facultyList);
        model.addAttribute("hod", hod);
        model.addAttribute("unassignedCount", unassigned.size());
        
        // For sidebar badges
        model.addAttribute("facultyCount", facultyList.size());
        model.addAttribute("studentCount", studentList.size());

        return "hodUnassignedStudents";
    }
    
    @ModelAttribute
    public void addCommonAttributes(HttpSession session, Model model) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod != null) {
            long unassigned = studentRepository.countByBranchAndFacultyIsNull(hod.getBranch());
            model.addAttribute("unassignedCount", unassigned);
        }
    }
    
    @GetMapping("/hod/companies")
    public String listCompanies(HttpSession session, Model model) {
        HodEntity hod = (HodEntity) session.getAttribute("hod");
        if (hod == null) return "redirect:/hodlogin";

        List<CompanyEntity> companies = companyRepository.findByBranch(hod.getBranch());
        model.addAttribute("companies", companies);
        model.addAttribute("hod", hod);
        
        List<FacultyEntity> facultyList = facultyRepository.findAllByBranch(hod.getBranch());
        List<StudentEntity> studentList = studentRepository.findByBranch(hod.getBranch());
        
        // For sidebar badges
        model.addAttribute("facultyCount", facultyList.size());
        model.addAttribute("studentCount", studentList.size());
        return "hodCompanyList";
    }
    
    // -------------------- HOD Dashboard (optional) --------------------
	/*
	 * @GetMapping("/hod/dashboard") public String hodDashboard(Model model) { //
	 * You can add any data needed for the HOD dashboard return "hodDashboard"; //
	 * hodDashboard.jsp (create if needed) }
	 */
}