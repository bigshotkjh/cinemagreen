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
    public List<UserInfoDTO> getUserList(HttpServletRequest request) { // request 매개변수 추가
        Map<String, Object> params = new HashMap<>();
        // 필요한 경우 request를 사용하여 params에 추가 로직 구현 가능
        return userInfoMapper.getUserList(params); // 사용자 목록 반환
    }
}