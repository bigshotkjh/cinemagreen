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
				<div class="box_con rsv_seat">
					<div class="list_head">
		        <h5 class="sub_title line">인원선택 <span class="btm_txt">최대 3까지 선택 가능</span></h5>
		      </div>
		     	<div class="list_body ">
		     		<!-- <form action="#" id="rsv_seat" method="post"> -->
		     			<!-- 일반  -->
		     			<div class="t1">일반</div>
	     				<div class="list">
     						<input type="radio" id ="a0" class="rsv_type ticket custom" name="type1" value="0" data-no="0" checked>	
     						<label for="a0">0</label>
     						<input type="radio" id ="a1" class="rsv_type ticket custom" name="type1" value="1" data-no="0">
     						<label for="a1">1</label>
     						<input type="radio" id ="a2" class="rsv_type ticket custom" name="type1" value="2" data-no="0">	
     						<label for="a2">2</label>
	     					<input type="radio" id ="a3" class="rsv_type ticket custom" name="type1" value="3" data-no="0">	
	     					<label for="a3">3</label>
	     			 	</div>
	     			 	<!-- 청소년 -->
	     			 	<div class="t1">청소년</div>
	     				<div class="list">
	     					<input type="radio" id ="b0" class="rsv_type ticket custom" name="type2" value="0" data-no="1" checked>	
     						<label for="b0">0</label>
     						<input type="radio" id ="b1" class="rsv_type ticket custom" name="type2" value="1" data-no="1">
     						<label for="b1">1</label>
     						<input type="radio" id ="b2" class="rsv_type ticket custom" name="type2" value="2" data-no="1">	
     						<label for="b2">2</label>
	     					<input type="radio" id ="b3" class="rsv_type ticket custom" name="type2" value="3" data-no="1">	
	     					<label for="b3">3</label>
	     			 	</div>
	     			 	<!-- 우대 -->
	     			 	<div class="t1">우대</div>
	     				<div class="list">
	     					<input type="radio" id ="c0" class="rsv_type ticket custom" name="type3" value="0" data-no="2" checked>	
     						<label for="c0">0</label>
     						<input type="radio" id ="c1" class="rsv_type ticket custom" name="type3" value="1" data-no="2">
     						<label for="c1">1</label>
     						<input type="radio" id ="c2" class="rsv_type ticket custom" name="type3" value="2" data-no="2">	
     						<label for="c2">2</label>
	     					<input type="radio" id ="c3" class="rsv_type ticket custom" name="type3" value="3" data-no="2">	
	     					<label for="c3">3</label>
	     			 	</div>
							<!-- </form> -->
							<div class="pay_area">  
              	<p class="tit_pay sub_title">결제금액</p>
                <div id="pay_money" class="result">
                    <span>0 원</span>  
                </div>
              </div>
						</div>
					</div>
					<div class="box_con rsv_seat">
						<div class="list_head">
			        <h5 class="sub_title line">좌석선택 <span class="btm_txt">- </span></h5>
			      </div>
					</div>
		    </div>
		</div>

<script>
	const ticket = document.getElementsByClassName("ticket");
	const result = document.getElementById('result');
	           	
	$('.list .ticket').on("change",function(){
		
		var totalmoney=0;
	
		var chkLen = $(".ticket").length;
		typeA = Number($("[name='type1']:checked").val());
		typeB = Number($("[name='type2']:checked").val());
		typeC = Number($("[name='type3']:checked").val());
		totalCount = (typeA + typeB + typeC);
		
		Amoney = (typeA * 10000);
		Bmoney = (typeB * 7000);
		Cmoney = (typeC * 5000);		
		totalmoney = (Amoney + Bmoney + Cmoney);
		
		for(var i=1; i<chkLen; i++){
			if($("input[name='type"+i+"']:checked").val() != undefined){
				//chkTotal += Number($("input[name='type"+i+"']:checked").val());
				if(totalCount > 3){
					$('.result span').addClass('red').text('선택 가능한 인원은 최대 3명 입니다.');
					$("input[name='type1']")[0].checked = true;
					$("input[name='type2']")[0].checked = true;
					$("input[name='type3']")[0].checked = true;
				}else{
					$('.result span').removeClass('red').text(totalmoney + '원');
				}
			}
			
		}
	})
    
 </script>

<%@ include file="../layout/footer.jsp" %>
