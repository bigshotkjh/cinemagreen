package com.min.cinemagreen.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class UserTicketDTO {
  private String movieNm;
  private String startTime;
  private int runtime;
  private String seatCode;
  private int amount;
  private String payState;
}
