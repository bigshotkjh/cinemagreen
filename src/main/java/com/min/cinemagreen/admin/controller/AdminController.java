package com.min.cinemagreen.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.min.cinemagreen.admin.service.IUserInfoService;
import com.min.cinemagreen.dto.UserInfoDTO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdminController {

  private final IUserInfoService userInfoService;

  @GetMapping("/admin.page")
  public String adminPage(Model model) {
    List<UserInfoDTO> userList = userInfoService.getUserList(null);
    model.addAttribute("userList", userList);
    return "admin/admin"; // 사용자 목록
  }

  @GetMapping(value = "/getUserList.do", produces = "application/json")
  public ResponseEntity<List<UserInfoDTO>> getUserListDo(HttpServletRequest request) {
    return ResponseEntity.ok(userInfoService.getUserList(request));
  } // 모든 사용자 목록

  @PostMapping(value = "/adminUpdateUser.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> adminUpdateUser(@RequestBody UserInfoDTO userInfo) {
    System.out.println(userInfo);
    int result = userInfoService.adminUpdateUser(userInfo);
    return ResponseEntity.ok(Map.of("isSuccess", result == 1)); // {"isSuccess": true}
  } // 유저 수정

  @PostMapping(value = "/adminDeleteUser.do")
  public String adminDeleteUser(@RequestParam int userNo, RedirectAttributes rttr) {
    userInfoService.adminDeleteUser(userNo);
    rttr.addFlashAttribute("deleteMessage", "회원 삭제 성공");
    return "redirect:/admin/admin.page"; // 삭제 후 사용자 목록으로 리다이렉트
  } // 유저 삭제

  @GetMapping(value = "/insertuser.page")
  public String insertuserPage() {
    return "admin/insertuser";
  } // 사용자 추가 페이지로 이동

  @PostMapping(value = "/doubleEmailCheck.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> doubleEmailCheckDo(UserInfoDTO email) {
    return userInfoService.doubleEmailCheckDo(email);
  } // 이메일 중복검사

  @PostMapping(value = "/adminInsertUser.do")
  public String adminInsertUserDo(UserInfoDTO user, RedirectAttributes rttr) {
    String redirectURL;
    String message;
    if (userInfoService.adminInsertUser(user) == 1) {
      redirectURL = "/main.do";
      message = "회원 가입 성공";
    } else {
      redirectURL = "/user/signup.page";
      message = "회원 가입 실패";
    }
    rttr.addFlashAttribute("signupMessage", message);

    return "redirect:" + redirectURL;
  } // 유저 추가

  @GetMapping(value = "/getUserDetail/{userNo}", produces = "application/json")
  public ResponseEntity<UserInfoDTO> getUserById(@PathVariable int userNo) {
    UserInfoDTO user = userInfoService.getUserById(userNo);
    return ResponseEntity.ok(user);
  } // 유저 상세보기에 해당 유저 정보 넣기

}