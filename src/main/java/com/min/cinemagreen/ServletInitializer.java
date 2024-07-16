package com.min.cinemagreen;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/* war 배포의 경우에만 생기는 파일
 * 
 * 외장 WAS 를 돌리려면 web.xml (Deployment Descriptor, DD) 에 애플리케이션 컨텍스트를 등록해야 한다.
 * Servlet 3.0 이후 web.xml 대신 WebApplicationInitializer 인터페이스를 구현한 구현 클래스를 사용한다.
 * SpringBootServletInitializer 클래스가 바로 WebApplicationInitializer 인터페이스의 구현 클래스이다.  */

public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(CinemagreenApplication.class);
	}

}
