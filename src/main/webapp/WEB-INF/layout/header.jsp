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
  <c:when test="${empty param.title}">CINEMAGREEN STORE</c:when>
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
<link rel="stylesheet" href="${contextPath}/static/css/common.css">
<link rel="stylesheet" href="${contextPath}/static/css/header.css">
<link rel="stylesheet" href="${contextPath}/static/css/store.css">

</head>
  <body>
    <div class="wrap">
      <div class="nav_cover"></div>
      <div id="header" class="sections section_00">
        <div class="width_con">
            <a href="index.html" class="btn_home"><img src="img/logo.svg">멋진로고</a>
            <div class="btn_open_nav"><div></div></div>
            <ul class="nav" id="main-menu">
                <li><a href="${contextPath}/reserve/reserve.do">예매</a></li>
                <li><a href="#">영화</a></li>
                <li><a href="#">고객지원</a></li>
                <li><a href="#">마이페이지</a></li>
				<li><a href="${contextPath}/store/store.page">스토어</a>
					<ul id="sub-menu">
						<li><a href="${contextPath}/store/store.page">스토어</a></li>
						<li><a href="#">장바구니</a></li>
					</ul>
				</li>
				<li><a href="${contextPath}/admin/admin.page">관리자</a>
            </ul>
          <c:if test="${empty sessionScope.loginUser}">
            <ul class="nav_customer">
              <li><a href="${contextPath}/user/signin.page"><i class="fa-solid fa-arrow-right-from-bracket"></i>로그인</a></li>
              <li><a href="${contextPath}/user/signup.page"><i class="fa-solid fa-user-plus"></i>회원가입</a></li>
            </ul>
          </c:if>
          <c:if test="${not empty sessionScope.loginUser}">
            <ul class="nav_customer">
              <li><a href="마이페이지로가기">${sessionScope.loginUser.name}</a>님 반갑습니다</li>
              <li><a href="${contextPath}/user/signout.do">로그아웃</a></li>
            </ul>
          </c:if>
		</div>
      </div> 
    </div>
	<div class="main-wrap">