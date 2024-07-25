<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../admin/adminheader.jsp">
  <jsp:param value="CINEMAGREEN ADMIN" name="title"/>
</jsp:include>
                <main>
                    <div class="container-fluid px-4">
                        <br>
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        주간 매출 추이
                                    </div>
                                    <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        최고 매출 영화
                                    </div>
                                    <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                        </div>
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