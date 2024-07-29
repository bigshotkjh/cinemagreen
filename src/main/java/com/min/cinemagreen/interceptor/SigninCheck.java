package com.min.cinemagreen.interceptor;

import java.io.PrintWriter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.min.cinemagreen.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class SigninCheck implements HandlerInterceptor {

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    
    // preHandle() 메소드 반환 타입
    // true  : 가로 챈 요청을 수행하시오.
    // false : 가로 챈 요청을 수행하지 마시오. 
    
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
    
    if(loginUser == null) {
      
      // 메시지 없이 곧바로 로그인 페이지로 이동하기
      // response.sendRedirect(request.getContextPath() + "/user/signin.page");
      
      // 메시지 보여준 뒤 로그인 페이지로 이동하기
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>");
      out.println("if(confirm('로그인이 필요한 기능입니다. 로그인 페이지로 이동할까요?')){");
      out.println("  location.href = '" + request.getContextPath() + "/user/signin.page'");
      out.println("} else {");
      out.println("  alert('요청이 취소되었습니다.')");
      out.println("  history.back()");
      out.println("}");
      out.println("</script>");
      out.close();
      
      // 가로 챈 요청을 수행하지 않는다.
      return false;
      
    }
    
    // 가로 챈 요청을 수행한다.
    return true;
    
  }
  
}