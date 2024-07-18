package com.min.cinemagreen.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class PaymentController {
	
	@PostMapping(value = "/payment.do")
	public ResponseEntity<Object> payment() {
		return null;
        // 결제 비지니스 로직
    }
	
}
