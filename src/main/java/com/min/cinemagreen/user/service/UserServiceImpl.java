package com.min.cinemagreen.user.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.min.cinemagreen.dto.BlogDTO;
import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.dto.UserTicketDTO;
import com.min.cinemagreen.user.mapper.IUserMapper;
import com.min.cinemagreen.utils.FileUploadUtils;
import com.min.cinemagreen.utils.MailUtils;
import com.min.cinemagreen.utils.PageUtils;
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
  private final PageUtils pageUtils;
  private final FileUploadUtils fileUploadUtils;
  
  @Transactional(readOnly = true)
  @Override
  public ResponseEntity<Map<String, Object>> sendCode(String email) {
      
    // 인증 코드 생성
    String code = securityUtils.getRandomCode(6, true, true);
    
    // 메일 보내기
    mailUtils.sendMail(
        email
      , "[CinemaGeen]인증요청"
      , "<div>인증코드는 <strong>" + code + "</strong>입니다.</div>"
    );
    
    // {"code": "A43CF0"}
    return ResponseEntity.ok(Map.of("code", code));
    
  }
  
  @Transactional(readOnly = true)
  @Override
  public void sendBrithDayEmail(UserDTO user) {

    
    // 인증 코드 생성

    //쿠폰도 만들어 메일로 쏴주고 할인도 해주면 좋을 듯.
    //String discountCoupon = securityUtils.getRandomCode(6, true, true);
    String email = user.getEmail();
    System.out.println();
    String name = user.getName();
    int age = user.getAge(); 
    System.out.println(email + name + age);
    // 메일 보내기
    mailUtils.sendMail(
        email
      , "[CinemaGeen] 생일을 축하드립니다."
      , "<div><strong>" + name + "</strong>님의 <strong>" + age + "</strong>번째 생일을 축하드립니다.</div>"
    );
    
    
  }
  
  @Override
  public int signup(UserDTO user) {
    
    // 비밀번호 암호화
    user.setPw( securityUtils.getSha256(user.getPw()) );
    
    // 이름 크로스 사이트 스크립팅 처리
    user.setName( securityUtils.preventXss(user.getName()) );
//하이픈 제거
    String mobile = user.getMobile();
    user.setMobile(mobile.replace("-", ""));
//나이계산
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    LocalDate birthDate = LocalDate.parse(user.getBirthYear(), formatter);
    LocalDate currentDate = LocalDate.now();
    int age = Period.between(birthDate, currentDate).getYears();
    user.setAge(age);
    user.setGrade("bronze");
    user.setProfilePath("/profile");
    user.setProfileName("defaultImg.png");
    
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
    int admin;
    int signinResult;
    int dtResult;
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
//나이계산
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
      LocalDate birthDate = LocalDate.parse(loginUser.getBirthYear(), formatter);
      LocalDate currentDate = LocalDate.now();
      int age = Period.between(birthDate, currentDate).getYears();
      loginUser.setAge(age);
      userMapper.ageUpdate(loginUser);
//admin check   
      if(loginUser.getUserNo() == 0) {
        admin = 1;
      }else {
        admin = 0;
      }
//90일 비밀번호
      Calendar calendar = Calendar.getInstance();
      long currentTimeMillis = System.currentTimeMillis();
      Date today = new Date(currentTimeMillis);
      Date lastPwModifyDt = loginUser.getPwModifyDt();
      calendar.setTime(lastPwModifyDt); // 마지막비번 변경일
      calendar.add(Calendar.DAY_OF_MONTH, 90);
      Date dateAfter90Days = new Date(calendar.getTimeInMillis()); //비밀번호 바꿔야 하는 날짜.
      if (today.compareTo(dateAfter90Days) > 0) { // 날짜 비교 
          dtResult = 1;
      } else {
          dtResult = 0;
      }
      signinResult = 1;
    }else {
      signinResult = 0;
      dtResult = 0;
      admin = 0;
    }
    return ResponseEntity.ok(Map.of("isSuccess", signinResult == 1 , "nowPwModify", dtResult == 1 ,"adminCheck", admin == 1 ));
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
    user.setSns(loginUser.getSns());
//모바일  청소
    String mobile = user.getMobile();
    String cleanNumber = mobile.replace("-", "");
    user.setMobile(cleanNumber);
