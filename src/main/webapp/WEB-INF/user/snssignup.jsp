<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="SNSSignup" name="title"/>
</jsp:include>
<!--@@@@@@@css시작@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
<style>
 .dead-btn{cursor: default; pointer-events: none;}
 .sections.section_snssignup .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
 .sections.section_snssignup .width_con .snssignup form{ position: relative; transform: translateX(42%); transition: inherit;}
 .title_con h6{ margin-top: 0;}
  input { border-radius: 4px; margin-top: 2px;}
 .red{ border: 2px solid red;}
</style>
<!--@@@@@@@끝  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->

<div class="wrap">
  <div class="sections section_snssignup">
    <div class="width_con">
      <div class="title_con white snssignup">
        <h4 class="title">Sign Up</h4><br>
        <form id="snssignup-form"
              method="post"
              action="${contextPath}/user/snssignup.do">
          <div id="code-div" ></div>
          <div><h5><B>휴대전화, 생년월일 입력은 필수 입니다</B></h5></div>
          <div>
            <input type="text" name="sns" id="sns" hidden="" value="${snsUser.sns}">
            <input type="text" name="email" id="email" hidden="" value = "${snsUser.email}" >
            <input type="text" value = "${snsUser.email}" disabled>
            <h6></h6>
          </div>
          <div>
            <input type="text" name="name" id="name" value = "${snsUser.name}" placeholder="이름">
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
            <input type="text" name="mobile" id="mobile" value="${snsUser.mobile}" placeholder="휴대전화">
            <h6></h6>
          </div>
          <div>
            <input type="text" name="birthYear" id="birth_year" value = "${snsUser.birthYear}" placeholder="생년월일 8자리">
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
            <button type="submit" id="submit" class="submit dead-btn">가입하기</button>
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
 
  var mobileCheck = false,
      birthCheck = false;
  
//mobile검사
  const fnMobileCheck = ()=>{
    
    const mobile = document.getElementById('mobile');
    var regMobile = /^010(-{0,1}[0-9]{4}){2}$/;
    if(regMobile.test(mobile.value)){
      $("#mobile").next("h6").html('핸드폰번호 확인되었습니다.' );
      mobileCheck = true;
    } else {
      $("#mobile").next("h6").html('010을 포함한 11자리 숫자로 입력해 주세요' );
      mobileCheck = false;
    }
  }
  
  $(document).on("keyup","#mobile", evt=>{
    fnMobileCheck();
  })
  
//생년월일 입력 검사
  
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
  
  
  window.onload = ()=>{
    fnMobileCheck();
    fnBirthCheck();
  }  
//submit 버튼 활성화
  const allCheck = ()=>{
    if(mobileCheck == true && birthCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
    if(mobileCheck == false){
      $("#mobile").addClass("red");
    } else {
      $("#mobile").removeClass("red");
    }
    if(birthCheck == false){
      $("#birth_year").addClass("red");
    } else {
      $("#birth_year").removeClass("red");
    }
  }
  
  
  window.onload = ()=>{
    fnMobileCheck();
    fnBirthCheck();
    allCheck();
  }  
  
  $(document).on("keyup", evt=>{
    allCheck();
  });
  
  $(document).on("click", evt=>{
    allCheck();
  });
  
  $(document).on("keypress", "#snssignup-form", evt=>{
    if (evt.which === 13) { // 13은 엔터 키 코드
        evt.preventDefault(); // 기본 동작 방지
    }
  });
  

</script>

<script>
  // 가입성공 알림.
  if('${signupMessage}' !== ''){
    alert('${signupMessage}');
  }

</script>

<%@ include file="../layout/footer.jsp" %>