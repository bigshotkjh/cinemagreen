package com.min.cinemagreen.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.BlogDTO;
import com.min.cinemagreen.dto.UserDTO;

@Mapper
public interface IUserMapper {
  int insertUser(UserDTO user);
  UserDTO getUserByMap(Map<String, Object> params);
  int insertAccess(Map<String, Object> params);
  int deleteUser(int userNo);
  UserDTO getUserInf(int userNo);
  int updateInf(UserDTO user);
  int pwchange(Map<String, Object> params);
  int pwupdate(Map<String, Object> params);
  UserDTO emailfindDo(Map<String, Object> params);
  UserDTO overlapcheckDo(UserDTO email);
  UserDTO xUsercheckDo(UserDTO email);
  int insertSnsUser(UserDTO user);
  UserDTO getsnsUserInfo(UserDTO user);
//블로그//////////////////
<<<<<<< HEAD
  int getBlogCount(int userNo);
  List<BlogDTO> userGetBlogList(Map<String, Object> params);
  
=======
  
  int getBlogCount(int userNo);
  List<BlogDTO> userGetBlogList(Map<String, Object> params);
 
>>>>>>> 35dde3a595c254bad5f0f3356d57b46334a7bdca
}
