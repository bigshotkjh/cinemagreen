package com.min.cinemagreen.service;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class TMDBResult {
  private boolean adult;
  private String backdrop_path;
  private List<Integer> genre_ids;
  private int id;
  private String original_language;
  private String original_title;
  private String overview;
  private int popularity;
  private String poster_path;
  private String release_date;
  private String title;
  private boolean video;
  private int vote_average;
  private int vote_count;
}
