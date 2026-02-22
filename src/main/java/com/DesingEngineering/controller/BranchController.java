package com.DesingEngineering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.DesingEngineering.entity.BranchEntity;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.FacultyRepository; // for sidebar counts
import com.DesingEngineering.repository.HodRepository;     // for sidebar counts

@Controller
public class BranchController {

    @Autowired
    private BranchRepository branchRepository;

    // For sidebar badges (if needed)
    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private HodRepository hodRepository;

    // Helper to add sidebar attributes
    private void addSidebarAttributes(Model model) {
        model.addAttribute("facultyCount", facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
        // Other counts (student, batch) are added by their respective controllers
    }

    // -------------------- Show Add Form --------------------
    @GetMapping("/branch")
    public String openBranch(Model model) {
        addSidebarAttributes(model);
        return "Branch"; // Branch.jsp (add form)
    }

    // -------------------- Save New Branch --------------------
    @PostMapping("/savebranch")
    public String saveBranch(BranchEntity branchEntity) {
        branchRepository.save(branchEntity);
        return "redirect:/listbranch";
    }

    // -------------------- List All Branches --------------------
    @GetMapping("/listbranch")
    public String listBranch(Model model) {
        List<BranchEntity> branchList = branchRepository.findAll();
        model.addAttribute("branchList", branchList);
        addSidebarAttributes(model);
        return "Listbranch"; // Listbranch.jsp
    }

    // -------------------- Show Edit Form --------------------
    @GetMapping("/editbranch/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        BranchEntity branch = branchRepository.findById(id).orElse(null);
        if (branch == null) {
            return "redirect:/listbranch";
        }
        model.addAttribute("branch", branch);
        addSidebarAttributes(model);
        return "editBranch"; // editBranch.jsp
    }

    // -------------------- Update Branch --------------------
    @PostMapping("/updatebranch")
    public String updateBranch(BranchEntity branchEntity) {
        branchRepository.save(branchEntity); // save with existing ID = update
        return "redirect:/listbranch";
    }

    // -------------------- Delete Branch --------------------
    @GetMapping("/deletebranch/{id}")
    public String deleteBranch(@PathVariable("id") Integer id) {
        branchRepository.deleteById(id);
        return "redirect:/listbranch";
    }
}