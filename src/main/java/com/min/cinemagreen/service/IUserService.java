package com.min.cinemagreen.service;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.min.cinemagreen.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface IUserService {
  ResponseEntity<Map<String, Object>> sendCode(String email);
  int signup(UserDTO user);
  ResponseEntity<Map<String, Object>> signin(HttpServletRequest request);
  int leave(HttpSession session);
  int updateInf(UserDTO user, HttpSession session);
  int pwchange(HttpServletRequest request);
  int pwupdate(HttpServletRequest request);
  ResponseEntity<Map<String, Object>> emailfindDo(HttpServletRequest request);
  ResponseEntity<Map<String, Object>> overlapcheckDo(UserDTO email);
  String naverGetToken(HttpServletRequest request) throws UnsupportedEncodingException;
  void callProfile(String accessToken ,HttpServletRequest request);
  void makeNaverApi(HttpSession session) throws UnsupportedEncodingException;
  int snsSignup(UserDTO user);
///블로그//////////////////
  ResponseEntity<Map<String, Object>> getUserBloglist(HttpServletRequest request);
}
