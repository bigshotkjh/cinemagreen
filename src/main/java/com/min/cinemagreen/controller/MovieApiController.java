package com.min.cinemagreen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.min.cinemagreen.service.TMDBResult;
import com.min.cinemagreen.service.TMDBService;

@Controller
public class MovieApiController {
  
  @Autowired
  private TMDBService tmdbService;

  @GetMapping("/movies")
  public String getMovies(Model model) {
    List<TMDBResult> movies = tmdbService.getMovies();
    System.out.println(movies);
    model.addAttribute("movies", movies);
    return "main"; // main.jsp로 설정
  }
    
}
