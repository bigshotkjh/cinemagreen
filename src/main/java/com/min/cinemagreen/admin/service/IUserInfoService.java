package com.min.cinemagreen.admin.service;

import java.util.List;

import com.min.cinemagreen.dto.UserInfoDTO;

import jakarta.servlet.http.HttpServletRequest;

public interface IUserInfoService {
    
    List<UserInfoDTO> getUserList(HttpServletRequest request);
    UserInfoDTO getUserById(int userNo);
    UserInfoDTO adminUpdateInf(int userNo, UserInfoDTO user); // 사용자 정보 수정
    String adminDeleteUser(int userNo); // 사용자 삭제
}
