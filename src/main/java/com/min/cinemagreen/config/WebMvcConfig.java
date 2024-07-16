package com.min.cinemagreen.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.min.cinemagreen.interceptor.SigninCheck;
import com.min.cinemagreen.interceptor.SignoutCheck;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
    
    /* 정적 자원 관리
     *   정적 자원의 주소와 매핑된 디렉터리 명시  */
    
    registry.addResourceHandler("/static/**")       // static 으로 시작하는 모든 경로
      .addResourceLocations("classpath:/static/");  // src/main/resources/static 디렉터리
    
  }
  
}
