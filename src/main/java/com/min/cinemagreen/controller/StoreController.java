package com.min.cinemagreen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/store")
@Controller
public class StoreController {

	@GetMapping(value = "/store.page")
	public String storePage() {
	  return "store/store";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
