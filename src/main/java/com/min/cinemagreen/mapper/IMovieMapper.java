package com.min.cinemagreen.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.MovieDTO;

@Mapper
public interface IMovieMapper {
  int insertMovie(MovieDTO movieDTO);
}
