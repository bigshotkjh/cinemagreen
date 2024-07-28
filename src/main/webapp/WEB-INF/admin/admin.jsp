<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<link href="" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/1h6QZz5U+Y1S8M1U3VZ1+2YQ7Q4S4M0F1n6r3Z" crossorigin="anonymous"></script>
<script src="" integrity="sha384-1zPq8q4K1x1rV6g3I6J1W3FZ1uN1aP3W1bC4R7H1j1G5w5G5q5h5Z5g5b5Y5K5Y" crossorigin="anonymous"></script>
<script src="" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

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
          <div class="card-body">
            <canvas id="myAreaChart" width="100%" height="40"></canvas>
          </div>
        </div>
      </div>
      <div class="col-xl-6">
        <div class="card mb-4">
          <div class="card-header">
            <i class="fas fa-chart-bar me-1"></i>
            최고 매출 영화
          </div>
          <div class="card-body">
            <canvas id="myBarChart" width="100%" height="40"></canvas>
          </div>
        </div>
      </div>
    </div>
    <div class="card mb-4">
      <div class="card-header">
        <i class="fas fa-table me-1"></i>
        회원목록
      </div>
      <div class="card-body">
        <table id="datatablesSimple" class="table table-striped">
          <thead>
            <tr>
              <th>유저번호</th>
              <th>이메일</th>
              <th>이름</th>
              <th>전화번호</th>
              <th>가입일자</th>
              <th>상세</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th>유저번호</th>
              <th>이메일</th>
              <th>이름</th>
              <th>전화번호</th>
              <th>가입일자</th>
              <th>상세</th>
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
                <td>
                  <button class="btn btn-info detail-btn" 
                          data-userno="${user.userNo}">상세보기</button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</main>
<%@ include file="../admin/adminfooter.jsp" %>

<!-- 모달 -->
<div class="modal fade" id="userDetailModal" tabindex="-1" aria-labelledby="userDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="userDetailModalLabel">상세보기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="wrap">
          <div class="sections section_userpage">
            <div class="width_con">
              <div class="title_con white userpage">
                <form id="user-info-form" method="post" action="${contextPath}/user/updateInf.do">
                  <input type="hidden" id="modalUserNo" name="userNo" value="">
                  <div>
                    <h5>이메일</h5>
                    <input type="text" name="email" id="modalEmailInput" value="" disabled>
                  </div>
                  <div>
                    <h5>이름</h5>
                    <input type="text" name="name" id="modalName" value="">
                  </div>
                  <div>
                    <h5>전화번호</h5>
                    <input type="text" name="mobile" id="modalMobile" value="">
                  </div>
                  <div>
                    <h5>주소</h5>
                    <button type="button" onclick="execDaumPostcode()">우편번호 찾기</button><br>
                    <input type="text" id="postcode" name="postcode" value="">
                    <input type="text" id="address" name="address" value=""><br>
                    <input type="text" id="extraAddress" name="extraAddress" value=""><br>
                    <input type="text" id="detailAddress" name="detailAddress" value=""> 
                  </div>
                  <div>
                    <button type="submit" class="submit">개인정보 변경하기</button>
                  </div>
                </form>
                <div>
                  <button type="button" onclick="pwChange()">비밀번호변경</button>
                </div>
                <div>
                  <button type="button" onclick="adminLeaveUser()">삭제하기</button>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary" onclick="$('#user-info-form').submit();">저장</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- jQuery 및 AJAX 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 상세보기 버튼 클릭 시
    $('.detail-btn').click(function() {
        var userNo = $(this).data('userno'); // data-userno 속성 가져오기

        // AJAX 요청
        $.ajax({
            url: '/admin/getUserDetail/' + userNo, // 사용자 상세 정보를 가져올 API 경로
            method: 'GET',
            success: function(data) {
                // 모달에 사용자 정보 표시
                $('#modalEmailInput').val(data.email); // 이메일
                $('#modalName').val(data.name); // 이름
                $('#modalMobile').val(data.mobile); // 전화번호
                $('#modalUserNo').val(data.userNo); // 사용자 번호
                $('#userDetailModal').modal('show'); // 모달 표시
            },
            error: function() {
                alert('사용자 정보를 불러오는데 실패했습니다.'); // 에러 처리
            }
        });
    });

    // 모달 닫기 (Bootstrap의 기본 기능 사용)
    $('#userDetailModal').on('hide.bs.modal', function() {
        // 필요시 추가적인 로직을 여기에 작성
    });
});
</script>
