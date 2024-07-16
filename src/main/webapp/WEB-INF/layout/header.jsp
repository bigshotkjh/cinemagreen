<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>
<c:choose>
  <c:when test="${empty param.title}">홈</c:when>
  <c:otherwise>${param.title}</c:otherwise>
</c:choose>
</title>

<script src="${contextPath}/static/lib/jquery-3.7.1.min.js"></script>
<script src="${contextPath}/static/jquery-ui-1.13.3.custom/jquery-ui.min.js"></script>
<script src="${contextPath}/static/bootstrap-5.3.3-dist/js/bootstrap.min.js"></script>
<script src="${contextPath}/static/summernote-0.8.18-dist/summernote-lite.min.js"></script>
<script src="${contextPath}/static/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link rel="stylesheet" href="${contextPath}/static/jquery-ui-1.13.3.custom/jquery-ui.min.css">
<link rel="stylesheet" href="${contextPath}/static/bootstrap-5.3.3-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${contextPath}/static/summernote-0.8.18-dist/summernote-lite.min.css">
<link rel="stylesheet" href="${contextPath}/static/css/init.css">
<link rel="stylesheet" href="${contextPath}/static/css/header.css">

</head>
<body>
  
  <div class="header-wrap">
    
    <div class="logo"></div>
    
    <div class="user-wrap">
    
      <%-- Signin 안 한 상태 --%>
      <c:if test="${empty sessionScope.loginUser}">
        <div>
          <a href="${contextPath}/user/signin.page"><i class="fa-solid fa-arrow-right-from-bracket"></i>Signin</a>
          <a href="${contextPath}/user/signup.page"><i class="fa-solid fa-user-plus"></i>Signup</a>
        </div>
      </c:if>
      
      <%-- Signin 한 상태 --%>
      <c:if test="${not empty sessionScope.loginUser}">
        <div><a href="마이페이지로가기">${sessionScope.loginUser.name}</a>님 반갑습니다</div>
        <div><a href="${contextPath}/user/signout.do">로그아웃</a></div>
        <div><a href="${contextPath}/user/leave.do">회원탈퇴(마이페이지로이동해야함)</a></div>
      </c:if>
    
    </div>
    
    <div class="gnb-wrap">
      <ul>
        <li><a href="${contextPath}/bbs/list.do">BBS_계층게시판</a></li>
        <li><a href="${contextPath}/blog/list.do">BLOG_댓글게시판</a></li>
      </ul>
    </div>
    
  </div>
  
  <hr>
  
  <div class="main-wrap">