package com.min.cinemagreen.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class PaymentDTO {
    private String payId;     // 결제 고유 번호
    private int userNo;       // 회원 
    private int amount;       // 결제 금액
    private String ticketNo;  // 티켓번호 
    private Date payDt;       // 결제일자  
    private String payState;  // 결제상태 
  }
