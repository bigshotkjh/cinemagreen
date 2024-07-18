<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="userpage" name="title"/>
</jsp:include>

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
<div class="wrap">
  <div class="sections section_userpage">
    <div class="width_con">
      <div class="title_con white userpage">
        <h4 class="title">User Page</h4><br>
        <a href="${contextPath}/user/leave.do">회원탈퇴</a>
      </div>
    </div>
  </div>
              
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->



<script>

</script>

<%@ include file="../layout/footer.jsp" %>