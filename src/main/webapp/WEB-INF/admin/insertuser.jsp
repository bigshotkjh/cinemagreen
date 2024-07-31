<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.min.cinemagreen.dto.UserDTO" %>

<jsp:include page="../admin/adminheader.jsp">
  <jsp:param value="CINEMAGREEN ADMIN" name="title"/>
</jsp:include>


<div class="wrap">
  <div class="sections section_signup">
    <div class="width_con">
      <div class="title_con white signup">
		<br>
        <h4 class="title">INSERT USER</h4><br>
        <form id="signup-form"
              method="post"
              action="${contextPath}/user/signup.do">
          <div id="code-div" ></div>
          <div>
            <input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요">
            <h6></h6>
            <h6></h6>
          </div>
          <div>
            <input type="password" name="pw" id="pw" placeholder="비밀번호">
            <h6></h6>
          </div>
          <div>
            <input type="password" id="pw2" placeholder="비밀번호 확인">
            <h6></h6>
          </div>
		  <div>
		    <input type="text" name="name" id="name" placeholder="이름">
		  </div>
		  <div>
		    <input type="text" name="birthYear" id="birth_year" placeholder="생년월일 8자리">
		  </div>
		  
          <br>
          <div>
            <input type="radio" name="gender" value="none" id="none" checked>
            <label for="none">선택안함</label>
            <input type="radio" name="gender" value="man" id="man">
            <label for="man">남자</label>
            <input type="radio" name="gender" value="woman" id="woman">
            <label for="woman">여자</label>
          </div>
          <br>
          <div>
            <input type="text" name="mobile" id="mobile" placeholder="휴대전화">
            <h6></h6>
          </div>
          <div>
            <input type="text" id="postcode" name="postcode" placeholder="우편번호">
            <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="address" name="address" placeholder="주소"><br>
            <input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목"><br>
            <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"> 
          </div>
          <br>
        
          <div>
            <button type="submit" id="submit" class="submit dead-btn">추가하기</button>
            <button type="button" onclick="history.back()">취소하기</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  
  

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

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
                  document.getElementById("extraAddress").value = extraAddr;
              } else {
                  document.getElementById("extraAddress").value = '';
              }
              document.getElementById('postcode').value = data.zonecode;
              document.getElementById("address").value = addr;
              document.getElementById("detailAddress").focus();
          }
      }).open();
  }
</script>

<script>
  

  
  const fnBirthCheck = ()=>{
    
    const birthYear = document.getElementById('birth_year');
    var regbirthYear = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
    if(regbirthYear.test(birthYear.value)){
      $("#birth_year").next("h6").html('생년월일 확인되었습니다.' );
      birthCheck = true;
    } else {
      $("#birth_year").next("h6").html('생년월일 8자리를 입력해 주세요 ex)20000101');
      birthCheck = false;
    }
  }

  $(document).on("keyup","#birth_year", evt=>{
    fnBirthCheck();
  })

</script>

<script>
  // 가입성공 알림.
  if('${signupMessage}' !== ''){
    alert('${signupMessage}');
  }

</script>



<%@ include file="../admin/adminfooter.jsp" %>