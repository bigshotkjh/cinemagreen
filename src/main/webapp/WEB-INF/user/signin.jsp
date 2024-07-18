<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="Signin" name="title"/>
</jsp:include>

<h4 class="title">Sign In</h4>

<form id="signin-form"
      method="post"
      action="${contextPath}/user/signin.do">

  <input type="hidden" name="url" value="${url}">

  <div>
    <label for="email">이메일</label>
    <input type="text" name="email" id="email" placeholder="example@example.com">
    <input type="checkbox" id="checkId">
    <label for="id">이메일저장</label>
  </div>
  
  <div>
    <label for="pw">비밀번호</label>
    <input type="password" name="pw" id="pw">
  </div>
  
  <%--  / SNS 로그인 / 아이디비번 찾기 --%>
  
  <div>
    <button type="submit" onclick="setCookie()">로그인하기</button>
    <button type="button" onclick="history.back()">취소하기</button>
  </div>
      
</form>

<script>
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
</script>

<%@ include file="../layout/footer.jsp" %>