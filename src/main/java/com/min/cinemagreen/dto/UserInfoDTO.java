package com.min.cinemagreen.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class UserInfoDTO {
    private int userNo;
    private String name;
    private String email;
    private String mobile;
    private Date signupDt;
}
