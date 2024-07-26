package com.min.cinemagreen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class MoneyController {

	@GetMapping(value = "/money.page")
	public String moneyPage() {
	  return "admin/money";
	}
	

	
	
	
	
	
	
	
}
