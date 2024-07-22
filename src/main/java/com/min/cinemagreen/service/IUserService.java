package com.min.cinemagreen.service;

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
  /*UserDTO getUserInf();*/
  int updateInf(UserDTO user, HttpSession session);
  int pwchange(HttpServletRequest request);
}
