package com.min.cinemagreen.admin.service;

import java.util.HashMap;
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
  
  
  // ------------------------- 사용자 정보 이동 -------------------------
  @Transactional(readOnly = true)
  @Override
  public List<MovieDTO> getMovieList(HttpServletRequest request) {
      Map<String, Object> params = new HashMap<>();
      
      // 영화 목록 조회
      List<MovieDTO> movieList = adminMovieMapper.getMovieList(params);
      
      // 런타임 목록 조회
      List<RuntimeDTO> runtimeList = getRuntimeList(request);
      
      // 각 영화에 런타임 정보 설정
      for (MovieDTO movie : movieList) {
          for (RuntimeDTO runtime : runtimeList) {
              if (movie.getMovieNo() == runtime.getMovieNo()) { // 영화 번호로 매칭
                  movie.setRuntimeInfo(runtime); // 런타임 정보 설정
                  break;
              }
          }
      }

      return movieList;
  }
  

  @Transactional(readOnly = true)
  @Override
  public MovieDTO getMovieById(int movieNo) {
    return adminMovieMapper.getMovieById(movieNo);
  }
  // ------------------------- 사용자 정보 이동 -------------------------
  
  
  
  
  
  // ------------------------- 상영시각 정보 이동 -------------------------
  @Transactional(readOnly = true)
  @Override
  public List<RuntimeDTO> getRuntimeList(HttpServletRequest request) {
    Map<String, Object> params = new HashMap<>();
    return adminMovieMapper.getRuntimeList(params);
  }

  
  @Transactional(readOnly = true)
  @Override
  public RuntimeDTO getRuntimeById(int movieNo) {
    return adminMovieMapper.getRuntimeById(movieNo);
  }
  // ------------------------- 상영시각 정보 이동 -------------------------

  
  
  
}