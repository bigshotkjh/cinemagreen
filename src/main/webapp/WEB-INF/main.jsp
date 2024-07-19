<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="./layout/header.jsp">
  <jsp:param value="홈" name="title"/>
</jsp:include>

<h1>Welcome To My Home</h1>

<!-- 영화 목록 섹션 시작 -->
<div id="movie-list">
  <h2>Movie List</h2>
  <div class="movies">
    <!-- 단일 영화 항목 예제 -->
    <div class="movie-item">
      <img src="path/to/movie/poster.jpg" alt="Movie Poster">
      <h3>Movie Title</h3>
      <p>Rating: 99%</p>
      <p>Reservation Rate: 19.3%</p>
    </div>
    <!-- 각 영화를 반복하여 표시 -->
  </div>
</div>
<!-- 영화 목록 섹션 끝 -->

<script>
  if('${signupMessage}' !== ''){
    alert('${signupMessage}');
  }
  if('${leaveMessage}' !== ''){
    alert('${leaveMessage}');
  }

  // 영화 데이터를 가져와서 표시 (정적 데이터 예제, 동적 데이터 가져오는 로직으로 대체)
  document.addEventListener("DOMContentLoaded", function() {
    const movies = [
      {
        title: "데드풀과 울버린",
        rating: "99%",
        reservationRate: "19.3%",
        poster: "path/to/deadpool-wolverine.jpg"
      },
      {
        title: "명탐정 코난: 100만",
        rating: "94%",
        reservationRate: "13.8%",
        poster: "path/to/detective-conan.jpg"
      },
      // 여기에 더 많은 영화 객체 추가
    ];

    const movieList = document.querySelector("#movie-list .movies");
    movies.forEach(movie => {
      const movieItem = document.createElement("div");
      movieItem.className = "movie-item";
      movieItem.innerHTML = `
        <img src="${movie.poster}" alt="${movie.title} Poster">
        <h3>${movie.title}</h3>
        <p>Rating: ${movie.rating}</p>
        <p>Reservation Rate: ${movie.reservationRate}</p>
      `;
      movieList.appendChild(movieItem);
    });
  });
</script>

<%@ include file="./layout/footer.jsp" %>
