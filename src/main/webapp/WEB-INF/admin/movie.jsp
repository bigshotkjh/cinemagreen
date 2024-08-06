<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<link href="" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/1h6QZz5U+Y1S8M1U3VZ1+2YQ7Q4S4M0F1n6r3Z" crossorigin="anonymous"></script>

<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../admin/adminheader.jsp">
  <jsp:param value="CINEMAGREEN ADMIN" name="title"/>
</jsp:include>
<style>
  
    .textarea-small {
      width: 33%;
      height: 30%;
      box-sizing: border-box; /* 패딩과 테두리를 포함하여 너비 조정 */
    }
    .input-wide {
      width: 33%;
    }
    
<<<<<<< HEAD
    
    /* 모달 크기 조정 */
    .modal-dialog {
      max-width: 90%; /* 너비를 80%로 설정 (원하는 비율로 조정 가능) */
      margin: 1.75rem auto; /* 중앙 정렬을 위한 마진 */
    }

    /* 모달 내용 영역의 높이를 늘리려면 */
    .modal-content {
      height: auto; /* 자동 높이 조정 */
      min-height: 400px; /* 최소 높이 설정 (원하는 값으로 조정) */
    }
    

    
    
    
=======
>>>>>>> 574f47f2da5f98cefffce1459d2482328ddf3b3f
</style>


<main>
  <div class="container-fluid px-4">
    <div class="card mb-4">
      <div class="card-header">
        <i class="fas fa-table me-1"></i>
        상영중인 영화 목록
        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#movieRuntimeModal" id="manageRuntimeBtn">
          상영 시각 관리
        </button>
      </div>
      <div class="card-body">
        <table id="datatablesSimple" class="table table-striped">
          <thead>
            <tr>
              <th>선택</th>
              <th>영화순위</th>
              <th>제목</th>
              <th>등급</th>
              <th>장르</th> 
              <th>상영시간(분)</th>
              <th>상세</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="movie" items="${movieList}">
              <tr>
<<<<<<< HEAD
=======
                <td>
                  <input type="checkbox" class="movie-checkbox" data-movieno="${movie.movieNo}">
                </td>
>>>>>>> 574f47f2da5f98cefffce1459d2482328ddf3b3f
                <td>${movie.movieNo}</td>
                <td>${movie.movieNm}</td>
                <td>${movie.rating}</td>
                <td>${movie.genres}</td>
                <td>${movie.runtime}</td>
                <td>
                  <button class="btn btn-success detail-btn" data-movieno="${movie.movieNo}">
                    상세보기
                  </button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</main>


<%@ include file="../admin/adminfooter.jsp" %>
<!-- 영화 상세 정보에 대한 모달 -->
<div class="modal fade" id="movieDetailModal" tabindex="-1" aria-labelledby="movieDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="movieDetailModalLabel">상세보기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="wrap">
          <div class="sections section_moviepage">
            <div class="width_con">
              <div class="title_con white moviepage">                    <!-- 추가하기 -->
                <form id="movie-info-form" method="post" action="${contextPath}/admin/updateInf.do">
                  <input type="hidden" id="modalMovieNo" name="movieNo" value="">
                  
          <!-- 프로필 들어갈 자리 -->
          
                  <div>
                    <h5>제목</h5>
                    <input type="text" class="offset-1 input-wide" name="movie_nm" id="modalMovieNmInput" value="">
                  </div>
                  <div>
                    <h5>등급</h5>
                    <input type="text" class="offset-1 input-wide" name="rating" id="modalRating" value="">
                  </div>
                  <div>
                    <h5>장르</h5>
                    <input type="text" class="offset-1 input-wide"  name="genres" id="modalGenres" value="">
                  </div>
                  <div>
                    <h5>상영시간(분)</h5>
                    <input type="text" class="offset-1 input-wide"  name="runtime" id="modalRuntime" value="">
                  </div>
                  <div>
                    <h5>줄거리</h5>
                    <textarea class="offset-1 plot textarea-small" name="plot" id="modalPlot" rows="4"></textarea>
<<<<<<< HEAD
=======
                  </div>
                  <div> 
                    <h5>영제</h5>
                    <input type="text" class="offset-1 input-wide"  name="title_eng" id="modalTitleEng" value="">
>>>>>>> 574f47f2da5f98cefffce1459d2482328ddf3b3f
                  </div>
                  <div>
                    <img id="modalPoster" src="" alt="영화 포스터" style="width: 100%; height: auto; margin-bottom: 10px;">
                    </div>
                  <br>
          <!--<div>
            <button type="button" onclick="adminDeleteMovie()">삭제하기</button>
          </div>-->
                </form>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<<<<<<< HEAD


<!-- JSP에서 MyBatis 쿼리 결과를 사용한 모달 -->
<div class="modal fade" id="movieRuntimeModal" tabindex="-1" role="dialog" aria-labelledby="movieRuntimeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="movieRuntimeModalLabel">상영 시각 관리</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div style="display: flex;">
          <div style="overflow-x: auto; width: 50%;">
            <table class="table" id="runtimeTable" style="width: 100%;">
              <thead>
                <tr>
                  <th>순서번호</th>
                  <th>제목</th>
                  <th>상영 시간</th>
                  <th>상영 시각</th>
                  <th>설정</th>
                </tr>
              </thead>
              <tbody>
                <!-- AJAX로 데이터가 로드되는 위치. -->
              </tbody>
            </table>
          </div>
          <div id="selectedMovieInfo" style="margin-left: 20px;">
            <h6>선택된 영화:</h6>
            <div id="movieTitle"></div>
            <h6>영화번호:</h6>
            <div id="movieNo"></div>
            <input type="datetime-local" id="movieTimeInput" placeholder="상영 시각 입력" />
            <button type="button" onclick="adminInsertTime()">등록</button>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>







