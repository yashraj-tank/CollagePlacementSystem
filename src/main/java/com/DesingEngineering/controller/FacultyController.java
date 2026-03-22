package com.DesingEngineering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
import com.DesingEngineering.repository.StudentRepository;  // <-- ADD THIS

import jakarta.servlet.http.HttpSession;

@Controller
public class FacultyController {

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private BranchRepository branchRepository;
    
    @Autowired
    BatchRepository batchRepository;

    @Autowired
    private HodRepository hodRepository;

    @Autowired
    private StudentRepository studentRepository;  // <-- NEW
    
    @Autowired
    private CompanyRepository companyRepository;

    // Helper method to add common sidebar attributes (if needed)
    private void addSidebarAttributes(Model model) {
        model.addAttribute("facultyCount", facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
        model.addAttribute("studentCount", studentRepository.count());
        model.addAttribute("batchCount", batchRepository.count());
        model.addAttribute("branchCount", branchRepository.count());
    }

    // -------------------- Show Signup Form --------------------
    @GetMapping("/facultysignup")
    public String showSignupForm(Model model) {
        model.addAttribute("branchList", branchRepository.findAll());
        addSidebarAttributes(model);
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
            if (facultyRepository.findByFacultyEmail(facultyEmail) != null) {
                model.addAttribute("error", "Email already registered!");
                model.addAttribute("branchList", branchRepository.findAll());
                addSidebarAttributes(model);
                return "facultySignup";
            }

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
            addSidebarAttributes(model);
            return "facultySignup";
        }
    }

    // -------------------- Show Login Form --------------------
    @GetMapping("/facultylogin")
    public String showLoginForm(Model model) {
        addSidebarAttributes(model);
        return "facultyLogin";
    }

    // -------------------- Process Login --------------------
    @PostMapping("/facultylogin")
    public String processLogin(
            @RequestParam("facultyEmail") String facultyEmail,
            @RequestParam("fpassWord") String fpassWord,
            HttpSession session,                // <-- added session
            Model model) {

        FacultyEntity faculty = facultyRepository.findByFacultyEmail(facultyEmail);

        if (faculty != null && faculty.getFpassWord().equals(fpassWord)) {
            session.setAttribute("faculty", faculty);   // <-- store in session
            return "redirect:/faculty/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            addSidebarAttributes(model);
            return "facultyLogin";
        }
    }

    // -------------------- Faculty Dashboard --------------------
    @GetMapping("/faculty/dashboard")
    public String facultyDashboard(HttpSession session, Model model) {
        // Retrieve logged-in faculty from session
        FacultyEntity faculty = (FacultyEntity) session.getAttribute("faculty");
        if (faculty == null) {
            return "redirect:/facultylogin";
        }

        // Fetch HOD of the same branch (optional)
        HodEntity hod = hodRepository.findByBranch(faculty.getBranch());

        // Fetch ONLY students assigned to this faculty
        List<StudentEntity> assignedStudents = studentRepository.findByBranchAndFaculty(
            faculty.getBranch(), 
            faculty.getFacultyName()
        );

        model.addAttribute("faculty", faculty);
        model.addAttribute("hod", hod);
        model.addAttribute("studentList", assignedStudents);
        model.addAttribute("studentCount", assignedStudents.size());

        // Optional: add other sidebar counts if needed (but not the total student count)
        // model.addAttribute("facultyCount", facultyRepository.count());
        // model.addAttribute("hodCount", hodRepository.count());
        // model.addAttribute("batchCount", batchRepository.count());
        // model.addAttribute("branchCount", branchRepository.count());

        return "faculty/facultyDashboard";
    }

    // -------------------- List All Faculty (Admin only) --------------------
    @GetMapping("/listfaculty")
    public String listAllFaculty(Model model) {
        List<FacultyEntity> facultyList = facultyRepository.findAll();
        model.addAttribute("facultyList", facultyList);
        addSidebarAttributes(model);
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
        addSidebarAttributes(model);
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
    
    @GetMapping("/faculty/students")
    public String listMyStudents(HttpSession session, Model model) {
        FacultyEntity faculty = (FacultyEntity) session.getAttribute("faculty");
        if (faculty == null) return "redirect:/facultylogin";

        List<StudentEntity> assignedStudents = studentRepository.findByBranchAndFaculty(
            faculty.getBranch(),
            faculty.getFacultyName()
        );

        model.addAttribute("faculty", faculty);
        model.addAttribute("studentList", assignedStudents);
        model.addAttribute("studentCount", assignedStudents.size());

        return "faculty/facultyStudentList";
    }
    
 // -------------------- View Student Profile --------------------
    @GetMapping("/faculty/student/{studentId}")
    public String viewStudentProfile(@PathVariable("studentId") Integer studentId,
                                     HttpSession session,
                                     Model model) {
        FacultyEntity faculty = (FacultyEntity) session.getAttribute("faculty");
        if (faculty == null) return "redirect:/facultylogin";

        StudentEntity student = studentRepository.findById(studentId).orElse(null);
        if (student == null || !student.getBranch().equals(faculty.getBranch()) || !student.getFaculty().equals(faculty.getFacultyName())) {
            return "redirect:/faculty/students";
        }

        List<StudentEntity> assignedStudents = studentRepository.findByBranchAndFaculty(
                faculty.getBranch(), 
                faculty.getFacultyName()
            );
        model.addAttribute("student", student);
        model.addAttribute("faculty", faculty);
        model.addAttribute("studentCount", assignedStudents.size());

        return "faculty/studentProfile";
    }
    
    // -------------------- Toggle Student Status --------------------
    @PostMapping("/faculty/student/{studentId}/toggle-status")
    public String toggleStudentStatus(@PathVariable("studentId") Integer studentId,
                                      HttpSession session,
                                      RedirectAttributes redirectAttributes) {
        FacultyEntity faculty = (FacultyEntity) session.getAttribute("faculty");
        if (faculty == null) return "redirect:/facultylogin";

        StudentEntity student = studentRepository.findById(studentId).orElse(null);
        if (student == null || !student.getBranch().equals(faculty.getBranch()) || !student.getFaculty().equals(faculty.getFacultyName())) {
            redirectAttributes.addFlashAttribute("error", "Invalid student access.");
            return "redirect:/faculty/students";
        }

        // Safely get current status (treat null as false)
        boolean currentStatus = student.getStatus() != null ? student.getStatus() : false;
        student.setStatus(!currentStatus);
        studentRepository.save(student);

        redirectAttributes.addFlashAttribute("success", 
            "Status updated to " + (student.getStatus() ? "Verified" : "Not Verified") + " for " + student.getStudentName());
        return "redirect:/faculty/student/" + studentId;
    }
    
    @GetMapping("/faculty/companies")
    public String listCompanies(HttpSession session, Model model) {
        FacultyEntity faculty = (FacultyEntity) session.getAttribute("faculty");
        if (faculty == null) return "redirect:/facultylogin";

        List<CompanyEntity> companies = companyRepository.findByBranch(faculty.getBranch());
        // Fetch ONLY students assigned to this faculty
        List<StudentEntity> assignedStudents = studentRepository.findByBranchAndFaculty(
            faculty.getBranch(), 
            faculty.getFacultyName()
        );
        model.addAttribute("companies", companies);
        model.addAttribute("faculty", faculty);
        model.addAttribute("studentCount", assignedStudents.size());
        return "faculty/facultyCompanyList";
    }
}
