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
public class DirectorDTO {
  private String directorId;    // 감독아이디(00075324)
  private String directorNm;    // 감독명(가이 리치)
  private String directorEnNm;  // 감독명영문(Guy Ritchie)
}
