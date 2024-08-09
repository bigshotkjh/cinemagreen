package com.min.cinemagreen.user.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.BlogDTO;
import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.dto.UserTicketDTO;

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
  int insertSnsUser(UserDTO user);
  UserDTO getsnsUserInfo(UserDTO user);
  int ageUpdate(UserDTO user);
  int updateprofile(Map<String, Object> params);
  List<UserDTO> getBirthUserList(UserDTO birthUser);
//등급
  List<UserTicketDTO> getAmounts(Map<String, Object> params);
  void updateUserGrade(Map<String, Object> params);
//티켓/////////////////////////
  int getTicketCount(int userNo);
  List<UserTicketDTO> getUserTicketList(Map<String, Object> params);
  UserTicketDTO getTicketDetail(Map<String, Object> params);
  //List<UserGrandeDTO> getUserGrande(int userNo);
//블로그//////////////////
  int getBlogCount(int userNo);
  List<BlogDTO> userGetBlogList(Map<String, Object> params);
  

}
