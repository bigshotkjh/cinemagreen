package com.min.cinemagreen.payment.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.min.cinemagreen.payment.service.IPaymentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/reserve")
@RequiredArgsConstructor
@Controller
public class ReserveController {
  
  
  private final IPaymentService paymentService;
  
	@GetMapping(value = "reserve.do")
	  public String reserveDo() {
	    return "/reserve/reserve";
	  }
	
	@GetMapping(value = "seat.do")
	  public String seatDo(Model model) { 
	  // 예약좌석 select 
//  	  List<String> occupiedSeats = paymentService.getOccpSeats();
//      model.addAttribute("occupiedSeats", occupiedSeats);
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
