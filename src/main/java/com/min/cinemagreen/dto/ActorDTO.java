package com.min.cinemagreen.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class ActorDTO {
  private String actorId;    // 배우아이디(00049050)
  private String actorNm;    // 배우명(로버트 다우니 주니어)
  private String actorEnNm;  // 배우명영문(Robert Downey Jr.)
}
