<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<link href="" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/1h6QZz5U+Y1S8M1U3VZ1+2YQ7Q4S4M0F1n6r3Z" crossorigin="anonymous"></script>

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
            주간 최고 매출 영화
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
        상영중인 영화 목록
      </div>
      <div class="card-body">
        <table id="datatablesSimple" class="table table-striped">
          <thead>
            <tr>
              <th>선택</th>
              <th>영화번호</th>
              <th>제목</th>
              <th>상영등급</th>
              <th>감독</th>
              <th>개봉일자</th>
              <th>상세</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="user" items="${userList}">
              <tr>
                <td>
                  <input type="checkbox" class="user-checkbox" data-userno="${user.userNo}">
                </td>
                <td>${user.userNo}</td>
                <td>${user.email}</td>
                <td>${user.name}</td>
                <td>${user.mobile}</td>
                <td>${user.signupDt}</td>
                <td>
                  <button class="btn btn-success detail-btn" data-userno="${user.userNo}">
                    상세보기
                  </button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
	
	
	
	
  </div>
</main>




























<script>
  // 전체 선택 체크박스 기능
  document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('selectAll').addEventListener('change', function() {
      const checkboxes = document.querySelectorAll('.user-checkbox');
      checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
      });
    });
  });
</script>

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
					<input type="text" class="offset-1" name="email" id="modalEmailInput" value="">
                  </div>
                  <div>
                    <h5>이름</h5>
					<input type="text" class="offset-1" name="name" id="modalName" value="">
                  </div>
                  <div>
                    <h5>전화번호</h5>
					<input type="text" class="offset-1"  name="mobile" id="modalMobile" value="">
                  </div>
				  <br>
                  <div>
                    <h5>주소<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"></h5>
					<input type="text" class="offset-1" name="postcode" id="modalPostcode" value=""><br>
					<input type="text" class="offset-1" name="address" id="modalAddress" value=""><br>
                    <input type="text" class="offset-1" name="extraAddress" id="modalExtraAddress" value=""><br>
                    <input type="text" class="offset-1" name="detailAddress"id="modalDetailAddress" value="">
                  </div>
                  <div>
                    <button type="submit" class="submit">개인정보 변경하기</button>
                  </div>
				  <div>
				    <button type="button" onclick="adminDeleteUser()">삭제하기</button>
				  </div>
                </form>
              </div>
            </div>
          </div>
		  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		  <script>
		    //카카오 주소 API
		    function execDaumPostcode() {
		      new daum.Postcode({
		        oncomplete: function(data) {
		          var addr = ''; 
		          var extraAddr = ''; 
		          if (data.userSelectedType === 'R') {
		            addr = data.roadAddress;
		          } else { 
		            addr = data.jibunAddress;
		          }
		          if(data.userSelectedType === 'R'){
		            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		              extraAddr += data.bname;
		            }
		            if(data.buildingName !== '' && data.apartment === 'Y'){
		              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		            }
		            if(extraAddr !== ''){
		              extraAddr = ' (' + extraAddr + ')';
		            }
                    document.getElementById("modalExtraAddress").value = extraAddr;
		          } else {
		            document.getElementById("extraAddress").value = '';
		          }
				  document.getElementById('modalPostcode').value = data.zonecode;
				  document.getElementById('modalAddress').value = addr;
				  document.getElementById('modalDetailAddress').focus();
		        }
		      }).open();
		    }
		  </script>

          <div class="modal-footer">
            <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
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
          $('#modalPostcode').val(data.postcode); // 사용자 우편번호
          $('#modalAddress').val(data.address); // 사용자 주소
          $('#modalExtraAddress').val(data.extraAddress); // 사용자 주소
          $('#modalDetailAddress').val(data.detailAddress); // 사용자 주소
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

  const adminDeleteUser = () => {
    if (confirm("정말 회원 삭제를 하시겠습니까?")) {
      var userNo = $('#modalUserNo').val(); // 삭제할 사용자 번호 가져오기
      $.ajax({
        url: "${contextPath}/admin/adminDeleteUser.do", // 변경된 URL
        method: 'POST', // POST 메서드로 변경
        data: { userNo: userNo }, // 사용자 번호 전송
        success: function(response) {
          alert('회원 삭제가 완료되었습니다.');
          location.reload(); // 페이지 새로고침 또는 다른 처리
        },
        error: function() {
          alert('회원 삭제에 실패했습니다.');
        }
      });
    }
  };

  const adminPwChange = () => {
    if (confirm("비밀번호를 변경 하시겠습니까?")) {
      var userNo = $('#modalUserNo').val(); // 변경할 사용자 번호 가져오기
      var newPassword = prompt("새 비밀번호를 입력하세요:"); // 비밀번호 입력 받기
      if (newPassword) {
        $.ajax({
          url: "${contextPath}/admin/adminPwupdate.do", // 변경된 URL
          method: 'POST', // POST 메서드로 변경
          data: { userNo: userNo, newPassword: newPassword }, // 사용자 번호와 비밀번호 전송
          success: function(response) {
            alert('변경 완료되었습니다.');
            location.reload(); // 페이지 새로고침 또는 다른 처리
          },
          error: function() {
            alert('변경 실패했습니다.');
          }
        });
      }
    }
  };
  </script>
</script>


