package com.min.cinemagreen.movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.ActorDTO;
import com.min.cinemagreen.dto.DirectorDTO;
import com.min.cinemagreen.dto.MovieDTO;

@Mapper
public interface IMovieMapper {
  int insertMovie(MovieDTO movieDTO);
  int updateMovieInfo(MovieDTO movieDTO);
  int updateMovieAcc(MovieDTO movieDTO);
  int insertDirector(DirectorDTO directorDTO);
  int insertMovieDirector(Map<String, Object> params);
  int insertActor(ActorDTO actorDTO);
  int insertMovieActor(Map<String, Object> params);
  List<MovieDTO> getBoxOfficeList(List<Integer> movieNoList);
  MovieDTO getMovieByNo(int movieNo);
}
