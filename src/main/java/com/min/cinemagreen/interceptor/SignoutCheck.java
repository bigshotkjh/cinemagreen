package com.min.cinemagreen.interceptor;

import java.io.PrintWriter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.min.cinemagreen.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class SignoutCheck implements HandlerInterceptor {

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    
    // preHandle() 메소드 반환 타입
    // true  : 가로 챈 요청을 수행하시오.
    // false : 가로 챈 요청을 수행하지 마시오. 
    
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
    
    if(loginUser != null) {
      
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>");
      out.println("  alert('해당 기능을 사용할 수 없습니다.')");
      out.println("  history.back()");
      out.println("</script>");
      out.close();
      
      // 가로 챈 요청을 수행하지 않는다.
      return false;
      
    }
    
    // 가로 챈 요청을 수행한다.
    return true;
    
  }
  
}
