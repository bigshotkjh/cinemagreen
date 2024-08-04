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
public class BlogCommentDTO {
  private int commentNo;
  private int userNo;
  private int blogNo;
  private String contents;
  private Date createDt;
  private int state;
  private int depth;
  private int groupNo;
  private int groupOrder;
  private String name;
  private String email;
}
