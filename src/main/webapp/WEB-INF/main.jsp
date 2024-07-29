<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="./layout/header.jsp">
  <jsp:param value="홈" name="title"/>
</jsp:include>

<h1>Welcome To My Home</h1>

<h1>현재 상영중인 영화</h1>
<div class="movie-chart">
    <c:forEach var="movie" items="${movies}">
        <div class="movie">
            <img src="http://image.tmdb.org/t/p/original${movie.poster_path}" alt="${movie.title} 포스터">
            <div class="overlay">
                <p>${movie.overview}</p>
            </div>
            <h2>${movie.title}</h2>
        </div>
    </c:forEach>
</div>

<style>
    .movie-chart {
        display: flex;
        flex-wrap: wrap;
    }
    .movie {
        margin: 10px;
        text-align: center;
        position: relative;
        width: 200px;
    }
    .movie img {
        width: 100%;
        height: auto;
        transition: opacity 0.3s ease;
    }
    .movie .overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.8);
        color: white;
        opacity: 0;
        transition: opacity 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        box-sizing: border-box;
        text-align: center;
    }
    .movie:hover img {
        opacity: 0.3;
    }
    .movie:hover .overlay {
        opacity: 1;
    }
</style>

<%@ include file="./layout/footer.jsp" %>