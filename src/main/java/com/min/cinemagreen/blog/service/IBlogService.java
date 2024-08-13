package com.min.cinemagreen.blog.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.min.cinemagreen.dto.BlogDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface IBlogService {
  ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile);
  int saveBlog(BlogDTO blogDTO, HttpSession session);
  ResponseEntity<Map<String, Object>> getBlogList(HttpServletRequest request);
  int increseHit(int blogNo);
  BlogDTO getBlogByNo(int blogNo, HttpSession session);
  ResponseEntity<Map<String, Object>> saveBlogCommentParent(HttpServletRequest request);
  ResponseEntity<Map<String, Object>> getBlogCommentList(HttpServletRequest request);
  ResponseEntity<Map<String, Object>> saveBlogCommentChild(HttpServletRequest request);
  int deletePost(BlogDTO blogDTO);
}