package com.min.cinemagreen.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class SeatDTO {
  private String seatNo;     // 좌석번호
  private int seatRow;       // 좌석 열 
  private int seatCol;       // 좌석 행 
}
