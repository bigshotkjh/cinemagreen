package com.min.cinemagreen.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.service.IMovieService;

import lombok.RequiredArgsConstructor;

@RequestMapping(value = "/movie")
@RequiredArgsConstructor
@Controller
public class MovieController {

  private final IMovieService movieService;
  
  @GetMapping(value = "/boxOfficeList.do", produces = "application/json")
  public ResponseEntity<List<MovieDTO>> boxOfficeListDo() {
    return movieService.getBoxOfficeList();
  }
  
  @GetMapping(value = "/detail.do")
  public String detailDo(@RequestParam int movieNo, Model model) {
    model.addAttribute("movie", movieService.getMovieByNo(movieNo));
    return "movie/detail";
  }
  
}