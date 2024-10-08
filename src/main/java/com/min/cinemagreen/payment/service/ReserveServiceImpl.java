package com.min.cinemagreen.payment.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.RuntimeDTO;
import com.min.cinemagreen.payment.mapper.IReserveMapper;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReserveServiceImpl implements IReserveService {
  
  private final IReserveMapper reserveMapper;
  
  // 예매 영화목록
  @Transactional(readOnly = true)
  @Override
  public List<MovieDTO> getMovieReserveList(HttpServletRequest request) {
    List<MovieDTO> movieReserveList = reserveMapper.getMovieReserveList();
    return movieReserveList;
  }
  
  
  public MovieDTO getMovieByNo(int movieNo) {
    return reserveMapper.getMovieByNo(movieNo);
  }
  
  public RuntimeDTO getRuntimeByNo(int timeNo) {
    return reserveMapper.getRuntimeByNo(timeNo);
  }

  @Transactional(readOnly = true)
  @Override
  public List<RuntimeDTO> getRuntimeByMovie(int movieNo, String selectedDate) {
    // TODO Auto-generated method stub
    return reserveMapper.getRuntimeByMovie(movieNo, selectedDate);
  }
 
  @Override
  public List<MovieDTO> searchMovieByName(String search) {
    // TODO Auto-generated method stub
    return reserveMapper.searchMovieByName(search);
  }
  
}
