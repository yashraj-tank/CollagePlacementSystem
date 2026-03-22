package com.DesingEngineering.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.DesingEngineering.entity.ApplyEntity;
import com.DesingEngineering.entity.CompanyEntity;
import com.DesingEngineering.entity.StudentEntity;
import com.DesingEngineering.repository.ApplyRepository;
import com.DesingEngineering.repository.BatchRepository;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.CompanyRepository;
import com.DesingEngineering.repository.StudentRepository;
import com.DesingEngineering.service.EmailService;
import com.DesingEngineering.service.MailerService;
import com.cloudinary.Cloudinary;

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
    
    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private ApplyRepository applyRepository;

    @Autowired
    Cloudinary cloudinary;

    @GetMapping("/studentsingup")
    public String opensavestudentsingup(Model model) {
        model.addAttribute("branchList", branchRepository.findAll());
        model.addAttribute("batchList", batchRepository.findAll());
        return "Studentsingup";
    }

    @GetMapping("/studentlogin")
    public String openstudentlogin() {
        return "StudentLogin";
    }

    @PostMapping("savestudent")
    public String savestudent(StudentEntity studentEntity, MultipartFile profilePic) {
        studentEntity.setActive(true);
        studentEntity.setCreatedAt(LocalDate.now());
        studentRepository.save(studentEntity);

        mailerService.sendWelcomeMail(studentEntity);
        return "StudentLogin";
    }

    @PostMapping("/studentlogin")
    public String studentLogin(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            Model model, HttpSession session) {

        StudentEntity student = studentRepository.findByEmail(email);

        if (student != null && student.getPassword().equals(password)) {
            session.setAttribute("student", student);
            return "redirect:/student/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "StudentLogin";
        }
    }

    // -------------------- Student Dashboard --------------------
    @GetMapping("/student/dashboard")
    public String studentDashboard(HttpSession session, Model model) {
        StudentEntity student = (StudentEntity) session.getAttribute("student");
        if (student == null) {
            return "redirect:/studentlogin";
        }
        model.addAttribute("student", student);
        return "student/studentDashboard";
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

    @GetMapping("/studentforgetpassword")
    public String studentforgetpassword() {
        return "StudentForgetP";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email, Model model) {
        StudentEntity student = studentRepository.findByEmail(email);
        if (student == null) {
            model.addAttribute("error", "Email not registered!");
            return "ForgotPassword";
        }

        String otp = String.valueOf((int) (Math.random() * 900000) + 100000);
        student.setOtp(otp);
        studentRepository.save(student);

        emailService.sendOtpEmail(email, otp);

        model.addAttribute("email", email);
        return "VerifyOtp";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam("email") String email,
                            @RequestParam("otp") String otp,
                            Model model) {
        StudentEntity student = studentRepository.findByEmail(email);
        if (student == null) {
            return "redirect:/forgot-password";
        }

        if (otp.equals(student.getOtp())) {
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

        student.setPassword(newPassword);
        student.setOtp(null);
        studentRepository.save(student);

        model.addAttribute("success", "Password updated successfully. Please login.");
        return "StudentLogin";
    }
    
 // Show profile page
    @GetMapping("/student/profile")
    public String studentProfile(HttpSession session, Model model) {
        StudentEntity student = (StudentEntity) session.getAttribute("student");
        if (student == null) return "redirect:/studentlogin";
        model.addAttribute("student", student);
        return "student/studentProfile";
    }

    // Update personal info (text fields)
    @PostMapping("/student/update-profile")
    public String updateProfile(
            @RequestParam("studentName") String studentName,
            @RequestParam("email") String email,
            @RequestParam("contactNum") String contactNum,
            HttpSession session,
            Model model) {

        StudentEntity student = (StudentEntity) session.getAttribute("student");
        if (student == null) return "redirect:/studentlogin";

        student.setStudentName(studentName);
        student.setContactNum(contactNum);
        // email is read-only, but we keep it in case (though should not change)
        student.setEmail(email);
        studentRepository.save(student);
        session.setAttribute("student", student); // update session

        model.addAttribute("success", "Profile updated successfully.");
        model.addAttribute("student", student);
        return "student/studentProfile";
    }

    // Upload profile picture
    @PostMapping("/student/upload-profile-pic")
    public String uploadProfilePic(@RequestParam("profilePic") MultipartFile profilePic,
                                   HttpSession session, Model model) {
        StudentEntity student = (StudentEntity) session.getAttribute("student");
        if (student == null) return "redirect:/studentlogin";

        try {
            Map<?, ?> result = cloudinary.uploader().upload(
                profilePic.getBytes(),
                Map.of("folder", "students/profile_pictures")
            );
            student.setProfilePicURL(result.get("secure_url").toString());
            studentRepository.save(student);
            session.setAttribute("student", student);
            model.addAttribute("success", "Profile picture updated.");
        } catch (IOException e) {
            model.addAttribute("error", "Upload failed: " + e.getMessage());
        }
        model.addAttribute("student", student);
        return "student/studentProfile";
    }

    // Upload resume
    @PostMapping("/student/upload-resume")
    public String uploadResume(@RequestParam("resume") MultipartFile resume,
                               HttpSession session, Model model) {
        StudentEntity student = (StudentEntity) session.getAttribute("student");
        if (student == null) return "redirect:/studentlogin";

        try {
            Map<?, ?> result = cloudinary.uploader().upload(
                resume.getBytes(),
                Map.of(
                    "folder", "students/resumes",
                    "resource_type", "raw"   // <-- important for documents
                )
            );
            String resumeUrl = result.get("secure_url").toString();
            student.setResumeURL(resumeUrl);
            studentRepository.save(student);
            session.setAttribute("student", student);
            model.addAttribute("success", "Resume uploaded successfully.");
        } catch (IOException e) {
            model.addAttribute("error", "Resume upload failed: " + e.getMessage());
        }
        model.addAttribute("student", student);
        return "student/studentProfile";
    }
    
 // -------------------- List companies for student's branch --------------------
    @GetMapping("/student/companies")
    public String listCompanies(HttpSession session, Model model) {
        StudentEntity student = (StudentEntity) session.getAttribute("student");
        if (student == null) return "redirect:/studentlogin";

        List<CompanyEntity> companies = companyRepository.findByBranch(student.getBranch());
        model.addAttribute("companies", companies);
        model.addAttribute("student", student);
        return "student/studentCompanyList";
    }

    // -------------------- Apply for a company --------------------
    @PostMapping("/student/apply")
    public String applyForCompany(@RequestParam("companyId") Integer companyId,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        StudentEntity student = (StudentEntity) session.getAttribute("student");
        if (student == null) return "redirect:/studentlogin";

        // Check if student is verified (status = true)
        if (student.getStatus() == null || !student.getStatus()) {
            redirectAttributes.addFlashAttribute("error", "You are not verified yet. Please contact your faculty.");
            return "redirect:/student/companies";
        }

        // Check if already applied
        ApplyEntity existing = applyRepository.findByStudentIdAndCompanyId(student.getStudentId(), companyId);
        if (existing != null) {
            redirectAttributes.addFlashAttribute("error", "You have already applied for this company.");
            return "redirect:/student/companies";
        }

        // Create new application
        ApplyEntity application = new ApplyEntity();
        application.setStudentId(student.getStudentId());
        application.setCompanyId(companyId);
        applyRepository.save(application);

        redirectAttributes.addFlashAttribute("success", "Application submitted successfully!");
        return "redirect:/student/companies";
    }
}