package com.min.cinemagreen.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.cinemagreen.dto.UserInfoDTO;
import com.min.cinemagreen.mapper.IUserInfoMapper;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserInfoServiceImpl implements IUserInfoService {

    private final IUserInfoMapper userInfoMapper;

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
    
    @Override
    public UserInfoDTO adminUpdateInf(int userNo, UserInfoDTO user) {
        // 업데이트 로직
        userInfoMapper.adminUpdateInf(userNo, user);
        return user; // 여기에 문제가 없도록 반환값을 확인
    }

    @Override
    public String adminDeleteUser(int userNo) {
        // 사용자 삭제 로직 수행
        userInfoMapper.adminDeleteUser(userNo); // 이 부분은 실제 삭제 로직으로 대체해야 합니다.
        
        // 항상 "success" 반환
        return "success"; 
    }
}