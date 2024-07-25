package com.min.cinemagreen.service;

import java.util.List;

import lombok.Data;

@Data
public class TMDBResponse {
  private List<TMDBResult> results;
  private int total_pages;
  private int total_results;
}
