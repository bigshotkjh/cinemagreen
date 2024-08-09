package com.min.cinemagreen.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdminQnaController {
  

  // ------------------------- 페이지 이동 -------------------------
  @GetMapping("/qna.page")
  public String qnaPage(Model model) {
    return "admin/qna"; // 사용자 목록
  }
  // ------------------------- 페이지 이동 -------------------------
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
