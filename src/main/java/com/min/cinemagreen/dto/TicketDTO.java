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
public class TicketDTO {
  private int ticketNo;       // 티켓번호
  private Date ticketDt;      // 예매일 
  private int userNo;         // 회원 
  private int movieNo;        // 영화번호 
  private String runtimeNo;   // 상영시간표번호 
  private int personCount;    // 예매인원수 
}
