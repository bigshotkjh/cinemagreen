package com.min.cinemagreen.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.service.IUserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@RequestMapping("/user")
@Controller
public class UserController {

  private final IUserService userService;
  
  @GetMapping(value = "/signup.page")
  public String signupPage() {
    return "user/signup";
  }
  
  @PostMapping(value = "/signup.do")
  public String signupDo(UserDTO user, RedirectAttributes rttr) {
    String redirectURL;
    String message;
    if(userService.signup(user) == 1) {
      redirectURL = "/main.do";
      message = "회원 가입 성공";
    } else {
      redirectURL = "/user/signup.page";
      message = "회원 가입 실패";
    }
    rttr.addFlashAttribute("signupMessage", message);
    return "redirect:" + redirectURL;
  }
  
  @GetMapping(value = "/sendCode.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> sendCode(@RequestParam String email) {
    return userService.sendCode(email);
  }
  
  @GetMapping(value = "/signin.page")
  public String signinPage(@RequestHeader(name = "referer") String referer
                         , Model model) {
    /* 이전 주소는 요청 헤더 referer 에 저장되어 있다. */
    String[] excludeURLs = {"/signup.page"};
    String url = referer;
    if(referer == null) {
      url = "/main.do";
    } else {
      for(String excludeURL : excludeURLs) {
        if(referer.contains(excludeURL)) {
          url = "/main.do";
          break;
        }
      }
    }
    model.addAttribute("url", url);
    return "user/signin";
  }
  
  @PostMapping(value = "/signin.do")
  public String signinDo(HttpServletRequest request) {
    userService.signin(request);
    return "redirect:" + request.getParameter("url");
  }
  
  @GetMapping(value = "/signout.do")
  public String signoutDo(HttpSession session) {
    session.invalidate();
    return "redirect:/main.do";
  }
  
  @GetMapping(value = "/leave.do")
  public String leave(HttpSession session, RedirectAttributes rttr) {
    rttr.addFlashAttribute("leaveMessage", userService.leave(session) == 1 ? "회원 탈퇴 성공" : "회원 탈퇴 실패");
    return "redirect:/main.do";
  }
  
}
