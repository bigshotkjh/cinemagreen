<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="userpage" name="title"/>
</jsp:include>
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
        <a href="${contextPath}/user/leave.do">회원탈퇴</a>




<div class="wrap">
  <div class="sections section_userpage">
    <div class="width_con">
      <div class="title_con white userpage">
        <h4 class="title">User Page</h4><br>
        <form id="signup-form"
              method="post"
              action="${contextPath}/user/userUpdate.do">
        
          <div>
            <h5>이메일</h5>
            <input type="text" name="email" id="email" value="${loginUser.email}" disabled>
            <h6></h6>
          </div>
          <div>
            <h5>이름</h5>
            <input type="text" name="name" id="name" placeholder="${loginUser.name}">
          </div>
          <br>
          <div>
            <h5>휴대폰번호</h5>
            <input type="text" name="mobile" id="mobile" placeholder="${loginUser.mobile}">
            <h6></h6>
          </div>
          
          <div>
            <h5>주소</h5>
            <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="postcode" name="postcode" placeholder="${loginUser.postcode}"><br>
            <input type="text" id="address" name="address" placeholder="${loginUser.address}"><br>
            <input type="text" id="extraAddress" name="extraAddress" placeholder="${loginUser.extraAddress}"><br>
            <input type="text" id="detailAddress" name="detailAddress" placeholder="${loginUser.detailAddress}"> 
          </div>
          <br>
       
          <div>
            <button type="submit" class="submit dead-btn">개인정보 변경하기</button>
          </div>
              
        </form>

      </div>
    </div>
  </div>
              
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->


<script>
 
  var emailCheck = false,
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
      console.log(resData);
    }).fail(jqXHR=>{
      console.log(jqXHR);
    })
    
  }

  document.getElementById('get-code-btn').addEventListener('click', evt=>{
    fnEmailCheck();
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
      pw.focus();
  	}else if(text_check.test(pw_v) == true){
      $("#pw").next("h6").html('');
      if(pw2_v == ""){
        $("#pw2").next("h6").html('확인을 위해 비밀번호는 한번 더 입력해주세요.');
        pw2.focus();
      }else{
        if(pw_v == pw2_v){
          $("#pw2").next("h6").html('비밀번호가 일치합니다.');
          passwordCheck = true;//
        }else{
          $("#pw2").next("h6").html('확인을 위해 비밀번호는 한번 더 입력해주세요.');
        }    
      }                                 
   	}else{
      $("#pw").next("h6").html('5자리 이상의 영문 대소문자, 최소 1개의 숫자 혹은 특수 문자를 포함하여야 합니다.');
      $("#pw2").next("h6").html('');
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
 
  //submit 버튼 컨트롤
  /*아직 이메일체크 빠져 있음.*/
  $(document).on("keyup", "#pw, #mobile", evt=>{
    if(mobileCheck == true && passwordCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
  });
  
</script>

<script>
  // 변경 성공 알리기.
  if('${signupMessage}' !== ''){   /* 수정필요. */
    alert('${signupMessage}');
  }

</script>

<%@ include file="../layout/footer.jsp" %>