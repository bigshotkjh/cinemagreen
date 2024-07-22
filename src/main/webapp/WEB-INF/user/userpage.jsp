<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="userpage" name="title"/>
</jsp:include>
<style>
 .dead-btn{cursor: default; pointer-events: none;}
 .sections.section_signup .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
 .sections.section_signup .width_con .signup form{ position: relative; transform: translateX(42%); transition: inherit;}
 
</style>
<!--
 가져와 표시할 것 들
    {
      등급표시
      포인트량
      내가 쓴 블로그
      내가 쓴 bbs
      내정보표시와 수정(가장 먼저)
      예매한 영화 정보
    }
 -->

<!-- @@@@@@@@@@@@@@@@@@@@@@@ -->


<div class="wrap">
  <div class="sections section_userpage">
    <div class="width_con">
      <div class="title_con white userpage">
        <h4 class="title">User Page</h4><br>
        <form id="user-info-form">
          <div>
            <h5>이메일</h5>
            <input type="text" name="email" id="email" value="${loginUser.email}" disabled>
            <h6></h6>
          </div>
          <div>
            <h5>이름</h5>
            <input type="text" name="name" id="name" value="${loginUser.name}">
          </div>
          <br>
          <div>
            <h5>휴대폰번호</h5>
            <input type="text" name="mobile" id="mobile" value="${loginUser.mobile}">
            <h6></h6>
          </div>
          
          <div>
            <h5>주소</h5>
            <input type="button" onclick="execDaumPostcode(), fnMobileCheck(), fnAllCheck()" value="우편번호 찾기"><br>
            <input type="text" id="postcode" name="postcode" value="${loginUser.postcode}"><br>
            <input type="text" id="address" name="address" value="${loginUser.address}"><br>
            <input type="text" id="extraAddress" name="extraAddress" value="${loginUser.extraAddress}"><br>
            <input type="text" id="detailAddress" name="detailAddress" value="${loginUser.detailAddress}"> 
          </div>
          <br>
       
          <div>
            <button type="button" id="submitbtn" class="submit dead-btn" >개인정보 변경하기</button>
          </div>
              
        </form><br>
       
          <div>
            <button type="button" onclick="pwChange()">비밀번호변경</button>
          </div><br>
       
          <div>
            <button type="button" onclick="leaveUser()">탈퇴하기</button>
          </div>
        
    </div>
  </div>
              
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
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

  var 
  	  mobileCheck = false;
  
//mobile검사
  const fnMobileCheck = ()=>{
    
    const mobile = document.getElementById('mobile');
    var regMobile = /^010(-{0,1}[0-9]{4}){2}$/;
    if(regMobile.test(mobile.value)){
      $("#mobile").next("h6").html('' );
      mobileCheck = true;
    } else {
      $("#mobile").next("h6").html('010을 포함한 11자리 숫자로 입력해 주세요' );
      mobileCheck = false;
    }
  }
  
  $(document).on("keyup","#mobile, #name", evt=>{
    fnMobileCheck();
  })
  
  const fnAllCheck = ()=>{
    if(mobileCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  }
  
  $(document).on("keyup", "#mobile, #name", evt=>{
    fnAllCheck();
  });
</script>


<script>
//ajax
  const fnUpdateInf = () => {
    $.ajax({
      type: 'post',
      url: '${contextPath}/user/updateInf.do',
      data: $('#user-info-form').serialize(),
      dataType: 'json'
    }).done(resData => {
      if (resData.isSuccess) {
        alert('정보 변경 성공');
      } else {
        alert('정보 등록 실패');
      }
    }).fail(jqXHR => {
      alert(jqXHR.status);
    });
  }
  
  
  $('#submitbtn').on('click', evt=>{
    fnUpdateInf();
  })
  
//탈퇴
  const leaveUser = () => {
    // 회원 탈퇴 확인 메시지 표시
    if (confirm("정말 회원 탈퇴를 하시겠습니까?")) {
      // 회원 탈퇴 처리 URL로 이동
      window.location.href = "${contextPath}/user/leave.do";
    }
  };
  
  const pwChange = () => {
    
    window.location.href = "${contextPath}/user/pwchange.page";
    
  };
  
//비밀번호변경 메세지
  if('${pwchangeMessage}' !== ''){
    alert('${pwchangeMessage}');
  }
   
</script>
  
<script>

  if('${updateMessage}' !== ''){   
    alert('${updateMessage}');
  }
</script>

<%@ include file="../layout/footer.jsp" %>