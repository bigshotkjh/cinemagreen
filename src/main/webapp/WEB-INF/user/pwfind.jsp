<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="PwFind" name="title"/>
</jsp:include>
<style>
  .dead-btn{cursor: default; pointer-events: none;}
  .sections.section_pwfind .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
  .sections.section_pwfind .width_con .pwfind form{ position: relative; transform: translateX(42%); transition: inherit;}
  .title_con h6{ margin-top: 0;}
  input { border-radius: 4px;}
</style>

<div class="wrap">
  <div class="sections section_pwfind">
    <div class="width_con">
      <div class="title_con white pwfind">
        <h4 class="title">비밀번호 찾기</h4><br>
        <form id="pwfind-form"
              method="post"
              action="${contextPath}/user/pwupdate.do">
          <div id="code-div" ></div>
          <input type="hidden" name="url" value="${url}">
          <div>
            <input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요">
            <button type="button" id="get-code-btn">인증코드 받기</button>
            <h6></h6>
            <input type="text" name="email-check" id="email-check" value="" placeholder="인증번호를 입력해 주세요">
            <button type="button" id="code-check-btn" >인증번호 확인</button>
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
            <button type="submit" class="submit dead-btn" >새로운 비밀번호 설정</button>
            <button type="button" onclick="history.back()">취소하기</button>
          </div>
        </form>
      </div>
    </div>
  </div>
 
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->



<script>

  var emailCodeCheck = false,
      passwordCheck = false
  
      
  //ajax 인증번호 가져오기
  const fnEmailCheck = ()=>{
    
    const email = document.getElementById('email');
    
    $.ajax({
      type: 'get',
      url: '/user/sendCode.do',
      data: 'email=' + email.value,
      dataType: 'json'
    }).done(resData=>{
      const code = document.getElementById('code-div');
      code.innerHTML = '<input type="text" id="code" value="' + resData.code + '">';
      console.log(resData);
    }).fail(jqXHR=>{
      console.log(jqXHR);
    })
    
  }
  
  document.getElementById('get-code-btn').addEventListener('click', evt=>{
    fnEmailCheck();
  })

//입력한 code 동일한가 검사  
  const fnCodeCheck = ()=>{
    const code = document.getElementById('code');
    const emailCheck = document.getElementById('email-check');
    if(code.value === emailCheck.value){
      alert('인증에 성공했습니다.');
      emailCodeCheck = true;
    }else{
      alert('인증번호가 틀렸습니다.');
    }
  }
   
  $(document).on("click","#code-check-btn",evt=>{
    fnCodeCheck();
  })
  
  
//password검사

  const fnPasswordCheck = ()=>{
    
    const pw = document.getElementById('pw');
    const pw_v = pw.value;
    const pw2 = document.getElementById('pw2');
    const pw2_v = pw2.value;
    var text_check = /^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{5,99}$/;
    
    if(pw_v == ""){ 
      $("#pw").next("h6").html('비밀번호를 입력해주세요.');
    }else if(text_check.test(pw_v) == true){
      $("#pw").next("h6").html('');
      if(pw2_v == ""){
        $("#pw2").next("h6").html('확인을 위해 비밀번호는 한번 더 입력해주세요.');
      }else{
        if(pw_v == pw2_v){
          $("#pw2").next("h6").html('비밀번호가 일치합니다.');
          passwordCheck = true;
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
  
  $(document).on("keyup","#pw, #pw2",evt=>{
    fnPasswordCheck();
  })
  
  
 //submit 버튼 활성화
  const allCheck = ()=>{
    if(passwordCheck == true && emailCodeCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  }
  
  $(document).on("keyup", "#pw, #pw2", evt=>{
    allCheck();
  });
  
  $(document).on("click", "#code-check-btn", evt=>{
    allCheck();
  });

  
  $(document).on("keypress", "#pwfind-form", evt=>{
    if (evt.which === 13) { // 13은 엔터 키 코드
        evt.preventDefault(); // 기본 동작 방지
    }
  });


</script>

<%@ include file="../layout/footer.jsp" %>