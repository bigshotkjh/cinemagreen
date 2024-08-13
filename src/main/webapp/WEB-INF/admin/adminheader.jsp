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
      <title>CINEMAGREEN Dashboard</title>
  		<script src="${contextPath}/static/lib/jquery-3.7.1.min.js"></script>
  		<script src="${contextPath}/static/jquery-ui-1.13.3.custom/jquery-ui.min.js"></script>
  		<script src="${contextPath}/static/bootstrap-5.3.3-dist/js/bootstrap.min.js"></script>
  		<script src="${contextPath}/static/summernote-0.8.18-dist/summernote-lite.min.js"></script>
  		<script src="${contextPath}/static/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
  		<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  		<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
      
  		<link rel="stylesheet" href="${contextPath}/static/jquery-ui-1.13.3.custom/jquery-ui.min.css">
  		<link rel="stylesheet" href="${contextPath}/static/bootstrap-5.3.3-dist/css/bootstrap.min.css">
  		<link rel="stylesheet" href="${contextPath}/static/summernote-0.8.18-dist/summernote-lite.min.css">
  		<link rel="stylesheet" href="${contextPath}/static/css/init.css?dt=<%=System.currentTimeMillis()%>">
  		<link rel="stylesheet" href="${contextPath}/static/css/header.css?dt=<%=System.currentTimeMillis()%>">
  		<link rel="stylesheet" href="${contextPath}/static/css/store.css?dt=<%=System.currentTimeMillis()%>">
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/admin.css?dt=<%=System.currentTimeMillis()%>" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
        <script src="../lib/datatables-simple-demo.js"></script>
          
          

          
  </head>
		<br>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
          <!-- Navbar Brand-->
          <a class="navbar-brand ps-3" href="${contextPath}/admin/admin.page">CINEMAGREEN Admin</a>
          <!-- 다른 페이지 살펴보기 -->
          <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
          <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
          </form>
          <!-- Navbar-->
		  <li><a class="navbar-brand ps-3" href="http://localhost:9090">MAIN PAGE</a></li>
          <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item" href="${contextPath}/admin/insertuser.page">회원추가</a></li>
                <li><hr class="dropdown-divider" /></li>
                <li><a class="dropdown-item" href="${contextPath}/user/signout.do">로그아웃</a></li> 
              </ul>
            </li>
          </ul>
        </nav>
        <div id="layoutSidenav">
          <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
              <div class="sb-sidenav-menu">
                <div class="nav">
                  <div class="sb-sidenav-menu-heading">Addons</div>
                  <a class="nav-link"  href="${contextPath}/admin/movie.page">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    영화 관리
                  </a>
                  <a class="nav-link" href="${contextPath}/admin/seat.page">
                    <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                    좌석 관리
                  </a>
                  <a class="nav-link"  href="${contextPath}/admin/qna.page">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    문의 내역
                  </a>
                </div>
              </div>
              <div class="sb-sidenav-footer">
                  <div class="small">Copyright &copy;</div>
                  CINEMAGREEN 2024
              </div>
            </nav>
          </div>
        <div id="layoutSidenav_content">
