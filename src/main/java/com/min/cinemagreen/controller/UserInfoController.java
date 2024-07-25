package com.min.cinemagreen.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        List<UserInfoDTO> userList = userInfoService.getUserList(null);
        model.addAttribute("userList", userList);
        return "admin/userinfo";
    }

    @GetMapping(value = "/getUserList.do", produces = "application/json")
    public ResponseEntity<List<UserInfoDTO>> getUserListDo(HttpServletRequest request) {
        return ResponseEntity.ok(userInfoService.getUserList(request));
    }
    
    @GetMapping(value = "/detail.page")
    public String detailPage(Model model, @RequestParam(required = false) int userNo) {
        List<UserInfoDTO> userList = userInfoService.getUserList(null);
        model.addAttribute("userList", userList);

        UserInfoDTO user = userInfoService.getUserById(userNo);
        model.addAttribute("user", user);
        return "admin/detail";
    }
    
    @PostMapping(value = "/adminUpdateInf.do")
    public String adminUpdateInf(UserInfoDTO user, RedirectAttributes rttr) {
        UserInfoDTO adminUpdatedInf = userInfoService.adminUpdateInf(user.getUserNo(), user);
        
        if (adminUpdatedInf != null) {
            rttr.addFlashAttribute("updateMessage", "회원 정보 수정 성공");
        } else {
            rttr.addFlashAttribute("updateMessage", "회원 정보 수정 실패");
        }
        
        return "redirect:/admin/userinfo.page";
    }

    @GetMapping(value = "/adminDeleteUser.do")
    public String adminDeleteUser(@RequestParam int userNo, RedirectAttributes rttr) {
        userInfoService.adminDeleteUser(userNo);
        rttr.addFlashAttribute("deleteMessage", "회원 삭제 성공");
        return "redirect:/admin/userinfo.page";
    }
    
    @GetMapping(value = "/insertuser.do")
    public String insertuserPage() {
        return "admin/insertuser";
      }
}