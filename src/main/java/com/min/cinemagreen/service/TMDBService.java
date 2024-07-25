package com.min.cinemagreen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.min.cinemagreen.dto.MovieDTO;

@Service
public class TMDBService {

  @Autowired
  private RestTemplate restTemplate;

  public List<TMDBResult> getMovies() {
    
    String url = "https://api.themoviedb.org/3/discover/movie?language=ko-KR&region=KR&primary_release_date.gte=2024-07-01&primary_release_date.lte=2024-07-31&page=1";
    TMDBResponse response = restTemplate.getForObject(url, TMDBResponse.class);
    List<TMDBResult> results = response.getResults();
    for(TMDBResult result : results) {
      MovieDTO movieDTO = MovieDTO.builder()
          .title(result.getTitle())
          .subTitle(result.getOriginal_title())
          .story(result.getOverview())
          .grade("none")  // Grade.java 로 대체 
          .ticketRate(0)  // API 제공x
          .reviewScore(0) // DetailResult.java의 vote_average 로 대체
          .ticketSale(0)  // DetailResult.java의 revenue 로 대체
          .openingDt(result.getRelease_date())
          .runningTime(0)
          .build();
    }

    return response.getResults();
    
  }

}
