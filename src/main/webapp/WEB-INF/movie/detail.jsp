<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!-- 이거 추가하셔야 합니다 -->
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>

<h1>${movie.movieNm}(${movie.titleEng})</h1>
<div><img src="${fn:split(movie.posterUrls, '|')[0]}"></div>
<div>장르 ${movie.genres}</div>
<div>상영시간 ${movie.runtime}분</div>
<div>개봉일 ${movie.openDt}</div>
<div>상영등급 ${movie.rating}</div>
<h3>줄거리</h3>
<div>${movie.plot}</div>
<h3>스틸컷</h3>
<c:forEach var="stillUrl" items="${fn:split(movie.stillUrls, '|')}">
  <div><img src="${stillUrl}"></div>
</c:forEach>

</body>
</html>