package com.min.cinemagreen.user.controller;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.user.service.IUserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@RequestMapping("/user")
@Controller
public class UserController {

  private final IUserService userService;
  
  @GetMapping(value = "/signup.page")
  public String signupPage(HttpSession session, Model model ) throws UnsupportedEncodingException {
    userService.makeNaverApi(session);
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
                         , HttpSession session, Model model) throws UnsupportedEncodingException {
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
    userService.makeNaverApi(session); 
    return "user/signin";
  }
  
  @PostMapping(value = "/signin.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> signinDo(HttpServletRequest request) {
    return userService.signin(request);
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
  
  @GetMapping(value = "/userpage.page")
  public String userpage(HttpSession session) {
//등급    
    userService.getUserGrade(session);
    return "user/userpage";
  }
  @PostMapping(value = "/updateInf.do")
  public String updateInf(UserDTO user, HttpSession session, RedirectAttributes rttr) {
    rttr.addFlashAttribute("updateMessage", userService.updateInf(user, session) == 1 ? "회원 정보 수정 성공" : "회원 정보 수정 실패");
    return "redirect:/user/userpage.page";
  }
  
  @GetMapping(value = "/pwchange.page")
  public String pwchange() {
    return "user/pwchange";
  }
  
  @PostMapping(value = "/pwchange.do")
  public String pwchange(HttpServletRequest request, RedirectAttributes rttr) {
    
    String redirectURL;
    String message;
    if(userService.pwchange(request) == 1) {
      redirectURL = "/user/userpage.page";
      message = "비밀번호 변경 성공";
    } else {
      redirectURL = "/user/pwchange.page";
      message = "비밀번호 변경 실패";
    }
    rttr.addFlashAttribute("pwchangeMessage", message);
    return "redirect:" + redirectURL;
  }
  
  @GetMapping(value = "/pwfind.page")
  public String pwfind() {
    return "user/pwfind";
  }
  
  @PostMapping(value = "/pwupdate.do")
  public String pwupdate(HttpServletRequest request, RedirectAttributes rttr) {
    
    String redirectURL;
    String message;
    if(userService.pwupdate(request) == 1) {
      redirectURL = "/user/signin.page";
      message = "비밀번호 변경 성공";
    } else {
      redirectURL = "/user/pwfind.page";
      message = "비밀번호 변경 실패";
    }
    rttr.addFlashAttribute("pwupdateMessage", message);
    return "redirect:" + redirectURL;
  }
  
  @GetMapping(value = "/emailfind.page")
  public String emailfind() {
    return "user/emailfind";
  }
  
  @PostMapping(value = "/emailfind.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> emailfindDo(HttpServletRequest request) {
    return userService.emailfindDo(request);
  }
  
  @PostMapping(value = "/overlapcheck.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> overlapcheckDo(UserDTO email) {
    return userService.overlapcheckDo(email);
  }
  
  @GetMapping(value = "/naverGetToken.do")
  public String naverGetToken(HttpServletRequest request, RedirectAttributes rttr) throws UnsupportedEncodingException{
    
    String accessToken = userService.naverGetToken(request);
    rttr.addFlashAttribute("accessToken", accessToken);
    return "redirect:/user/callProfile.do";
    
  }
  @GetMapping(value = "/callProfile.do")
  public String callProfile(@ModelAttribute("accessToken") String accessToken, HttpServletRequest request) {
    
    userService.callProfile(accessToken, request);
    HttpSession session = request.getSession();
    String URL = (String) session.getAttribute("URL");
    return "redirect:" + URL;
  }
  
  @GetMapping(value = "/snssignup.page")
  public String snsSignup() {
    return "user/snssignup";
  }
  
  @PostMapping(value = "/snssignup.do")
  public String snssignup(UserDTO user, RedirectAttributes rttr) {
    String redirectURL;
    String message;
    if(userService.snsSignup(user) == 1) {
      redirectURL = "/main.do";
      message = "회원 가입 성공";
    } else {
      redirectURL = "/user/snssignup.page";
      message = "회원 가입 실패";
    }
    rttr.addFlashAttribute("signupMessage", message);
    
    
    return "redirect:" + redirectURL;
  }
  
  @PostMapping(value = "/profileUpload.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> profileUpload(@RequestParam("file") MultipartFile multipartFile, HttpSession session) {
    System.out.println("controller   " + multipartFile.getOriginalFilename());
    return userService.profileUpload(multipartFile, session);
  }
  
//티켓 가져오기//////////////////////////////////////////////////////
  @GetMapping(value = "/getuserticket.do")
  public ResponseEntity<Map<String, Object>> getUserTicket(HttpServletRequest request) {
    return userService.getUserTicket(request);
  }
  
  @GetMapping(value = "/ticketdetail.do")
  public ResponseEntity<Map<String, Object>> getTicketDetail(HttpServletRequest request) {
    return userService.getTicketDetail(request);
  }
  @GetMapping(value = "/ticketrefund.do")
  public ResponseEntity<Map<String, Object>> ticketRefund(HttpServletRequest request) {
    return userService.ticketRefund(request);
  }
//블로그/////////////////////////////////////////////////////////////
  
  @GetMapping(value = "/getUserBloglist.do")
  public ResponseEntity<Map<String, Object>> getUserBloglist(HttpServletRequest request) {
    return userService.getUserBloglist(request);
  }
  
  
}