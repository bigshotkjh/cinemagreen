<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<link href="" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/1h6QZz5U+Y1S8M1U3VZ1+2YQ7Q4S4M0F1n6r3Z" crossorigin="anonymous"></script>

<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../admin/adminheader.jsp">
  <jsp:param value="CINEMAGREEN ADMIN" name="title"/>
</jsp:include>




































<%@ include file="../admin/adminfooter.jsp" %>

