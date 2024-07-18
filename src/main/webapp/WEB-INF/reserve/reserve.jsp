<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="예매" name="title"/>
</jsp:include>

	<div class="">
		<div class="">
			<!-- 영화리스트 -->
				<div class="list-head">
	        <h5 class="r-h5">영화</h5>
	        <a href="#" class="btn-search"></a>
	        <div class="search">
	            <input type="text" id="srchMovie" class="inp-mv" placeholder="영화명을 입력해주세요.">
	            <a href="#" class="btn-srch"></a>
	            <a href="#" class="btn-remove"></a>
	        </div>
	 		 </div>
	   	 <div class="tab">
            <a href="#" class="btnMovieType active" data-type="all">전체</a>
        </div>
	    <div class="tab2">
	        <a href="#" class="btnMovieTab active" data-tab="boxoffice">예매율 순</a>
	    </div>
		</div>	
	</div>

<%@ include file="../layout/footer.jsp" %>