package com.min.cinemagreen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/reserve")
@Controller
public class ReserveController {
	
	@GetMapping(value = "reserve.do")
	  public String reserveDo() {
	    return "/reserve/reserve";
	  }
	
}
