package com.min.cinemagreen.payment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.RuntimeDTO;

@Mapper
public interface IReserveMapper {
  
  List<MovieDTO> getMovieReserveList();
  List<RuntimeDTO> getRuntimeByMovie(int movieNo, String selectedDate);
  MovieDTO getMovieByNo(int movieNo);
  RuntimeDTO getRuntimeByNo(int timeNo);
  List<MovieDTO> searchMovieByName(String search);
  
}
