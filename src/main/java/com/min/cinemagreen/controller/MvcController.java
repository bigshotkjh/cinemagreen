package com.min.cinemagreen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MvcController {

  @GetMapping(value = "/")
  public String main() {
    return "main";
  }
  
}
