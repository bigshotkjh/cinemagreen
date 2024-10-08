<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="Change Password" name="title"/>
</jsp:include>
<style>

  h6{ font-size:  .85em;}
  .dead-btn{cursor: default; pointer-events: none;}
  .sections.section_pwchange .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
  .sections.section_pwchange .width_con .pwchange form{ position: relative; transform: translateX(42%); transition: inherit;}
  .title_con h6{ margin-top: 0;}
  input { border-radius: 4px;}
  #pwchange-form{  position: relative; transform: translate(580px, 0px); border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 216px; padding: 10px; border: 1px solid  #ABDEC2;}

</style>

<div class="wrap">
  <div class="sections section_pwchange">
    <div class="width_con">
      <div class="title_con white pwchange">
        <h4 class="title">비밀번호 변경</h4><br>
        <form id="pwchange-form"
              method="post"
              action="${contextPath}/user/pwchange.do">
          <input type="hidden" name="url" value="${url}">
          <div>
            <input type="password" name="oldpw" id="oldpw" placeholder="현재 비밀번호">
            <h6></h6>
          </div>
          <div>
          <input type="password" name="pw" id="pw" placeholder="새로운 비밀번호">
            <h6></h6>
          </div>
          <div>
            <input type="password" name="pw2" id="pw2" placeholder="비밀번호 확인">
            <h6></h6>
          </div><br>
          <div>
            <button type="submit" class="submit dead-btn" >변경하기</button>
            <button type="button" onclick="goUserInf()">취소하기</button>
          </div>
        </form>
      </div>
    </div>
  </div>

<script>

  var oldpasswordCheck = false,
      passwordCheck = false
  
  const fnOldCheck = ()=>{
    const oldpw = document.getElementById('oldpw');
    const oldpw_v = oldpw.value;
    if(oldpw_v == ""){ 
      $("#oldpw").next("h6").html('현재 비밀번호를 입력해주세요.');
      oldpasswordCheck = false;
    }else{
      $("#oldpw").next("h6").html('');
      oldpasswordCheck = true;
    }
   }
  
  $(document).on("keyup","#oldpw, #pw, #pw2",evt=>{
    fnOldCheck();
  })


  const fnPasswordCheck = ()=>{
    
    const pw = document.getElementById('pw');
    const pw_v = pw.value;
    const pw2 = document.getElementById('pw2');
    const pw2_v = pw2.value;
    var text_check = /^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{5,99}$/;
    
    if(pw_v == ""){ 
      $("#pw").next("h6").html('새로운 비밀번호를 입력해주세요.');
    }else if(text_check.test(pw_v) == true){
      $("#pw").next("h6").html('');
      if(pw2_v == ""){
        $("#pw2").next("h6").html('확인을 위해 비밀번호는 한번 더 입력해주세요.');
      }else{
        if(pw_v == pw2_v){
          $("#pw2").next("h6").html('비밀번호가 일치합니다.');
          passwordCheck = true;//
        }else{
          $("#pw2").next("h6").html('확인을 위해 비밀번호는 한번 더 입력해주세요.');
          passwordCheck = false;
        }    
      }                                 
    }else{
      $("#pw").next("h6").html('5자리 이상의 영문 대소문자, 최소 1개의 숫자 혹은 특수 문자를 포함하여야 합니다.');
      $("#pw2").next("h6").html('');
      passwordCheck = false;
    }
  }
  
  // 정규식에 맞게 입력했나 체크
  $(document).on("keyup","#pw, #pw2",evt=>{
    fnPasswordCheck();
  })

  // 모두 정상 입력했나 확인 하고 서브밋 버튼 활성화.
  $(document).on("keyup", "#oldpw, #pw, #pw2", evt=>{
    if(oldpasswordCheck == true && passwordCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  });
  
  //변경 취소시
  const goUserInf = ()=>{
    location.href = "${contextPath}/user/userpage.page";
  }
  
  //비밀번호변경 메세지
  if('${pwchangeMessage}' !== ''){
    alert('${pwchangeMessage}');
  }
  

  
  $(document).on("keypress", "#pwchange-form", evt=>{
    if (evt.which === 13) { // 13은 엔터 키 코드
        evt.preventDefault(); // 기본 동작 방지
    }
  });
</script>

<%@ include file="../layout/footer.jsp" %>