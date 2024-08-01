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
public class UserDTO {
  private int userNo;
  private String email;
  private String pw;
  private String name;
  private String gender;
  private String mobile;
  private String grade;
  private int sns;
  private Date pwModifyDt;
  private Date signupDt;
  private String birthYear;
  private int age;
  private String postcode;
  private String address;
  private String detailAddress;
  private String extraAddress;
  private String uploadPath;
  private String filesystemName;
}
