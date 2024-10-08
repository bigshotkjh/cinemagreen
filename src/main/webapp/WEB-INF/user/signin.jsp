<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="Signin" name="title"/>
</jsp:include>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style>
  .sections.section_signin .width_con .title_con h4{ position: relative;}
  .sections.section_signin .width_con .signin form{ position: relative;}
  .title_con h6{ margin-top: 0;}
  input { border-radius: 4px;}
  .title_con{ display: flex; align-items: center; flex-direction: column; }
  #signin-form{ border-radius: 5px; padding: 20px; background-color: #FFFFF4;  border: 1px solid  #ABDEC2;}
  .section_signup { background: white; color : #3f3f3f;}
</style>


<div class="wrap">
  <div class="sections section_signin">
    <div class="width_con">
      <div class ="aaa">
        <div class="title_con white signin">
	        <h4 class="title">Sign In</h4><br>
	        <form id="signin-form">
	          <input type="hidden" name="url" value="${url}">
	          
	          <div>
	            <input type="text" name="email" id="email" class="ipt" placeholder="이메일">
	            <input type="checkbox" id="checkId">
	            <label for="id">이메일저장</label>
	            <h6></h6>
	          </div>
	          
	          <div>
	            <input type="password" name="pw" id="pw" class="ipt" placeholder="비밀번호">
	          </div><br>
	          
	          <%--  / SNS 로그인 / 아이디비번 찾기 --%>
	          
	          <div>
	            <button type="button" class="c-btn c-cblue" id="submitbtn" onclick="setCookie()">로그인하기</button>
	            <button type="button" class="c-btn c-gray"onclick="history.back()">취소하기</button>
	            <h6></h6>
	            <button type="button" class="line-btn" onclick="pwfind()">비밀번호 찾기</button>
	            <button type="button" class="line-btn" onclick="emailfind()">이메일 찾기</button>
	            <h6></h6>
	          </div>
	          
	          <!-- 네이버 로그인 버튼 노출 영역 -->
	          <a href="${apiURL}"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
	          <!-- //네이버 로그인 버튼 노출 영역 -->
	                      
	        </form>
        </div>
      </div>
    </div>
  </div>
 
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<script>

//아이디와 비밀번호 ajax
  const fnSignin = () => {
    $.ajax({
      type: 'post',
      url: '${contextPath}/user/signin.do',
      data: $('#signin-form').serialize(),
      dataType: 'json'
    }).done(resData => {
      
      if (resData.isSuccess) {
        
       //비밀번호 90일 변경
        if(resData.nowPwModify) {
          
          const result = confirm("비밀번호를 변경한지 90일이 지났습니다. 지금 변경하시겠습니까?");
          
          if(result) {
              location.href = "/user/pwchange.page"; 
          } else {
            //adminCheck
             if(resData.adminCheck) {
               location.href = "/admin/admin.page";
             }else{
               location.href = "/main.do"; 
             }
          }
            
        } else {
          //adminCheck
           if(resData.adminCheck) {
             location.href = "/admin/admin.page"; 
           }else{
             location.href = "/main.do"; 
           }
        }
        
      } else {
        alert('아이디와 비밀번호를 확인해 주세요.');
      }
    }).fail(jqXHR => {
      alert(jqXHR.status);
    });
  }
  
  
  $('#submitbtn').on('click', evt=>{
    fnSignin();
  })

//ID 체크박스 (쿠키)

 //쿠키에 저장
  function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = encodeURIComponent(value) + ((exdays==null) ? "" : "; expires=" + exdate.toUTCString());
    document.cookie = cookieName + "=" + cookieValue;
  }
  
  //쿠키에 삭제
  function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toUTCString();
  }
  
  //쿠키 가져오기
  function getCookie(cookieName){
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
      start += cookieName.length;
      var end = cookieData.indexOf(';', start);
      if(end == -1)end = cookieData.length;
      cookieValue = cookieData.substring(start, end);
    }
    return decodeURIComponent(cookieValue);
  }
  
  
  $(document).ready(() => {
    
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 쿠키값 없으면 공백.
    var userLoginId = getCookie("userLoginId");
    $("input[name='email']").val(userLoginId); 
    
    // ID가 있는경우 아이디 저장 체크박스 체크
    if($("input[name='email']").val() != ""){
      $("#checkId").attr("checked", true);
    }
    
    // 아이디 저장하기 체크박스 
    $("#checkId").change(() => {
      if($("#checkId").is(":checked")){ 
        var userLoginId = $("input[name='email']").val();
          setCookie("userLoginId", userLoginId, 30); // 30일 동안 쿠키 보관
      }else{ 
        deleteCookie("userLoginId");
      }
    });
     
     
     // 아이디 저장하기가  눌린상태에서, ID를 입력한 경우
     $("input[name='email']").keyup(() => {
       if($("#checkId").is(":checked")){  
         var userLoginId = $("input[name='email']").val();
         setCookie("userLoginId", userLoginId, 30); // 30일 동안 쿠키 보관
       }
     });
  
  })
  
  const pwfind = ()=>{
    location.href = "/user/pwfind.page";
  }
  
  const emailfind = ()=>{
    location.href = "/user/emailfind.page";
  }
</script>

<%@ include file="../layout/footer.jsp" %>