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
</style>

<main>
  <div class="container-fluid px-4">
    <div class="card mb-4">
      <div class="card-header">
        <i class="fas fa-table me-1"></i>
        상영중인 영화 목록
      </div>
      <div class="card-body">
        <table id="datatablesSimple" class="table table-striped">
          <thead>
            <tr>
              <th>영화순위</th>
              <th>상영 시작 시각</th>
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
                <td>${movie.movieNo}</td>
                <td>
                  <c:choose>
                    <c:when test="${not empty movie.runtimeInfo.startTime}">
                      ${movie.runtimeInfo.startTime}
                    </c:when>
                    <c:otherwise>
                      NULL
                    </c:otherwise>
                  </c:choose>
                </td><!-- 상영 시작 시각 -->
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

<!-- 모달 -->
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
              <div class="title_con white moviepage">
                <form id="movie-info-form" method="post" action="${contextPath}/admin/updateInf.do">
                  <input type="hidden" id="modalMovieNo" name="movieNo" value="">
                  
                  <div style="display: flex; align-items: center; justify-content: space-between;">
                    <div style="flex: 1;">
                      <h5>제목</h5>
                      <input type="text" class="offset-1 input-wide" name="movie_nm" id="modalMovieNmInput" value="">
                    </div>
                    <div>
                      <img id="modalPoster" src="" alt="영화 포스터" style="width: 100px; height: auto; margin-left: 10px;">
                    </div>
                  </div>
                  <div>
                    <h5>등급</h5>
                    <input type="text" class="offset-1 input-wide" name="rating" id="modalRating" value="">
                  </div>
                  <div>
                    <h5>장르</h5>
                    <input type="text" class="offset-1 input-wide" name="genres" id="modalGenres" value="">
                  </div>
                  <div>
                    <h5>상영시간(분)</h5>
                    <input type="text" class="offset-1 input-wide" name="runtime" id="modalRuntime" value="">
                  </div>
                  <div>
                    <h5>줄거리</h5>
                    <textarea class="offset-1 plot textarea-small" name="plot" id="modalPlot" rows="4"></textarea>
                    <div style="border: 1px solid #ccc; padding: 10px; max-width: 200px; margin: 10px auto;">
                      <h5>상영 시간</h5>
                      <div style="display: flex; justify-content: space-between;">
                        <div>
                          <label for="modalStartTime">상영 시작시간</label>
                          <input type="time" name="start_time" id="modalStartTime" value="">
                        </div>
                      </div>
                      <button type="button" class="btn btn-primary" onclick="registerShowTime()">입력</button>
                    </div>
                  </div>
                  <div>
                    <h5>영제</h5>
                    <input type="text" class="offset-1 input-wide" name="title_eng" id="modalTitleEng" value="">
                  </div>
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

<script>
function registerShowTime() {
  const startTime = document.getElementById('modalStartTime').value;

  if (!startTime) {
    alert("상영 시작시간을 입력해 주세요.");
    return;
  }

  // 여기에 상영 시간을 등록하는 로직을 추가할 수 있습니다.
  console.log("상영 시작시간:", startTime);
  
  // 예를 들어, AJAX 요청을 통해 서버에 상영 시간을 전송할 수도 있습니다.
}
</script>

<!-- jQuery 및 AJAX 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    // 상세보기 버튼 클릭 시
    $('.detail-btn').click(function() {
      var movieNo = $(this).data('movieno');

      // AJAX 요청
      $.ajax({
        url: '/admin/getMovieDetail/' + movieNo,
        method: 'GET',
        success: function(data) {
          console.log(data);
          $('#modalMovieNo').val(data.movieNo); // 영화 번호 설정
          $('#modalMovieNmInput').val(data.movieNm);
          $('#modalRating').val(data.rating);
          $('#modalGenres').val(data.genres);
          $('#modalRuntime').val(data.runtime);
          $('#modalStartTime').val(data.startTime);
          $('#modalPlot').val(data.plot);
          $('#modalTitleEng').val(data.titleEng);
          $('#modalPoster').attr('src', data.posterUrl); // 포스터 URL 설정
          $('#movieDetailModal').modal('show'); // 모달 표시
        },
        error: function() {
          alert('영화 정보를 불러오는데 실패했습니다.');
        }
      });
    });

    $('#movieDetailModal').on('hide.bs.modal', function() {
      // 입력값 초기화 등의 추가 로직
      $('#modalMovieNo').val('');
      $('#modalMovieNmInput').val('');
      $('#modalRating').val('');
      $('#modalGenres').val('');
      $('#modalRuntime').val('');
      $('#modalStartTime').val('');
      $('#modalPlot').val('');
      $('#modalTitleEng').val('');
      $('#modalPoster').attr('src', ''); // 포스터 초기화
    });
  });
  
  
  
  
  
  const adminInsertMovie = () => {
    
    if (confirm("상영 시간을 등록하시겠습니까?")) {
    
      
      const movieNo = $('#modalMovieNo').val();
      const startTime = $('#modalStartTime').val();
      
    console.log(    JSON.stringify({ 
      
              movieNo: movieNo,
              startTime: startTime
            }));
    
      $.ajax({
        url: "${contextPath}/admin/adminInsertMovie.do",
        method: 'POST',
      contentType: 'application/json',
        data: JSON.stringify({ 
          
          movieNo: movieNo,
          startTime: startTime
        }),
        success: function(response) {
      if(response.isSuccess) {        
            alert('상영 시간 등록이 완료되었습니다.');
        location.reload();
      } else {
            alert('상영 시간 등록이 실패했습니다.');
      }
        },
        error: function(xhr, status, error) {
          console.error("Error details: ", xhr.responseText);
          alert('상영 시간 등록에 실패했습니다. 다시 시도해주세요.');
        }
      });
    }
  };
  
  
  
  
  
  
  
  
  
  
  
  
</script>