//나이계산
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    LocalDate birthDate = LocalDate.parse(user.getBirthYear(), formatter);
    LocalDate currentDate = LocalDate.now();
    int age = Period.between(birthDate, currentDate).getYears();
    user.setAge(age);
    int result = userMapper.updateInf(user);
    Map<String, Object> params = new HashMap<>();
    params.put("email",loginUser.getEmail());
    params.put("pw", loginUser.getPw());
    loginUser = userMapper.getUserByMap(params);
    session.setAttribute("loginUser", loginUser);
    return result;
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
//모바일 청소   
    String mobile = request.getParameter("mobile");
    String cleanNumber = mobile.replace("-", "");
    Map<String, Object> params = new HashMap<>();
    params.put("mobile", cleanNumber); 
      
    UserDTO user = userMapper.emailfindDo(params);
    String email = user.getEmail();
  
    return ResponseEntity.ok(Map.of("email", email));
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> overlapcheckDo(UserDTO email) {
    
    UserDTO user = userMapper.overlapcheckDo(email);
    int overlapcheckResult;
    if(user == null) {
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
    HttpSession session = request.getSession();
    String resultUrl = "";
    
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
        String birthday = userInfObj.getString("birthday");
        String birthYear = userInfObj.getString("birthyear") + birthday;
        String name = userInfObj.getString("name");
        //모바일과 생년월일 정리
        String cleanBirthYear = birthYear.replace("-", "");
        String mobile = userInfObj.getString("mobile");
        String cleanNumber = mobile.replace("-", "");
        System.out.println(email);
        System.out.println(cleanNumber);
        System.out.println(cleanBirthYear);
        
        UserDTO user = new UserDTO();
        user.setEmail(email);
        user.setName(name);
        user.setMobile(cleanNumber);
        user.setBirthYear(cleanBirthYear);
        user.setSns(1);
        session.setAttribute("snsUser", user);
        
        if(userMapper.overlapcheckDo(user) != null) {
          UserDTO snsUser = userMapper.getsnsUserInfo(user);
        //나이계산
          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
          LocalDate birthDate = LocalDate.parse(snsUser.getBirthYear(), formatter);
          LocalDate currentDate = LocalDate.now();
          int age = Period.between(birthDate, currentDate).getYears();
          snsUser.setAge(age);
          userMapper.ageUpdate(snsUser);
          session.setAttribute("loginUser", snsUser);
        //접속기록
          String ip = request.getRemoteAddr();
          String userAgent = request.getHeader("User-Agent");
          String sessionId = session.getId();
          Map<String, Object> params = new HashMap<>();
          params.put("email", email);
          params.put("ip", ip);
          params.put("userAgent", userAgent);
          params.put("sessionId", sessionId);
          userMapper.insertAccess(params);
          resultUrl = "/main.do";

        } else {
          /* 부족한 가입정보를 더 받자.*/
          session.setAttribute("snsUser", user);
          resultUrl = "/user/snssignup.page";
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    }

    session.setAttribute("URL", resultUrl);
  }
  
  @Override
  public void makeNaverApi(HttpSession session) throws UnsupportedEncodingException {
    String clientId = "KxQPnOuYjOzlcaMNmVR2";//애플리케이션 클라이언트 아이디값"
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
  
  @Override
  public int snsSignup(UserDTO user) {
    
    // 이름 크로스 사이트 스크립팅 처리
    user.setName( securityUtils.preventXss(user.getName()) );
//나이계산
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    LocalDate birthDate = LocalDate.parse(user.getBirthYear(), formatter);
    LocalDate currentDate = LocalDate.now();
    int age = Period.between(birthDate, currentDate).getYears();
    user.setAge(age);
    user.setProfilePath("/profile");
    user.setProfileName("defaultImg.webp");
    
    return userMapper.insertSnsUser(user);

  }
//프로필 업로드     
  @Override
  public ResponseEntity<Map<String, Object>> profileUpload(MultipartFile multipartFile, HttpSession session) {

    System.out.println("service start");
    
  
    String profilePath = fileUploadUtils.getUploadPath(); 
    File profileDir = new File(profilePath);//profilePath를 직접 "D:/profile"로 넣어줘야 정상 동작해.
    if(!profileDir.exists())
      profileDir.mkdirs();
      
    String filesystemName = fileUploadUtils.getFilesystemName(multipartFile.getOriginalFilename());
    //String filesystemName = multipartFile.getOriginalFilename();
    // 저장
    File file = new File(profileDir, filesystemName);
    try {
      multipartFile.transferTo(file);
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null)  // 로그인이 풀린 유저
      return null; 
    int userNo = loginUser.getUserNo();
    Map<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("profilePath", profilePath);
    params.put("profileName", filesystemName);
    userMapper.updateprofile(params);
    //session 업데이트
    params.put("email",loginUser.getEmail());
    params.put("pw", loginUser.getPw());
    loginUser = userMapper.getUserByMap(params);
    session.setAttribute("loginUser", loginUser);
    return ResponseEntity.ok(Map.of("url", profilePath  + "/" + filesystemName));
    
  }
  
//고객등급 만들기.
  @Override
  public void getUserGrade(HttpSession session) {
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    int userNo = loginUser.getUserNo();
    String grade = loginUser.getGrade();
  //6개월 만들기  
    // 현재 날짜
    LocalDate currentDate = LocalDate.now();
    
    // 6개월 전 날짜
    LocalDate sixMonthsAgo = currentDate.minusMonths(6);
    
    // SQL DATE 형식으로 변환
    Date sqlCurrentDate = Date.valueOf(currentDate);
    Date sqlSixMonthsAgo = Date.valueOf(sixMonthsAgo);
    
    Map<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("startDate", sqlSixMonthsAgo);
    params.put("endDate", sqlCurrentDate);
    List<UserTicketDTO> amounts  = userMapper.getAmounts(params);
    int point = 0;
    for(UserTicketDTO amount : amounts ) {
      point += amount.getAmount();
    }
    System.out.println("등급 포인트!!!!!!!!!!!!!!!!" + point);
    if(point > 1000000) {
      grade = "VIP";
    }else if(point > 100000) {
      grade = "gold";
    }else if(point > 100000) {
      grade = "silver";
    }else {
      grade = "bronze";
    }
    params.put("grade", grade);
    userMapper.updateUserGrade(params);
  }
////예매부분/////////////////
  @Override
  public ResponseEntity<Map<String, Object>> getUserTicket(HttpServletRequest request) {
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null)  // 로그인이 풀린 유저
      return null; 
    int userNo = loginUser.getUserNo();
    int page = 1;
    page = Integer.parseInt(request.getParameter("page"));//페이지를 받아왔네.
    int display = 5; //한 페이지에 표시할 게시물 수
    int total = userMapper.getTicketCount(userNo);//게시물 총수/ 맵퍼에 다녀와야해.
    System.out.println("total : " + total);
    System.out.println("display : " + display);
    System.out.println("page : " + page);
    pageUtils.setPaging(total, display, page);//페이징 정보를 설정

    System.out.println("비긴 : " + pageUtils.getBegin());
    System.out.println("엔드 : " + pageUtils.getEnd());
    
    
    Map<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("begin", pageUtils.getBegin());
    params.put("end", pageUtils.getEnd());//시작과 끝을 담고 리스트 받으러 가
    //티켓정보가져오기
    List<UserTicketDTO> ticketList = userMapper.getUserTicketList(params);
    String ticketPaging = pageUtils.getAsyncticketPaging();//pageUtils를 사용하여 페이징 HTML 코드를 생성
    return ResponseEntity.ok(Map.of("ticketList", ticketList, "ticketPaging", ticketPaging));
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> getTicketDetail(HttpServletRequest request) {

    /*
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null)
      return null; 
     userNo = loginUser.getUserNo();
     */
    String movieNm = request.getParameter("movieNm");
    String startTime = request.getParameter("startTime");
    String seatCode = request.getParameter("seatCode");
    Map<String, Object> params = new HashMap<>();
    params.put("movieNm", movieNm);
    params.put("startTime", startTime);
    params.put("seatCode", seatCode);
    //params.put("userNo", userNo);
    UserTicketDTO ticket = userMapper.getTicketDetail(params);
    int runtime = ticket.getRuntime();
    String rating = ticket.getRating();
    String ticketDt = ticket.getTicketDt();
    String payMethod = ticket.getPayMethod();
    int personCount = ticket.getPersonCount();
    int amount = ticket.getAmount();
    String payState = ticket.getPayState();
    String cancelDt = ticket.getCancelDt();
    String cancelStatus = ticket.getCancelStatus();
    

    Map<String, Object> ticketInf = new HashMap<>();
    ticketInf.put("movieNm", movieNm);
    ticketInf.put("startTime", startTime);
    ticketInf.put("seatCode", seatCode);
    ticketInf.put("runtime", runtime);
    ticketInf.put("rating", rating);
    ticketInf.put("ticketDt", ticketDt);
    ticketInf.put("payMethod", payMethod);
    ticketInf.put("personCount", personCount);
    ticketInf.put("amount", amount);
    ticketInf.put("payState", payState);
    ticketInf.put("cancelDt", cancelDt);
    ticketInf.put("cancelStatus", cancelStatus);
    
    //return ResponseEntity.ok(Map.of("movieNm", movieNm, "startTime", startTime, "seatCode", seatCode, "runtime", runtime, "rating", rating, "ticketDt", ticketDt, "payMethod", payMethod, "personCount", personCount, "amount", amount, "payState", payState, "cancelDt", cancelDt, "cancelStatus", cancelStatus ));
    return ResponseEntity.ok(ticketInf);
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> ticketRefund(HttpServletRequest request) {
    String resultMessage = "";
    // 현재 날짜와 시간 가져오기
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    String formattedDate = now.format(formatter);
    
    // 티켓영화 시간
    String startTime = request.getParameter("startTime");
    // 비교하기
    if (formattedDate.compareTo(startTime) > 0) {
      resultMessage = "현재시간이 상영시간 이후으로 확인 되었으며 \n 환불처리가 불가능합니다.";
        
    } else {
      //아직 환불기능이 미완성 완성시 연결하기.
      String movieNm = request.getParameter("movieNm");
      String seatCode = request.getParameter("seatCode");
      Map<String, Object> params = new HashMap<>();
      params.put("movieNm", movieNm);
      params.put("startTime", startTime);
      params.put("seatCode", seatCode);
      params.put("cancelStatus", "진행중");
      int result = userMapper.cancelRequest(params);
      if(result == 1) {
        resultMessage = "현재시간이 상영시간 이전으로 확인 되었으며 \n 환불처리 신청 되었습니다.";
      } else {
        resultMessage = "죄송합니다. 환불처리 신청에 실패 했습니다.\n  관리자에게 문의해 주세요.";
      }
    }
    
    return ResponseEntity.ok(Map.of("resultMessage", resultMessage));
  }
  

///블로그//////////////////
  
  @Override
  public ResponseEntity<Map<String, Object>> getUserBloglist(HttpServletRequest request) {
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null)  // 세션 만료 대비
      return null;
    int userNo = loginUser.getUserNo();
    int page = Integer.parseInt(request.getParameter("page"));//페이지를 받아왔네.
    int display = 5; //한 페이지에 표시할 게시물 수
    int total = userMapper.getBlogCount(userNo);//블로그 게시물 총수/ 맵퍼에 다녀와야해.
    System.out.println("total : " + total);
    System.out.println("display : " + display);
    System.out.println("page : " + page);
    pageUtils.setPaging(total, display, page);//페이징 정보를 설정
    
    String sortColumn = request.getParameter("sortColumn");

    System.out.println("비긴 : " + pageUtils.getBegin());
    System.out.println("엔드 : " + pageUtils.getEnd());
    Map<String, Object> params = new HashMap<>();//페이징 처리에 필요한 파라미터를 담은 Map을 생성
    params.put("userNo", userNo);
    params.put("begin", pageUtils.getBegin());
    params.put("end", pageUtils.getEnd());//시작과 끝을 담고 리스트 받으러 가
    params.put("sortColumn", sortColumn); 
   
    List<BlogDTO> blogList = userMapper.userGetBlogList(params); //블로그를 리스트형으로 받아오기.
    String paging = pageUtils.getAsyncPaging();//pageUtils를 사용하여 페이징 HTML 코드를 생성
    return ResponseEntity.ok(Map.of("blogList", blogList, "paging", paging)); //리스트랑 페이징 결과 담아서 보내.

  }
  
}

