package com.min.cinemagreen.blog.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.min.cinemagreen.dto.BlogDTO;
import com.min.cinemagreen.blog.service.IBlogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/blog")
@Controller
public class BlogController {

  private final IBlogService blogService;
  
  @GetMapping(value = "/list.do")
  public String listDo() {
    return "blog/list";
  }
  
  @GetMapping(value = "/write.page")
  public String writePage() {
    return "blog/write";
  }
  
  @PostMapping(value = "/summernote/imageUpload.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> summernoteImageUploadDo(@RequestParam("file") MultipartFile multipartFile) {
    return blogService.summernoteImageUpload(multipartFile);
  }
  
  @PostMapping(value = "/saveBlog.do")
  public String saveBlogDo(BlogDTO blogDTO, HttpSession session, RedirectAttributes rttr) {
    rttr.addFlashAttribute("saveBlogMessage", blogService.saveBlog(blogDTO, session) == 1 ? "블로그 추가 성공" : "블로그 추가 실패");
    return "redirect:/blog/list.do";
  }
  
  @GetMapping(value = "/getBlogList.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> getBlogListDo(HttpServletRequest request) {
    return blogService.getBlogList(request);
  }
  
  @GetMapping(value = "/updateHit.do")
  public String updateHitDo(@RequestParam("blogNo") int blogNo) {
    blogService.increseHit(blogNo);
    return "redirect:/blog/detail.do?blogNo=" + blogNo;
  }
  
  @GetMapping(value = "/detail.do")
  public String detailDo(@RequestParam("blogNo") int blogNo, Model model) {
    model.addAttribute("blog", blogService.getBlogByNo(blogNo));
    return "blog/detail";
  }
  
  @PostMapping(value = "/saveBlogCommentParent.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> saveBlogCommentParentDo(HttpServletRequest request) {
    return blogService.saveBlogCommentParent(request);
  }
  
  @GetMapping(value = "/getBlogCommentList.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> getBlogCommentListDo(HttpServletRequest request) {
    return blogService.getBlogCommentList(request);
  }
  
  @PostMapping(value = "/saveBlogCommentChild.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> saveBlogCommentChildDo(HttpServletRequest request) {
    return blogService.saveBlogCommentChild(request);
  }
  
}
