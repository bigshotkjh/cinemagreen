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
    <label for="email">아이디</label>
    <input type="text" name="email" id="email" placeholder="example@example.com">
  </div>
  
  <div>
    <label for="pw">비밀번호</label>
    <input type="password" name="pw" id="pw">
  </div>
  
  <%-- 아이디 저장 / SNS 로그인 / 아이디비번 찾기 --%>
  
  <div>
    <button type="submit">로그인하기</button>
    <button type="button" onclick="history.back()">취소하기</button>
  </div>
      
</form>

<script>



</script>

<%@ include file="../layout/footer.jsp" %>