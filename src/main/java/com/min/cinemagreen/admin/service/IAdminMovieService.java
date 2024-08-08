package com.min.cinemagreen.admin.service;

import java.util.List;
import java.util.Map;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.RuntimeDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface IAdminMovieService {

  List<MovieDTO> getMovieList(HttpServletRequest request); // 모든 영화 정보 가져오기

  MovieDTO getMovieById(int movieNo); // 특정 영화 정보 가져오기
  
  List<RuntimeDTO> getRuntimeList(); // 모든 상영 시각 가져오기

  RuntimeDTO getRuntimeById(int movieNo); // 특정 영화 상영 시각 가져오기

  
  int adminInsertTime(Map<String, Object> params); // 상영 시각 추가
  
  /*
   * int adminUpdateTime(RuntimeDTO timeInfo); // 사용자 정보 수정
   * 
   * String adminDeleteTime(int timeNo); // 사용자 삭제
   */
}
