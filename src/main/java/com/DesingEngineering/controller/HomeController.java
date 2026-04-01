package com.DesingEngineering.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

      @GetMapping("/staff")
      public String staff() {
        return "index"; // returns index.jsp
    }
	
	@GetMapping("/home")
	public String home() {
		return "home2";
	}
}