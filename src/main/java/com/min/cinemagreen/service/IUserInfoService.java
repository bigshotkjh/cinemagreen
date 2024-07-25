package com.min.cinemagreen.service;

import java.util.List;

import com.min.cinemagreen.dto.UserInfoDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface IUserInfoService {
    List<UserInfoDTO> getUserList(HttpServletRequest request); // request 매개변수 추가
}