package com.min.cinemagreen.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class OccupiedSeatDTO {
  private int occupiedSeatNo;  // 예약좌석번호
  private String seatCode;     // 좌석코드
  private String seatTypeNo;   // 좌석타입번호
  private int timeNo;          // 상영시간번호 
  private String ticketingNo;  // 티켓번호
}


