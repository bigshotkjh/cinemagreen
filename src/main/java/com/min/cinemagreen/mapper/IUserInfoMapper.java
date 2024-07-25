package com.min.cinemagreen.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.min.cinemagreen.dto.UserInfoDTO;

@Mapper
public interface IUserInfoMapper {
	List<UserInfoDTO> getUserList(Map<String, Object> params);
}