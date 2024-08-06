package com.min.cinemagreen.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.cinemagreen.admin.mapper.IAdminMovieMapper;
import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.RuntimeDTO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class AdminMovieServiceImpl implements IAdminMovieService {

  private final IAdminMovieMapper adminMovieMapper;
  
  
  // ------------------------- 영화 정보 이동 -------------------------
  @Transactional(readOnly = true)
  @Override
  public List<MovieDTO> getMovieList(HttpServletRequest request) {
      
      // 영화 목록 조회
      List<MovieDTO> movieList = adminMovieMapper.getMovieList();
      return movieList;
  }
  
  @Transactional(readOnly = true)
  @Override
  public MovieDTO getMovieById(int movieNo) {
    return adminMovieMapper.getMovieById(movieNo);
  }
  // ------------------------- 영화 정보 이동 -------------------------
  
  
  
  
  
  // ------------------------- 상영시각 정보 이동 -------------------------
  @Transactional(readOnly = true)
  @Override
  public List<RuntimeDTO> getRuntimeList() {
      // 모든 상영 시각 정보 조회
      return adminMovieMapper.getRuntimeList(); // MyBatis 매퍼 메서드 호출
  }
  @Transactional(readOnly = true)
  @Override
  public RuntimeDTO getRuntimeById(int movieNo) {
      return adminMovieMapper.getRuntimeById(movieNo);
  }
  // ------------------------- 상영시각 정보 이동 -------------------------

  
  
  @Override
  public int adminInsertTime(Map<String, Object> params) {
      return adminMovieMapper.adminInsertTime(params);
  }// 상영 시각 추가
  
  
  
  
}