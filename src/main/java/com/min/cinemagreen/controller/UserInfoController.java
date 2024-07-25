package com.min.cinemagreen.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.min.cinemagreen.dto.UserInfoDTO;
import com.min.cinemagreen.service.IUserInfoService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class UserInfoController {

    private final IUserInfoService userInfoService;

    @GetMapping(value = "/userinfo.page")
    public String userinfoPage(Model model) {
        List<UserInfoDTO> userList = userInfoService.getUserList(null); // request가 필요 없다면 null 전달
        model.addAttribute("userList", userList); // 모델에 추가
        return "admin/userinfo"; // JSP 페이지 이름
    }

    @GetMapping(value = "/getUserList.do", produces = "application/json")
    public ResponseEntity<List<UserInfoDTO>> getUserListDo(HttpServletRequest request) {
        return ResponseEntity.ok(userInfoService.getUserList(request)); // 수정된 메소드 호출
    }
}