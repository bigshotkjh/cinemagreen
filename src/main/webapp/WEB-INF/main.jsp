<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="./layout/header.jsp">
  <jsp:param value="홈" name="title"/>
</jsp:include>

<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<style>
    .movie-chart {
        display: flex;
        flex-wrap: wrap;
    }
    .movie {
        margin: 2.5%;
        text-align: center;
        position: relative;
        width: 200px;
        transition: all .3s;
        cursor: pointer;
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
</head>
<body>
<div class="banner_wrap"><img src="${contextPath}/static/images/main_banner01.jpg/"></div>
<div class="width_con">
	<h5 class="title">일일박스오피스</h5> 
	<div id="movie-chart" class="movie-chart "></div>
</div>
<script>

  const getDailyBoxOfficeList = () => {    
    $.ajax({
      type: 'get',
      url: '${contextPath}/movie/boxOfficeList.do',
      dataType: 'json'
    })
    .done(resData => {
      const movieChart = $('#movie-chart');
      movieChart.empty();
      resData.forEach(boxOffice => {
        let movie = '<div class="movie" data-movie-no="' + boxOffice.movieNo + '">';
        movie += '<img src="'+ boxOffice.posterUrls.substring(0, boxOffice.posterUrls.indexOf('|')) +'" alter="' + boxOffice.movieNm + ' 포스터" onerror="this.onerror=null; this.src=\'${contextPath}/static/images/noImage.jpg\';">';
        movie += '<div class="overlay">';
        movie +=   '<p>' + boxOffice.plot + '</p>';
        movie += '</div>';
        movie += '<h2>' + boxOffice.movieNm + '</h2>';
        movie += '</div>';
        movieChart.append(movie);
      })
    })
    .fail(jqXHR => {
      alert(jqXHR.responseText);
      console.log(jqXHR.responseText);
    })
  }

  const movieDetailPage = () => {
    $(document).on('click', '.movie', event => {
      location.href = '${contextPath}/movie/detail.do?movieNo=' + event.currentTarget.dataset.movieNo;
    })
  }
  
  getDailyBoxOfficeList();
  movieDetailPage();
  
</script>

<%@ include file="./layout/footer.jsp" %>