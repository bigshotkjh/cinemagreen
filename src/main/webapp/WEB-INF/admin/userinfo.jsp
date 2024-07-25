<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.min.cinemagreen.dto.UserDTO" %>

<jsp:include page="../admin/adminheader.jsp">
  <jsp:param value="CINEMAGREEN ADMIN" name="title"/>
</jsp:include>

<c:if test="${empty userList}">
    <p>사용자 목록이 없습니다.</p>
</c:if>

<div id="user-list"></div>
<main>
    <div class="container-fluid px-4">
        <h1 class="mt-4">회원관리</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="${contextPath}/admin/admin.page">대시보드</a></li>
            <li class="breadcrumb-item active">회원관리</li>
        </ol>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table me-1"></i>
                회원목록
            </div>
            <div class="card-body">
                <table id="datatablesSimple">
                    <thead>
                        <tr>
                            <th>유저번호</th>
                            <th>이메일</th>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>가입일자</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>user_no</th>
                            <th>email</th>
                            <th>name</th>
                            <th>mobile</th>
                            <th>signup_dt</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.userNo}</td>
                                <td>${user.email}</td>
                                <td>${user.name}</td>
                                <td>${user.mobile}</td>
                                <td>${user.signupDt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
<%@ include file="../admin/adminfooter.jsp" %>