=======
>>>>>>> 574f47f2da5f98cefffce1459d2482328ddf3b3f
<!-- jQuery 및 AJAX 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
  $(document).ready(function() {
    // 상세보기 버튼 클릭 시
    $('.detail-btn').click(function() {
      var movieNo = $(this).data('movieno'); // data-userno 속성 가져오기

      // AJAX 요청
      $.ajax({
        url: '/admin/getMovieDetail/' + movieNo,
        method: 'GET',
        success: function(data) {
          $('#modalMovieNmInput').val(data.movieNm); // 수정된 부분
          $('#modalRating').val(data.rating);
          $('#modalGenres').val(data.genres);
          $('#modalRuntime').val(data.runtime);
          $('#modalPlot').val(data.plot);
          $('#modalTitleEng').val(data.titleEng);
          $('#modalPoster').attr('src', data.poster_urls); // 포스터 URL 설정
          $('#movieDetailModal').modal('show'); // 모달 표시
        },
        error: function() {
          alert('영화 정보를 불러오는데 실패했습니다.');
        }
      });
    });

    // 모달 닫기 이벤트
    $('#movieDetailModal').on('hide.bs.modal', function() {
      // 입력값 초기화 등의 추가 로직
<<<<<<< HEAD
      $('#modalMovieNo').val('');
      $('#modalMovieNmInput').val('');
      $('#modalRating').val('');
      $('#modalGenres').val('');
      $('#modalRuntime').val('');
      $('#modalPlot').val('');
      $('#modalTitleEng').val('');
      $('#modalPoster').attr('src', ''); // 포스터 초기화
    });
  });
  
  
  
  
  
  
  $(document).ready(function() {
    $('#manageRuntimeBtn').click(function() {
      $('#runtimeTable tbody').html('<tr><td colspan="5">로딩 중...</td></tr>');

      $.ajax({
        url: '/admin/getRuntimeList.do', // MyBatis 쿼리를 호출하는 URL
        method: 'GET',
        success: function(data) {
          $('#runtimeTable tbody').empty();
          if (data && data.length > 0) {
            let tbody = '';
            $.each(data, function(index, movie) {
              tbody += '<tr>';
              tbody += '<td>' + movie.timeNo + '</td>';
              tbody += '<td>' + movie.movieDTO.movieNm + '</td>';
              tbody += '<td>' + movie.movieDTO.runtime + '</td>';
              tbody += '<td>' + movie.startTime + '</td>';
              tbody += '<td>' + '<button class="btn btn-primary btn-sm" onclick="setMovie(\'' + movie.movieDTO.movieNo + '\', \'' + movie.movieDTO.movieNm + '\')">시각 설정</button>' + '</td>';
              tbody += '</tr>';
            });
            $('#runtimeTable tbody').html(tbody);
          }
        }
      });
    });
  });

  // 영화 설정 함수
  function setMovie(movieNo, movieNm) {
      $('#movieNo').text(Number(movieNo)); // 선택된 영화 번호를 숫자로 표시
      $('#movieTitle').text('제목: ' + movieNm); // 선택된 영화 제목 표시
      $('#movieTimeInput').val(''); // 입력창 초기화
  }
  
  
  
  
  
  

  
  
  
  
  const adminInsertTime = () => {
    if (confirm("등록하시겠습니까?")) {
      const movieNo = Number($('#movieNo').text()); // movieNo를 숫자형으로 변환
      const startTime = $('#movieTimeInput').val();
      
      console.log(JSON.stringify({ 
        movieNo: movieNo,
        startTime: startTime
      }));
      
      $.ajax({
        url: "${contextPath}/admin/adminInsertTime.do",
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
          movieNo: movieNo,
          startTime: startTime
        }),
        success: function(response) {
          console.log(response); // 응답을 콘솔에 출력하여 확인
          if (response.success) { // 'isSuccess' 대신 'success' 사용
            alert('등록이 완료되었습니다.');
            location.reload();
          } else {
            alert('등록이 실패했습니다.'); // 실패 메시지 추가
          }
        }
      });
    }
  };
  
  
  const adminUpdateTime = () => {
    if (confirm("수정하시겠습니까?")) {
      const movieNo = $('#modalmovieNo').val();
      const startTime = $('#modalstartTime').val();
      
    console.log(JSON.stringify({ 
              movieNo: movieNo,
              startTime: startTime
            }));
    
      $.ajax({
        url: "${contextPath}/admin/adminUpdateTime.do",
        method: 'POST',
      contentType: 'application/json',
        data: JSON.stringify({
          movieNo: movieNo,
          startTime: startTime
        }),
        success: function(response) {
      if(response.isSuccess) {        
            alert('수정이 완료되었습니다.');
        location.reload();
      } else {
            alert('수정이 실패했습니다.');
      }
        },
        error: function(xhr, status, error) {
          console.error("Error details: ", xhr.responseText);
          alert('수정에 실패했습니다. 다시 시도해주세요.');
        }
      });
    }
  };
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
=======
    });
  });
>>>>>>> 574f47f2da5f98cefffce1459d2482328ddf3b3f
</script>




















