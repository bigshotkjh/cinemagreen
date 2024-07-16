<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="./layout/header.jsp">
  <jsp:param value="홈" name="title"/>
</jsp:include>

<h1>Welcome To My Home</h1>

<script>
  if('${signupMessage}' !== ''){
    alert('${signupMessage}');
  }
  if('${leaveMessage}' !== ''){
    alert('${leaveMessage}');
  }
</script>

<%@ include file="./layout/footer.jsp" %>