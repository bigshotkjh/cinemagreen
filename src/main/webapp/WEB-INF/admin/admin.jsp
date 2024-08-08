<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<link href="" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/1h6QZz5U+Y1S8M1U3VZ1+2YQ7Q4S4M0F1n6r3Z" crossorigin="anonymous"></script>

<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../admin/adminheader.jsp">
  <jsp:param value="CINEMAGREEN ADMIN" name="title"/>
</jsp:include>

<style>
  
    .input-wide {
      width: 33%;
    }
    
</style>

<main>
  <div class="container-fluid px-4">
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
	              일일 최고 매출 영화
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
        회원 목록
      </div>
      <div class="card-body">
        <table id="datatablesSimple" class="table table-striped">
          <thead>
            <tr>
              <th>선택</th>
              <th>회원번호</th>
              <th>이메일</th>
              <th>이름</th>
              <th>전화번호</th>
              <th>가입일자</th>
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
				  <!-- 프로필 들어갈 자리 -->
				  
                  <div>
                    <h5>이메일</h5>
					          <input type="text" class="offset-1 input-wide" name="email" id="modalEmailInput" value="" disabled>
                  </div>
                  <div>
                    <h5>이름</h5>
					          <input type="text" class="offset-1 input-wide" name="name" id="modalName" value="" disabled>
                  </div>
				          <div>
      				      <h5>전화번호</h5>
      				      <input type="text" class="offset-1 input-wide"  name="mobile" id="modalMobile" value="">
      				    </div>
      			      <div>
      			        <h5>성별</h5>
      			        <input type="text" class="offset-1 input-wide"  name="gender" id="modalGender" value="">
      			      </div>
      				    <div>
      			        <h5>생년월일</h5>
      				      <input type="text" class="offset-1 input-wide"  name="birthyear" id="modalBirthyear" value="">
      				    </div>
      		        <div>
      				      <h5>가입일자</h5>
      			       	<input type="text" class="offset-1 input-wide"  name="signup_dt" id="modalSignupDt" value="" disabled>
      				    </div>
      			  	  <br>
                  <div>
                    <h5>주소<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"></h5>
				          	<input type="text" class="offset-1 input-wide" name="postcode" id="modalPostcode" value=""><br>
					          <input type="text" class="offset-1 input-wide" name="address" id="modalAddress" value=""><br>
                    <input type="text" class="offset-1 input-wide" name="extraAddress" id="modalExtraAddress" value=""><br>
                    <input type="text" class="offset-1 input-wide" name="detailAddress"id="modalDetailAddress" value="">
                  </div>
                  <div>
                    <button type="button" onclick="adminUpdateUser()">개인정보 변경하기</button>
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


<script>
	$(document).ready(function() { // 있어야 함.
	/*const displayUser = () => {*/
		
	  // 상세보기 버튼 클릭 시
	  $('.detail-btn').click(function() {
	    var userNo = $(this).data('userno'); // data-userno 속성 가져오기

	    // AJAX 요청
	    $.ajax({
	      url: '/admin/getUserDetail/' + userNo,
	      method: 'GET',
	      success: function(data) {
	        $('#modalEmailInput').val(data.email);
	        $('#modalName').val(data.name);
	        $('#modalMobile').val(data.mobile);
	        $('#modalUserNo').val(data.userNo);
	        $('#modalGender').val(data.gender);
	        $('#modalBirthyear').val(data.birthyear);
	        $('#modalSignupDt').val(data.signupDt);
	        $('#modalPostcode').val(data.postcode);
	        $('#modalAddress').val(data.address);
	        $('#modalExtraAddress').val(data.extraAddress); // 사용자 추가 주소
	        $('#modalDetailAddress').val(data.detailAddress); // 사용자 상세 주소
	        $('#userDetailModal').modal('show'); // 모달 표시
	      },
	      error: function() {
	        alert('사용자 정보를 불러오는데 실패했습니다.');
	      }
	    });
	  });

	  // 모달 닫기 이벤트
	  $('#userDetailModal').on('hide.bs.modal', function() {
	    // 입력값 초기화 등의 추가 로직
	  });
	});
	
	
	const adminDeleteUser = () => {
	  if (confirm("정말 회원 삭제를 하시겠습니까?")) {
	    var userNo = $('#modalUserNo').val();
	    $.ajax({
	      url: "${contextPath}/admin/adminDeleteUser.do",
	      method: 'POST',
	      data: { userNo: userNo },
	      success: function(response) {
	        alert('회원 삭제가 완료되었습니다.');
	        location.reload();
	      },
	      error: function() {
	        alert('회원 삭제에 실패했습니다.');
	      }
	    });
	  }
	}

	
	const adminUpdateUser = () => {
		
	  if (confirm("정말 회원 정보를 수정하시겠습니까?")) {
		
	    const userNo = $('#modalUserNo').val();
	    const email = $('#modalEmail').val();
	    const name = $('#modalName').val();
	    const mobile = $('#modalMobile').val();
	    const gender = $('#modalGender').val();
	    const birthyear = $('#modalBirthyear').val(); // 변수명 통일
	    const signup_dt = $('#modalSignupDt').val();
	    const postcode = $('#modalPostcode').val();
	    const address = $('#modalAddress').val();
	    const extra_address = $('#modalExtraAddress').val();
	    const detail_address = $('#modalDetailAddress').val();
	    
		console.log(		JSON.stringify({ 
			        userNo: userNo,
			        name: name,
			        mobile: mobile,
			        gender: gender,
			        birthyear: birthyear,
			        signupDt: signup_dt,
			        postcode: postcode,
			        address: address,
			        extraAddress: extra_address,
			        detailAddress: detail_address
			      }));
		
	    $.ajax({
	      url: "${contextPath}/admin/adminUpdateUser.do",
	      method: 'POST',
		  contentType: 'application/json',
	      data: JSON.stringify({ 
	        userNo: userNo,
	        name: name,
	        mobile: mobile,
	        gender: gender,
	        birthyear: birthyear,
	        signupDt: signup_dt,
	        postcode: postcode,
	        address: address,
	        extraAddress: extra_address,
	        detailAddress: detail_address
	      }),
	      success: function(response) {
			if(response.isSuccess) {				
		        alert('회원 정보 수정이 완료되었습니다.');
				location.reload();
			} else {
		        alert('회원 정보 수정이 실패했습니다.');
			}
	      },
	      error: function(xhr, status, error) {
	        console.error("Error details: ", xhr.responseText);
	        alert('회원 정보 수정에 실패했습니다. 다시 시도해주세요.');
	      }
	    });
	  }
	}
	

	const adminPwChange = () => {
	  if (confirm("비밀번호를 변경하시겠습니까?")) {
	    var userNo = $('#modalUserNo').val();
	    var newPassword = prompt("새 비밀번호를 입력하세요:");
	    if (newPassword) {
	      $.ajax({
	        url: "${contextPath}/admin/adminPwupdate.do",
	        method: 'POST',
	        data: { userNo: userNo, newPassword: newPassword },
	        success: function(response) {
	          alert('변경 완료되었습니다.');
	          location.reload();
	        },
	        error: function() {
	          alert('변경 실패했습니다.');
	        }
	      });
	    }
	  }
	}
	

</script>