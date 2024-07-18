<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="userpage" name="title"/>
</jsp:include>


<!-- @@@@@@@@@@@@@@@@@@@@@@@ -->
<div class="wrap">
  <div class="sections section">
    <div class="width_con">
      <div class="title_con white ">
        <h4 class="title">My Page</h4><br>
        
      </div>
    </div>
  </div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->



<script>

</script>

<%@ include file="../layout/footer.jsp" %>