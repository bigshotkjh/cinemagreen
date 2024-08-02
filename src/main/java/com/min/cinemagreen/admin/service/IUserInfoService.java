package com.min.cinemagreen.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.UserInfoDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface IUserInfoService {

  List<UserInfoDTO> getUserList(HttpServletRequest request); // 모든 사용자 정보 가져오기

  UserInfoDTO getUserById(int userNo); // 특정 사용자 정보 가져오기

  int adminUpdateUser(UserInfoDTO userInfo); // 사용자 정보 수정

  String adminDeleteUser(int userNo); // 사용자 삭제

  int adminInsertUser(UserInfoDTO user); // 사용자 추가

  ResponseEntity<Map<String, Object>> doubleEmailCheckDo(UserInfoDTO email); // 이메일 중복 확인


}
