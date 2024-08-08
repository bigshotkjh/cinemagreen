package com.min.cinemagreen.admin.controller;

import java.util.HashMap;
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

import com.min.cinemagreen.admin.service.IAdminMovieService;
import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.dto.RuntimeDTO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdminMovieController {

  private final IAdminMovieService adminMovieService;

  // ------------------------- 페이지 이동 -------------------------
  @GetMapping("/movie.page")
  public String moviePage(Model model) {
    List<MovieDTO> movieList = adminMovieService.getMovieList(null);
    model.addAttribute("movieList", movieList);
    return "admin/movie"; // 영화 목록
  }
  // ------------------------- 페이지 이동 -------------------------

  // ------------------------ 영화 관련 기능 ------------------------
  @GetMapping(value = "/getMovieList.do", produces = "application/json")
  public ResponseEntity<List<MovieDTO>> getMovieListDo(HttpServletRequest request) {
    return ResponseEntity.ok(adminMovieService.getMovieList(request));
  } // 모든 영화 목록
  // ------------------------ 영화 관련 기능 ------------------------

  // ------------------------ 상영 시각 관련 기능 ------------------------
  @GetMapping(value = "/getRuntimeList.do", produces = "application/json")
  public ResponseEntity<List<RuntimeDTO>> getRuntimeList() {
    List<RuntimeDTO> runtimeList = adminMovieService.getRuntimeList(); // 모든 상영 시각 목록 가져오기
    return ResponseEntity.ok(runtimeList); // JSON 형태로 반환
  }

  @PostMapping(value = "/adminInsertTime.do")
  public ResponseEntity<Map<String, Object>> adminInsertTimeDo(@RequestBody Map<String, Object> params) {

    // startTime 변환
    String startTime = (String) params.get("startTime");
    System.out.println(startTime);
    String formattedStartTime = startTime.replace("T", "").replace("-", "").replace(":", "");
    System.out.println(formattedStartTime);
    // 변환된 startTime을 params에 다시 저장
    params.put("startTime", formattedStartTime);

    int result = adminMovieService.adminInsertTime(params); // int 반환

    Map<String, Object> response = new HashMap<>();
    response.put("success", result > 0);
    response.put("result", result);

    return ResponseEntity.ok(response);
  } // 상영 시각 추가
  // ------------------------ 상영 시각 관련 기능 ------------------------

  // ------------------------------- 추가 기능 -------------------------------
  @GetMapping(value = "/getMovieDetail/{movieNo}", produces = "application/json")
  public ResponseEntity<MovieDTO> getMovieById(@PathVariable int movieNo) {
    MovieDTO movie = adminMovieService.getMovieById(movieNo);
    return ResponseEntity.ok(movie);
  } // 영화 상세보기에 해당 유저 정보 넣기
  // ------------------------------- 추가 기능 -------------------------------

}
