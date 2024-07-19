<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="예매" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${contextPath}/static/css/reserve.css">
<style>	

</style>

	<div class="width_con">
		<div class="reserve_wrap">
				<h5 class="title">영화예매</h5>
				<div class="box_con">
					<div class="list_head">
		        <h5 class="sub_title line">인원선택 <span class="btm_txt">최대 3까지 선택 가능</span></h5>
		      </div>
		    </div>
		</div>
	</div>
	
<script>

$(function() {

	

});
		
</script>
<%@ include file="../layout/footer.jsp" %>
