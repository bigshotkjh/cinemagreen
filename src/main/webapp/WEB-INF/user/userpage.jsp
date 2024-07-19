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
<!-- 지금 진행중인것
    회원정보 표시 했고 .
  1. 이제 수정보내고 받아오기는  ajax
  2. 이메일과 비번 번경에 대해.  

  -->
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
          
         <a href="${contextPath}/user/leave.do">회원탈퇴</a>
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
            <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="postcode" name="postcode" value="${loginUser.postcode}"><br>
            <input type="text" id="address" name="address" value="${loginUser.address}"><br>
            <input type="text" id="extraAddress" name="extraAddress" value="${loginUser.extraAddress}"><br>
            <input type="text" id="detailAddress" name="detailAddress" value="${loginUser.detailAddress}"> 
          </div>
          <br>
       
          <div>
            <button type="button" id="submitbtn" class="submit dead-btn" >개인정보 변경하기</button>
          </div>
              
        </form>
    </div>
  </div>
              
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->


<script>

  var 
  	  mobileCheck = false;
  
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
  
  //submit 버튼 컨트롤
  /*아직 이메일체크 빠져 있음.*/
  $(document).on("keyup", "#mobile", evt=>{
    if(mobileCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  });
</script>

<script>
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
   
</script>
  
<script>

  // 변경 성공 알리기.
  if('${updateMessage}' !== ''){   /* 수정필요. */
    alert('${updateMessage}');
  }
</script>

<%@ include file="../layout/footer.jsp" %>