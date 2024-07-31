package com.min.cinemagreen.api;

import java.util.List;

import com.min.cinemagreen.api.DailyBoxOffice;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class BoxOfficeResult {
  private String boxofficeType;  // 박스오피스 종류를 출력합니다.
  private String showRange;      // 박스오피스 조회 일자를 출력합니다.
  private List<DailyBoxOffice> dailyBoxOfficeList;
}
