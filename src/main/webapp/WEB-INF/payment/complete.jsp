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
		        <h5 class="sub_title line">결제가 완료되었습니다.</h5>
		      </div>
		      
		     	<div class="list_body ">
		     		예매자명 : ${loginUser.name}<br>
						결제번호 : ${payment.payId}<br>
						결제금액 : ${payment.amount}<br>
						티켓번호 : ${payment.ticketNo}<br>
						영화정보 : <br>
						선택좌석 :  

					</div>
					<button onclick="location.href='${contextPath}/'" type="button" id=""  class="c-btn c-cblue" style="margin-top:15px;">마이페이지</button>
					<button onclick="canclePay()" type="button" id="canclePay"  class="c-btn c-gray" style="margin-top:15px;">결제취소</button>
		    </div>
		</div>

<script>
	
//const canclePay = document.getElementById('canclePay');

// 취소처리 작업 보류 ==
function canclePay() {
	
	if(confirm('취소 처리를 진행하시겠습니까?')){
		 $.ajax({
				url: '/payment/paymentCancel',
				method: 'POST',
				contentType: "application/json",
				data: JSON.stringify({
	        "merchant_uid": "${payment.ticketNo}", // 예: ORD20180131-0000011
	        "cancel_request_amount": "${payment.amount}", // 환불금액
	        "reason": "테스트 결제 환불" // 환불사유,
	      }),
      dataType: "json",
    	  success: function() {
    		 	
    	  }
		}).fail(function(){
			 alert('서비스 기능 보류 ..');
		 })
	}
}

 </script>

<%@ include file="../layout/footer.jsp" %>
