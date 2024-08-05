package com.min.cinemagreen.movie.service;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.min.cinemagreen.dto.MovieDTO;

public interface IMovieService {
  ResponseEntity<List<MovieDTO>> getBoxOfficeList();
  ResponseEntity<List<MovieDTO>> boxOfficeList();
  MovieDTO getMovieByNo(int movieNo);
}
