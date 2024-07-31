package com.min.cinemagreen.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
// import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.web.client.RestTemplate;

/* RestTemplate
 * 
 * 1. 간단하게 REST 방식 API를 호출할 수 있는 Spring 내장 클래스
 * 2. JSON, XML 응답 모두 처리 가능
 * 3. 요청 방식에 따른 지원 메소드가 존재함
 *   1) GET    : getForObject(), getForEntity()
 *   2) POST   : postForLocation(), postForObject(), postForEntity()
 *   3) PUT    : put()
 *   4) DELETE : delete()
 * 4. 앞으로는 WebClient로 대체될 예정  */

@MapperScan(basePackages = {"com.min.cinemagreen.mapper", "com.min.cinemagreen.admin.mapper", "com.min.cinemagreen.payment.mapper", "com.min.cinemagreen.user.mapper", "com.min.cinemagreen.movie.mapper"})
@Configuration
public class RestTemplateConfig {

  // 현재는 시스템 변수로 OPENAI_API_KEY 값을 활용. 향후 docker 환경 변수로 수정하고 아래 코드로 대체해야 함
  // @Value("${openai.api.key}")
  private String openaiApiKey = System.getenv("OPENAI_API_KEY");  // 환경 변수 OPENAI_API_KEY 등록할 것(사용자 변수 말고, 시스템 변수로 등록)
  
  @Primary
  @Bean
  @Qualifier("openaiRestTemplate")
  RestTemplate openaiRestTemplate() {
    RestTemplate restTemplate = new RestTemplate();
    restTemplate.getInterceptors().add((request, body, execution) -> {
      request.getHeaders().add("Authorization", "Bearer " + openaiApiKey);
      return execution.execute(request, body);
    });
    return restTemplate;
  }
  
  @Bean
  @Qualifier("movieApiRestTemplate")
  RestTemplate movieApiRestTemplate() {
    RestTemplate restTemplate = new RestTemplate();
    return restTemplate;
  }
  
}