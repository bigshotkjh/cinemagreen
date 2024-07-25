<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.min.cinemagreen.dto.UserDTO" %>

<jsp:include page="../admin/adminheader.jsp">
  <jsp:param value="CINEMAGREEN ADMIN" name="title"/>
</jsp:include>
<style>
 .admin-dead-btn{cursor: default; pointer-events: none;}
 .sections.section_signup .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
 .sections.section_signup .width_con .signup form{ position: relative; transform: translateX(42%); transition: inherit;}
 
</style>


<div class="wrap">
  <div class="sections section_userpage">
    <div class="width_con">
      <div class="title_con white userpage">
        <h4 class="title">User Page</h4><br>
        <form id="user-info-form"
              method="post"
              action="${contextPath}/user/updateInf.do">
          <div>
            <h5>이메일</h5>
            <input type="text" name="email" id="email" value="${user.email}" disabled>
            <h6></h6>
          </div>
          <div>
            <h5>이름</h5>
            <input type="text" name="name" id="name" value="${user.name}">
          </div>
          <br>
          <div>
            <h5>전화번호</h5>
            <input type="text" name="mobile" id="mobile" value="${user.mobile}">
            <h6></h6>
          </div>
          
          <div>
            <h5>주소</h5>
            <input type="button" onclick="execDaumPostcode(), fnMobileCheck(), fnAllCheck()" value="우편번호 찾기"><br>
            <input type="text" id="postcode" name="postcode" value="${user.postcode}"><br>
            <input type="text" id="address" name="address" value="${user.address}"><br>
            <input type="text" id="extraAddress" name="extraAddress" value="${user.extraAddress}"><br>
            <input type="text" id="detailAddress" name="detailAddress" value="${user.detailAddress}"> 
          </div>
          <br>
       
          <div>
            <button type="submit"  class="submit" >개인정보 변경하기</button>
          </div>
              
        </form><br>
       
          <div>
            <button type="button" onclick="pwChange()">비밀번호변경</button>
          </div><br>
       
		  <div>
		      <button type="button" onclick="adminLeaveUser(${user.userNo})">삭제하기</button>
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
  
  $(document).on("keyup","#mobile, #name, #postcode, #address, #detailAddress, #extraAddress", evt=>{
    fnMobileCheck();
  })

  
  $(document).on("keyup", "#mobile, #name, #postcode, #address, #detailAddress, #extraAddress", evt=>{
    fnAllCheck();
  });
</script>


<script>
  
//탈퇴
const adminLeaveUser = (userNo) => {
  // 회원 탈퇴 확인 메시지 표시
  if (confirm("정말 회원 삭제를 하시겠습니까?")) {
      // 회원 탈퇴 처리 URL로 이동, userNo를 쿼리 파라미터로 추가
      location.href = "${contextPath}/admin/adminDeleteUser.do?userNo=" + userNo;
  }
};


  
  const pwChange = () => {
    
    location.href = "${contextPath}/admin/adminUpdateInf.do?userNo=" + userNo;
    
  };
  
//비밀번호변경 메세지
  if('${pwchangeMessage}' !== ''){
    alert('${pwchangeMessage}');
  }
   
</script>
  
<script>
//업데이트 결과 메세지.
  if('${updateMessage}' !== ''){   
    alert('${updateMessage}');
  }
</script>

<%@ include file="../admin/adminfooter.jsp" %>