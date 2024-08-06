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
public class MovieDTO {
  private int movieNo;
  private String movieCd;
  private String movieNm;
  private long audiAcc;
  private long salesAcc;
  private String openDt;
  private String titleEng;
  private String titleOrg;
  private String plot;
  private int runtime;
  private String rating;
  private String genres;
  private String keywords;
  private String stillUrls;
  private String posterUrls;  
}
