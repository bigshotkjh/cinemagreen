package com.min.cinemagreen.payment.service;


import java.util.List;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.RuntimeDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface IReserveService {

  List<MovieDTO> getMovieReserveList(HttpServletRequest request);

//  List<RuntimeDTO> getRuntimeByMovie(int movieNo);
  List<RuntimeDTO> getRuntimeByMovie(int movieNo, String selectedDate);

  MovieDTO getMovieByNo(int movieNo);
  RuntimeDTO getRuntimeByNo(int timeNo);

  List<MovieDTO> searchMovieByName(String search);



}

