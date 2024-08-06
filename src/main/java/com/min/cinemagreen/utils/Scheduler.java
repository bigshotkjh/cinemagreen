package com.min.cinemagreen.utils;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.movie.service.IMovieService;
import com.min.cinemagreen.user.mapper.IUserMapper;
import com.min.cinemagreen.user.service.IUserService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@EnableScheduling
@Configuration

public class Scheduler {

  private final IUserMapper userMapper;
  private final IMovieService movieService;
  private final IUserService userService;
  
  @Scheduled(cron = "0 30 4 * * *")
  public void getBoxOfficeList() {
    movieService.getBoxOfficeList();
  }
  
  @Scheduled(cron = "1 0 0 * * *")
  public void updateAge() {

    LocalDate currentDate = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMdd");
    String today = currentDate.format(formatter);
    UserDTO birthUser = new UserDTO();
    birthUser.setBirthYear(today);
    
    List<UserDTO> userList = userMapper.getBirthUserList(birthUser);
    for (UserDTO user : userList) {
      formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
      LocalDate birthDate = LocalDate.parse(user.getBirthYear(), formatter);
      int age = Period.between(birthDate, currentDate).getYears();
      System.out.println(user.getAge());
      user.setAge(age);
      userMapper.ageUpdate(user);
      userService.sendBrithDayEmail(user);
      
    }
  }
}
