package com.DesingEngineering.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.DesingEngineering.entity.BatchEntity;
import com.DesingEngineering.repository.BatchRepository;
import com.DesingEngineering.repository.BranchRepository;
import com.DesingEngineering.repository.FacultyRepository; // for sidebar counts
import com.DesingEngineering.repository.HodRepository;     // for sidebar counts
import com.DesingEngineering.repository.StudentRepository;

@Controller
public class BatchController {

    @Autowired
    private BatchRepository batchRepository;

    // For sidebar badges (optional but recommended)
    @Autowired
    private FacultyRepository facultyRepository;
    
    @Autowired
    StudentRepository studentRepository;
    
    @Autowired
    BranchRepository branchRepository;

    @Autowired
    private HodRepository hodRepository;

    // Helper to add sidebar attributes
    private void addSidebarAttributes(Model model) {
        model.addAttribute("facultyCount", facultyRepository.count());
        model.addAttribute("hodCount", hodRepository.count());
        model.addAttribute("studentCount", studentRepository.count());
        model.addAttribute("batchCount", batchRepository.count());
        model.addAttribute("branchCount", branchRepository.count());
        // studentCount, batchCount, branchCount should be added by their own controllers
        // but if needed, you can inject those repositories and add them here.
    }

    // -------------------- Show Add Form --------------------
    @GetMapping("/batch")
    public String openBatch(Model model) {
        addSidebarAttributes(model);
        return "Batch"; // Batch.jsp (add form)
    }

    // -------------------- Save New Batch --------------------
    @PostMapping("/savebatch")
    public String saveBatch(BatchEntity batchEntity) {
        batchRepository.save(batchEntity);
        return "redirect:/listbatch";
    }

    // -------------------- List All Batches --------------------
    @GetMapping("/listbatch")
    public String listBatch(Model model) {
        List<BatchEntity> batchList = batchRepository.findAll();
        model.addAttribute("batchList", batchList);
        addSidebarAttributes(model);
        return "Listbatch"; // Listbatch.jsp
    }

    // -------------------- Show Edit Form --------------------
    @GetMapping("/editbatch/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        BatchEntity batch = batchRepository.findById(id).orElse(null);
        if (batch == null) {
            return "redirect:/listbatch";
        }
        model.addAttribute("batch", batch);
        addSidebarAttributes(model);
        return "editBatch"; // editBatch.jsp
    }

    // -------------------- Update Batch --------------------
    @PostMapping("/updatebatch")
    public String updateBatch(BatchEntity batchEntity) {
        batchRepository.save(batchEntity); // save with existing ID = update
        return "redirect:/listbatch";
    }

    // -------------------- Delete Batch --------------------
    @GetMapping("/deletebatch/{id}")
    public String deleteBatch(@PathVariable("id") Integer id) {
        batchRepository.deleteById(id);
        return "redirect:/listbatch";
    }
}