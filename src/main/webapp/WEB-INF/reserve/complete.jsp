<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="예매" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${contextPath}/static/css/reserve.css">

<div class="width_con">
		<div class="reserve_wrap">
				<h5 class="title">영화예매</h5>
				<div class="box_con rsv_seat">
					<div class="list_head">
		        <h5 class="sub_title line">결제가 완료되었습니다.</span></h5>
		      </div>
		     	<div class="list_body ">
		     	   예매자명 : 김그린 ${loginUser.name}<br>
		     		 결제번호 : imp_241584739601 ${pay.payId}<br>
		     		 결제금액 : 5000 원 ${pay.amount}<br>
		     		 티켓번호 : 202407283301220102 ${pay.ticketNo}<br>
					</div>
					<button onclick="location.href='${contextPath}/'" type="button" id="btnNext" style="margin-top:15px;">마이페이지</button>
		    </div>
		</div>

<script>
	
 </script>

<%@ include file="../layout/footer.jsp" %>
