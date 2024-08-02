package com.min.cinemagreen.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.cinemagreen.admin.mapper.IAdminMovieMapper;
import com.min.cinemagreen.dto.MovieDTO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class AdminMovieServiceImpl implements IAdminMovieService {

  private final IAdminMovieMapper adminMovieMapper;
  
  
  // ------------------------- 사용자 정보 이동 -------------------------
  @Transactional(readOnly = true)
  @Override
  public List<MovieDTO> getMovieList(HttpServletRequest request) {
    Map<String, Object> params = new HashMap<>();
    return adminMovieMapper.getMovieList(params);
  }

  @Transactional(readOnly = true)
  @Override
  public MovieDTO getMovieById(int movieNo) {
    return adminMovieMapper.getMovieById(movieNo);
  }
  // ------------------------- 사용자 정보 이동 -------------------------
  
  
  

  
  
  
}