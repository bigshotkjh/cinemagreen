package com.min.cinemagreen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class UserInfoController {

	@GetMapping(value = "/userinfo.page")
	public String userinfoPage() {
	  return "admin/userinfo";
	}
	
}
