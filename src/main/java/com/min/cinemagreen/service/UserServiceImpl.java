package com.min.cinemagreen.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.mapper.IUserMapper;
import com.min.cinemagreen.utils.MailUtils;
import com.min.cinemagreen.utils.SecurityUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements IUserService {

	private final IUserMapper userMapper;
	private final SecurityUtils securityUtils;
	private final MailUtils mailUtils;
  
  @Transactional(readOnly = true)
  @Override
  public ResponseEntity<Map<String, Object>> sendCode(String email) {
	    
    // 인증 코드 생성
    String code = securityUtils.getRandomCode(6, true, true);
    
    // 메일 보내기
    mailUtils.sendMail(
        email
      , "[boot]인증요청"
      , "<div>인증코드는 <strong>" + code + "</strong>입니다."
    );
    
    // {"code": "A43CF0"}
    return ResponseEntity.ok(Map.of("code", code));
    
  }
  
  @Override
  public int signup(UserDTO user) {
    
    // 비밀번호 암호화
    user.setPw( securityUtils.getSha256(user.getPw()) );
    
    // 이름 크로스 사이트 스크립팅 처리
    user.setName( securityUtils.preventXss(user.getName()) );
    
    return userMapper.insertUser(user);
    
  }
  /*
  @Override
  public void signin(HttpServletRequest request) {
    
    String email = request.getParameter("email");
    String pw = securityUtils.getSha256(request.getParameter("pw"));
    
    Map<String, Object> params = new HashMap<>();
    params.put("email", email);
    params.put("pw", pw);
    
    UserDTO loginUser = userMapper.getUserByMap(params);
    
    if(loginUser != null) {
      
      HttpSession session = request.getSession();
      session.setAttribute("loginUser", loginUser);  // session 유지 시간 : application.properties
      
      String ip = request.getRemoteAddr();
      String userAgent = request.getHeader("User-Agent");
      String sessionId = session.getId();
      
      params.put("ip", ip);
      params.put("userAgent", userAgent);
      params.put("sessionId", sessionId);
      
      userMapper.insertAccess(params);
      
    }
    
  }*/
  @Override
  public ResponseEntity<Map<String, Object>> signin(HttpServletRequest request) {
    
    String email = request.getParameter("email");
    String pw = securityUtils.getSha256(request.getParameter("pw"));
    
    Map<String, Object> params = new HashMap<>();
    params.put("email", email);
    params.put("pw", pw);
    
    UserDTO loginUser = userMapper.getUserByMap(params);
    int signinResult;
    if(loginUser != null) {
      
      HttpSession session = request.getSession();
      session.setAttribute("loginUser", loginUser);  // session 유지 시간 : application.properties
      
      String ip = request.getRemoteAddr();
      String userAgent = request.getHeader("User-Agent");
      String sessionId = session.getId();
      
      params.put("ip", ip);
      params.put("userAgent", userAgent);
      params.put("sessionId", sessionId);
      
      userMapper.insertAccess(params);
      signinResult = 1;
    }else {
      signinResult = 0;
    }
    return ResponseEntity.ok(Map.of("isSuccess", signinResult == 1 ));
  }
  
  @Override
  public int leave(HttpSession session) {
    
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    
    if(loginUser == null)  // 세션 만료 대비
      return 0;
    
    session.invalidate();
      
    return userMapper.deleteUser(loginUser.getUserNo());
    
  }
  /*
  @Override
  public UserDTO getUserInf(HttpSession session) {
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    
    return userMapper.getUserInf(loginUser.getUserNo());
  }*/
  
  @Override
  public int updateInf(UserDTO user, HttpSession session) {
     
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null)  // 로그인이 풀린 유저
      return 0; 

    user.setUserNo(loginUser.getUserNo());
    user.setEmail(loginUser.getEmail());
    session.setAttribute("loginUser", user); 
    return userMapper.updateInf(user);
    
    
  }
  
  @Override
  public int pwchange(HttpServletRequest request) {
    /* 번호 같이 넣어서 유저dto로 걍 db에 두번 들려라.*/
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null)  // 세션 만료 대비
      return 0;
    int userNo = loginUser.getUserNo();
    String oldpw = securityUtils.getSha256(request.getParameter("oldpw"));
    String pw = securityUtils.getSha256(request.getParameter("pw"));
    Map<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("oldpw", oldpw);
    params.put("pw", pw);
    
    return userMapper.pwchange(params);
  }
  
  @Override
  public int pwupdate(HttpServletRequest request) {

    String email = request.getParameter("email");
    String pw = securityUtils.getSha256(request.getParameter("pw"));

    Map<String, Object> params = new HashMap<>();
    params.put("email", email);
    params.put("pw", pw);
    
    return userMapper.pwupdate(params);
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> emailfindDo(HttpServletRequest request) {
    
    String pw = securityUtils.getSha256(request.getParameter("pw"));
    String mobile = request.getParameter("mobile");
    
    Map<String, Object> params = new HashMap<>();
    params.put("pw", pw);
    params.put("mobile", mobile); 
      
    UserDTO user = userMapper.emailfindDo(params);
    String email = user.getEmail();
  
    return ResponseEntity.ok(Map.of("email", email));
  }
  
  
}

