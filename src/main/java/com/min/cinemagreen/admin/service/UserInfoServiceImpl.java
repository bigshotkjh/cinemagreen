package com.min.cinemagreen.admin.service;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.cinemagreen.admin.mapper.IUserInfoMapper;
import com.min.cinemagreen.dto.UserInfoDTO;
import com.min.cinemagreen.utils.SecurityUtils;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class UserInfoServiceImpl implements IUserInfoService {

  private final IUserInfoMapper userInfoMapper;
  private final SecurityUtils securityUtils;
  
  
  // ------------------------- 사용자 정보 이동 -------------------------
  @Transactional(readOnly = true)
  @Override
  public List<UserInfoDTO> getUserList(HttpServletRequest request) {
    Map<String, Object> params = new HashMap<>();
    return userInfoMapper.getUserList(params);
  }

  @Transactional(readOnly = true)
  @Override
  public UserInfoDTO getUserById(int userNo) {
    return userInfoMapper.getUserById(userNo);
  }
  // ------------------------- 사용자 정보 이동 -------------------------
  
  
  

  
  // ------------------------- 사용자 정보 수정, 삭제, 추가 -------------------------
  @Override
  public int adminUpdateUser(UserInfoDTO userInfo) {
    // 업데이트 로직
    return userInfoMapper.adminUpdateUser(userInfo);
  }

  @Override
  public String adminDeleteUser(int userNo) {
    // 사용자 삭제 로직 수행
    userInfoMapper.adminDeleteUser(userNo);

    // 항상 "success" 반환
    return "success";
  }

  @Override
  public int adminInsertUser(UserInfoDTO user) {

    // 비밀번호 암호화
    user.setPw(securityUtils.getSha256(user.getPw()));

    // 이름 크로스 사이트 스크립팅 처리
    user.setName(securityUtils.preventXss(user.getName()));
    // 하이픈 제거
    String mobile = user.getMobile();
    user.setMobile(mobile.replace("-", ""));
    // 나이계산
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    LocalDate birthDate = LocalDate.parse(user.getBirthyear(), formatter);
    LocalDate currentDate = LocalDate.now();
    int age = Period.between(birthDate, currentDate).getYears();
    user.setAge(age);
    return userInfoMapper.adminInsertUser(user);
  }
  // ------------------------- 사용자 정보 수정, 삭제, 추가 -------------------------
  
  
  
  
  
  
  // ----------------------------------- 이메일 -----------------------------------
  @Override
  public ResponseEntity<Map<String, Object>> doubleEmailCheckDo(UserInfoDTO email) {

    UserInfoDTO user = userInfoMapper.doubleEmailCheckDo(email);
    int doubleEmailCheckResult;
    if (user == null) {
      doubleEmailCheckResult = 1;
    } else {
      doubleEmailCheckResult = 0;
    }
    return ResponseEntity.ok(Map.of("isSuccess", doubleEmailCheckResult == 1));
  }
  // ----------------------------------- 이메일 -----------------------------------

}