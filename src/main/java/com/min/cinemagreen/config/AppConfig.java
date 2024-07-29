package com.min.cinemagreen.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AppConfig {

  @Value("${tmdb.api.key}")
  private String apiKey;
  
  @Bean
  RestTemplate restTemplate() {
    RestTemplate restTemplate = new RestTemplate();
    restTemplate.getInterceptors().add((request, body, execution) -> {
      request.getHeaders().add("Authorization", "Bearer " + apiKey);
      request.getHeaders().add("accept", "application/json");
      return execution.execute(request, body);
    });
    return restTemplate;
  }
    
}
