package com.min.cinemagreen.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.UserInfoDTO;

@Mapper
public interface IUserInfoMapper {

  List<UserInfoDTO> getUserList(Map<String, Object> params); // 모든 사용자 가져오기

  UserInfoDTO getUserById(int userNo); // 해당 사용자 가져오기

  int adminUpdateUser(UserInfoDTO userInfo); // 수정

  int adminDeleteUser(int userNo); // 삭제

  int adminInsertUser(UserInfoDTO user); // 사용자 추가

  UserInfoDTO doubleEmailCheckDo(UserInfoDTO email); // 이메일 중복체크

}
