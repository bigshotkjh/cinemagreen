package com.min.cinemagreen.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdminSeatController {
  

  // ------------------------- 페이지 이동 -------------------------
  @GetMapping("/seat.page")
  public String seatPage(Model model) {
    return "admin/seat"; // 사용자 목록
  }
  // ------------------------- 페이지 이동 -------------------------
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
