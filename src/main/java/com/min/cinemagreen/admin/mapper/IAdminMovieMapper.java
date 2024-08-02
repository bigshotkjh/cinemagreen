package com.min.cinemagreen.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.MovieDTO;

@Mapper
public interface IAdminMovieMapper {

  List<MovieDTO> getMovieList(Map<String, Object> params); // 모든 영화 가져오기

  MovieDTO getMovieById(int movieNo); // 해당 영화 가져오기


}
