package com.min.cinemagreen.admin.service;

import java.util.List;

import com.min.cinemagreen.dto.MovieDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface IAdminMovieService {

  List<MovieDTO> getMovieList(HttpServletRequest request); // 모든 영화 정보 가져오기

  MovieDTO getMovieById(int movieNo); // 특정 영화 정보 가져오기
}
