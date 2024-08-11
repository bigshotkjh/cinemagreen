package com.min.cinemagreen.payment.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.RuntimeDTO;
import com.min.cinemagreen.payment.service.IReserveService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/reserve")
@Controller
public class ReserveController {
  
  
  private final IReserveService reserveService;
  
	@GetMapping(value = "reserve.page")
  public String reserveDo(Model model, HttpServletRequest request) {
    //영화목록 
	  List<MovieDTO> movieReserveList = reserveService.getMovieReserveList(request);
    model.addAttribute("movieReserveList", movieReserveList);
    return "/reserve/reserve";
  }
	
	@GetMapping(value = "movieSearch.do")
	public ResponseEntity<List<MovieDTO>> searchMovies(@RequestParam String search) {
    List<MovieDTO> movieList = reserveService.searchMovieByName(search);
    return ResponseEntity.ok(movieList);
	}
	
	@GetMapping("getRuntime.do")
  public ResponseEntity<List<RuntimeDTO>> getRuntimeListDo(@RequestParam int movieNo, @RequestParam String selectedDate) {
	
	  List<RuntimeDTO> runtimeList = reserveService.getRuntimeByMovie(movieNo, selectedDate);
    log.info("runtimeList {}" , runtimeList);
    return ResponseEntity.ok(runtimeList);
  }
	
	@GetMapping(value = "seat.do")
	  public String seatDo( @RequestParam int movieNo, @RequestParam int timeNo , Model model) { 
	 
	  MovieDTO movie = reserveService.getMovieByNo(movieNo);
    model.addAttribute("movie", movie);
    
    // MovieDTO movie = reserveService.getMovieByNo(movieNo);
    // RuntimeDTO runtime = reserveService.getRuntimeByNo(timeNo);
    // model.addAttribute("movie", movie);
    // model.addAttribute("runtime", runtime);

	    return "/reserve/seat";
	  }
		

  


 
	
	
}
