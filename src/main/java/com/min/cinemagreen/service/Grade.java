package com.min.cinemagreen.service;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@Data
public class Grade {
  private int id; 
  private List<Result> results;
  
  @NoArgsConstructor
  @Data
  static class Result { 
    private String iso_3166_1;
    private List<ReleaseDate> release_dates;
    
    @NoArgsConstructor
    @Data
    static class ReleaseDate {
      private String certification;
      private List<String> descriptors;
      private String iso_639_1;
      private String note;
      private String release_date;
      private int type;
    }
    
  }
  
}