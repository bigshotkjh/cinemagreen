package com.min.cinemagreen.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class MovieDTO { // https://developer.themoviedb.org/reference/discover-movie 응답값 참고
  private int movieNo;  // movie_seq
  private String title;  // title
  private String subTitle;  // original_title
  private String story;  // overview  
  private String grade;  // certification, TMDB Movie Certifications 참고
  private double ticketRate; // 예매율, api 사이트 다 찾아봤지만 활용불가, 누적관객수로 대체해야될듯
  private double reviewScore; // vote_average
  private int ticketSale; // revenue
  private String openingDt;  // release_date
  private int runningTime; // runtime
}
