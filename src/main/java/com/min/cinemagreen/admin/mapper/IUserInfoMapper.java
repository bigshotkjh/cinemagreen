package com.min.cinemagreen.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.min.cinemagreen.dto.UserInfoDTO;

@Mapper
public interface IUserInfoMapper {
    
    /**
     * 사용자 목록을 가져옵니다.
     * @param params 필터링 및 페이징을 위한 파라미터
     * @return 사용자 목록
     */
    List<UserInfoDTO> getUserList(Map<String, Object> params);
    
    /**
     * 사용자 ID로 사용자 정보를 가져옵니다.
     * @param userNo 사용자 번호
     * @return 사용자 정보
     */
    UserInfoDTO getUserById(int userNo);
    
    /**
     * 관리자가 특정 사용자를 삭제합니다.
     * @param userNo 삭제할 사용자 번호
     * @return 삭제 성공 여부
     */
    void adminUpdateInf(int userNo, UserInfoDTO user);
    
    void adminDeleteUser(int userNo);
    
    
}