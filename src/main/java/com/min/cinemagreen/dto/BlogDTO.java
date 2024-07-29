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
public class BlogDTO {
  private int blogNo;
  private String title;
  private String contents;
  private int hit;
  private int userNo;
  private Date createDt;
  private Date modifyDt;
  private String name;

}

