package com.min.cinemagreen.service;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.min.cinemagreen.dto.MovieDTO;

public interface IMovieService {
  ResponseEntity<List<MovieDTO>> getBoxOfficeList();
  MovieDTO getMovieByNo(int movieNo);
}
