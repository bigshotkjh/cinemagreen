package com.min.cinemagreen.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.MovieDTO;

@Mapper
public interface IAdminMovieMapper {

  List<MovieDTO> getMovieList(); // 모든 영화 가져오기

  MovieDTO getMovieById(int movieNo); // 해당 영화 가져오기

<<<<<<< HEAD
  List<RuntimeDTO> getRuntimeList(); // 모든 상영시각 가져오기

  RuntimeDTO getRuntimeById(int movieNo); // 해당 영화의 상영시각 가져오기
  
  int adminInsertTime(Map<String, Object> params); // 상영 시간 등록
  
  /*
   * int adminUpdateTime(RuntimeDTO timeInfo); // 수정
   * 
   * int adminDeleteTime(int timeNo); // 삭제
   */
  
  
  
=======

>>>>>>> 574f47f2da5f98cefffce1459d2482328ddf3b3f
}
