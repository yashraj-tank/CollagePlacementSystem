package com.DesingEngineering.controller;

import com.DesingEngineering.entity.ApplyEntity;
import com.DesingEngineering.entity.CompanyEntity;
import com.DesingEngineering.repository.ApplyRepository;
import com.DesingEngineering.repository.BatchRepository;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.CompanyRepository;
import com.DesingEngineering.repository.FacultyRepository;
import com.DesingEngineering.repository.HodRepository;
import com.DesingEngineering.repository.StudentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/admin/companies")
public class CompanyController {

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private BranchRepository branchRepository;
    
    @Autowired
    private ApplyRepository applyRepository;
    
    @Autowired
    FacultyRepository facultyRepository;
    
    @Autowired
    HodRepository hodRepository;
    
    @Autowired
    StudentRepository studentRepository;
    
    @Autowired
    BatchRepository batchRepository;

    // -------------------- List all companies --------------------
    @GetMapping
    public String listCompanies(Model model) {
        List<CompanyEntity> companies = companyRepository.findAll();
        model.addAttribute("companies", companies);
        model.addAttribute("facultyCount", facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
        model.addAttribute("studentCount", studentRepository.count());
        model.addAttribute("batchCount", batchRepository.count());
        model.addAttribute("branchCount", branchRepository.count());
        return "companyList";
    }

    // -------------------- Show add form --------------------
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("company", new CompanyEntity());
        model.addAttribute("branchList", branchRepository.findAll());
        return "companyForm";
    }

    // -------------------- Save new company --------------------
    @PostMapping("/save")
    public String saveCompany(@ModelAttribute CompanyEntity company,
                              @RequestParam("branchName") String branchName) {
        // Set branch name (assuming company.branch is a String)
        company.setBranch(branchName);
        company.setCreatedAt(LocalDateTime.now());
        companyRepository.save(company);
        return "redirect:/admin/companies";
    }

    // -------------------- Show edit form --------------------
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        CompanyEntity company = companyRepository.findById(id).orElse(null);
        if (company == null) {
            return "redirect:/admin/companies";
        }
        model.addAttribute("company", company);
        model.addAttribute("branchList", branchRepository.findAll());
        return "companyForm";
    }

    // -------------------- Update company --------------------
    @PostMapping("/update")
    public String updateCompany(@ModelAttribute CompanyEntity company,
                                @RequestParam("branchName") String branchName) {
        company.setBranch(branchName);
        companyRepository.save(company);
        return "redirect:/admin/companies";
    }

    // -------------------- Delete company --------------------
    @GetMapping("/delete/{id}")
    public String deleteCompany(@PathVariable("id") Integer id) {
        // Delete all applications for this company
        List<ApplyEntity> applications = applyRepository.findByCompanyId(id);
        if (applications != null && !applications.isEmpty()) {
            applyRepository.deleteAll(applications);
        }
        // Then delete the company
        companyRepository.deleteById(id);
        return "redirect:/admin/companies";
    }
}