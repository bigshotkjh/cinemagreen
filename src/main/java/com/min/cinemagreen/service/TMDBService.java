package com.min.cinemagreen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.mapper.IMovieMapper;
import com.min.cinemagreen.service.Grade.Result;
import com.min.cinemagreen.service.Grade.Result.ReleaseDate;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class TMDBService {

  private final RestTemplate restTemplate;
  private final IMovieMapper movieMapper;

  public List<TMDBResult> getMovies() {
    
    String url = "https://api.themoviedb.org/3/discover/movie?language=ko-KR&region=KR&primary_release_date.gte=2024-07-01&primary_release_date.lte=2024-07-31&page=1";
    TMDBResponse response = restTemplate.getForObject(url, TMDBResponse.class);
    List<TMDBResult> tmbdResults = response.getResults();
    
    for(TMDBResult tmdbResult : tmbdResults) {
    
      int id = tmdbResult.getId();
      DetailResult detailResult = restTemplate.getForObject("https://api.themoviedb.org/3/movie/" + id, DetailResult.class);
      Grade grade = restTemplate.getForObject("https://api.themoviedb.org/3/movie/" + id + "/release_dates", Grade.class);
      List<Result> results = grade.getResults();
      String certification = "";
      for(Result result : results) {
        if("KR".equals(result.getIso_3166_1())) {
          ReleaseDate releaseDate = result.getRelease_dates().get(0);
          certification = releaseDate.getCertification();
          break;
        }
      }
      MovieDTO movieDTO = MovieDTO.builder()
          .title(tmdbResult.getTitle())
          .subTitle(tmdbResult.getOriginal_title())
          .story(tmdbResult.getOverview())
          .grade(certification)  // Grade.java 로 대체 
          .ticketRate(0)  // API 제공x
          .reviewScore(detailResult.getVote_average()) // DetailResult.java의 vote_average 로 대체
          .ticketSale(detailResult.getRevenue())  // DetailResult.java의 revenue 로 대체
          .openingDt(tmdbResult.getRelease_date())
          .runningTime(detailResult.getRuntime())
          .build();
      movieMapper.insertMovie(movieDTO);
    }

    return response.getResults();
    
  }

}
