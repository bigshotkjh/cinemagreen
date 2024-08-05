package com.min.cinemagreen.utils;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.min.cinemagreen.movie.service.IMovieService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@EnableScheduling
@Configuration

public class Scheduler {

  private final IMovieService movieService;
  
  @Scheduled(cron = "0 30 4 * * *")
  
  public void getBoxOfficeList() {
    movieService.getBoxOfficeList();
  }
}
