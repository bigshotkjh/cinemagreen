<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="Signup" name="title"/>
</jsp:include>
<!--@@@@@@@css시작@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
<style>
 .dead-btn{cursor: default; pointer-events: none;}
 .sections.section_signup .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
 .sections.section_signup .width_con .signup form{ position: relative; transform: translateX(42%); transition: inherit;}
 
</style>
<!--@@@@@@@끝  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->

<div class="wrap">
  <div class="sections section_signup">
    <div class="width_con">
      <div class="title_con white signup">
        <h4 class="title">Sign Up</h4><br>
        <form id="signup-form"
              method="post"
              action="${contextPath}/user/signup.do">
          <div id="code-div" ></div>
          <div>
            <input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요">
            <button type="button" id="get-code-btn">인증코드 받기</button>
            <h6></h6>
            <input type="text" name="email-check" id="email-check" value="">
            <button type="button" id="code-check-btn">인증번호 확인</button>
            <h6>인증번호를 입력해 주세요</h6>
          </div>
          <div>
            <input type="password" name="pw" id="pw" placeholder="비밀번호">
            <h6></h6>
            <div id=""></div>
          </div>
          <div>
            <input type="password" id="pw2" placeholder="비밀번호 확인">
            <h6></h6>
            <div id=""></div>
          </div>
          
          <div>
            <input type="text" name="name" id="name" placeholder="이름">
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
            <div id=""></div>
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
 
  var emailCodeCheck = false,
  	  passwordCheck = false,
  	  mobileCheck = false;
  
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

//email code검사  
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
/*
  document.getElementById('code-check-btn').addEventListener('click', evt=>{
    fnCodeCheck();
  })
*/  
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
 
  //submit 버튼 활성화
  const allCheck = ()=>{
    if(mobileCheck == true && passwordCheck == true && emailCodeCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  }
  
  $(document).on("keyup", "#pw, #mobile, #pw2", evt=>{
    allCheck();
  });
  
  $(document).on("click", "#code-check-btn", evt=>{
    allCheck();
  });
  
  /*
  
  $(document).on("keyup", "#pw, #mobile, #pw2", evt=>{
    if(mobileCheck == true && passwordCheck == true && emailCodeCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  });
  
  $(document).on("click", "#code-check-btn", evt=>{
    if(mobileCheck == true && passwordCheck == true && emailCodeCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  });
  */
  
  $(document).on("keypress", "#signup-form", evt=>{
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