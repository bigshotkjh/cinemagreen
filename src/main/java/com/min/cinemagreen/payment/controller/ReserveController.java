package com.min.cinemagreen.payment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/reserve")
@RequiredArgsConstructor
@Controller
public class ReserveController {
  
  //private final IMovieService movieService;
  
	@GetMapping(value = "reserve.do")
	  public String reserveDo() {
	    return "/reserve/reserve";
	  }
	
	@GetMapping(value = "seat.do")
	  public String seatDo() {
	  // 예약좌석 select 
	    return "/reserve/seat";
	  }
		
	
	
	// 예매
//  @PostMapping("/reservation")
//  public String reserveTicket(@RequestBody TicketDTO ticket) {
//    log.info("ticket reserve request: " + ticket);
//
//    reserveService.saveTicket(ticket);
//    return ;
//  }

 
	
	
}
