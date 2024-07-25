package com.min.cinemagreen.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
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
    String mobile = request.getParameter("mobile");
    
    Map<String, Object> params = new HashMap<>();
    params.put("mobile", mobile); 
      
    UserDTO user = userMapper.emailfindDo(params);
    String email = user.getEmail();
  
    return ResponseEntity.ok(Map.of("email", email));
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> overlapcheckDo(UserDTO email) {
    
    
    UserDTO user = userMapper.overlapcheckDo(email);
    int overlapcheckResult;
    if(user != null) {
      overlapcheckResult = 1;
    }else {
      overlapcheckResult = 0;
    }
    return ResponseEntity.ok(Map.of("isSuccess", overlapcheckResult == 1));
  }
  
  @Override
  public String naverGetToken(HttpServletRequest request) throws UnsupportedEncodingException {
    String clientId = "KxQPnOuYjOzlcaMNmVR2";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "tc4iVZch4O";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
        + "&client_id=" + clientId
        + "&client_secret=" + clientSecret
        + "&code=" + code
        + "&state=" + state;
    String accessToken = "";
    try {
      URL url = URI.create(apiURL).toURL();
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      if (responseCode == 200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuilder res = new StringBuilder();
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
      }
      br.close();
      if (responseCode == 200) {
        String result  = res.toString();
        System.out.println(result);
        JSONObject obj = new JSONObject(result); 
        accessToken = obj.getString("access_token");
        
      }
    } catch (Exception e) {
      // Exception 로깅
    }
    return accessToken;
  }
  
  @Override
  public void callProfile(String accessToken ,HttpServletRequest request) {
    
    String apiUrl = "https://openapi.naver.com/v1/nid/me";

    try {
        URL url = URI.create(apiUrl).toURL();
        
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", "Bearer " + accessToken); 

        int responseCode = con.getResponseCode();
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        // 응답 처리
        System.out.println("Response Code: " + responseCode);
        System.out.println("Response: " + response.toString());
        
        String result  = response.toString();
        System.out.println(result);
        JSONObject obj = new JSONObject(result); 
        
        JSONObject userInfObj = obj.getJSONObject("response");
        String email = userInfObj.getString("email");
        String mobile = userInfObj.getString("mobile");
        System.out.println(email);
        System.out.println(mobile);
        
        UserDTO user = new UserDTO();
        user.setEmail(email);
        user.setMobile(mobile);
        user.setSns(1);
        user.setName("네이버고객");
        
        HttpSession session = request.getSession();
        if(userMapper.overlapcheckDo(user) != null) {
          session.setAttribute("loginUser", user);  
        } else {
          /*가입정보를 더받자.*/
          userMapper.insertSnsUser(user);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
  }
  
  @Override
  public void makeNaverApi(HttpSession session) throws UnsupportedEncodingException {
    String clientId = "KxQPnOuYjOzlcaMNmVR2";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:9090/user/naverGetToken.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
         + "&client_id=" + clientId
         + "&redirect_uri=" + redirectURI
         + "&state=" + state;
    session.setAttribute("state", state);
    session.setAttribute("apiURL", apiURL);
    
    
  }
}

