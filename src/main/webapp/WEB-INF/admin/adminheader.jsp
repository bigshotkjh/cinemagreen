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
		<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
		
		<link rel="stylesheet" href="${contextPath}/static/jquery-ui-1.13.3.custom/jquery-ui.min.css">
		<link rel="stylesheet" href="${contextPath}/static/bootstrap-5.3.3-dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="${contextPath}/static/summernote-0.8.18-dist/summernote-lite.min.css">
		<link rel="stylesheet" href="${contextPath}/static/css/init.css">
		<link rel="stylesheet" href="${contextPath}/static/css/header.css">
		<link rel="stylesheet" href="${contextPath}/static/css/store.css">
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
		<br>
		<br>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="${contextPath}/admin/admin.page">CINEMAGREEN Admin</a>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			  <li><a class="navbar-brand ps-3" href="${contextPath}/main.do">MAIN PAGE</a></li>
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
         
        <div id="layoutSidenav_content">
