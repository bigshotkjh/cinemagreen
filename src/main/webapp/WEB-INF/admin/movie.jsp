<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

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
        <table class="table table-striped">
          <thead>
            <tr>
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

<!-- 영화 상세 정보에 대한 모달 -->
<div class="modal fade" id="movieDetailModal" tabindex="-1" aria-labelledby="movieDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="movieDetailModalLabel">상세보기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="wrap" style="display: flex;">
          <div class="left-section" style="flex: 1; padding: 20px;">
            <form id="movie-info-form" method="post">
              <input type="hidden" id="modalMovieNo" name="movieNo" value="">
              <h5>제목</h5>
              <input type="text" class="input-wide" name="movie_nm" id="modalMovieNmInput">
              
              <h5>등급</h5>
              <input type="text" class="input-wide" name="rating" id="modalRating">
              
              <h5>장르</h5>
              <input type="text" class="input-wide" name="genres" id="modalGenres">
              
              <h5>상영시간(분)</h5>
              <input type="text" class="input-wide" name="runtime" id="modalRuntime">
              
              <h5>줄거리</h5>
              <textarea class="plot textarea-small" name="plot" id="modalPlot" rows="4"></textarea>
              
              <h5>영제</h5>
              <input type="text" class="input-wide" name="title_eng" id="modalTitleEng" value="">
            </form>
          </div>
          <div class="right-section" style="flex: 1; padding: 20px; display: flex; flex-direction: column; align-items: center;">
            <img id="modalPoster" alt="영화 포스터" style="width: 300px; height: auto; margin-bottom: 20px;">
            <div id="stillCutContainer" style="width: 100%; display: flex; flex-wrap: wrap; justify-content: center;">
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>





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
          <div style="overflow-x: auto; width: 66.67%;"> <!-- 왼쪽 2/3 -->
            <table class="table" id="runtimeTable" style="width: 100%;">
              <thead>
                <tr>
                  <th>순서번호</th>
                  <th>제목</th>
                  <th>상영 시간(분)</th>
                  <th>상영 시각</th>
                  <th>설정</th>
                </tr>
              </thead>
              <tbody>
                <!-- AJAX로 데이터가 로드되는 위치. -->
              </tbody>
            </table>
          </div>
          <div id="selectedMovieInfo" style="margin-left: 20px; width: 33.33%;"> <!-- 오른쪽 1/3 -->
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



<script>
  

  // 상세보기 버튼 클릭 시
  $('.detail-btn').on('click', (event) => {
    const movieNo = $(event.target).data('movieno');

    // AJAX 요청
    $.ajax({
      url: '/admin/getMovieDetail/' + movieNo,
      method: 'GET',
      success: (data) => {
        console.log(data);
        $('#modalMovieNo').val(data.movieNo); // 영화 번호 설정
        $('#modalMovieNmInput').val(data.movieNm);
        $('#modalRating').val(data.rating);
        $('#modalGenres').val(data.genres);
        $('#modalRuntime').val(data.runtime);
        $('#modalPlot').val(data.plot);
        $('#modalTitleEng').val(data.titleEng);
        $('#modalPoster').attr('src', data.posterUrls.split('|')[0]); // 포스터 URL 설정

        // 스틸컷 사진 추가
        const stillCutContainer = $('#stillCutContainer');
        stillCutContainer.empty();

        const stillCuts = data.stillUrls.split('|'); // still_urls를 '|'로 분리

        for (let i = 0; i < stillCuts.length; i++) {
          const img = $('<img>').attr('src', stillCuts[i]).css({
            width: '130px',
            height: 'auto',
            margin: '5px'
          });
          stillCutContainer.append(img);
        }

        $('#movieDetailModal').modal('show'); // 모달 표시
      },
      error: () => {
        alert('영화 정보를 불러오는데 실패했습니다.');
      }
    });
  });

  $('#movieDetailModal').on('hide.bs.modal', () => {
    // 입력값 초기화 등의 추가 로직
    $('#modalMovieNo').val('');
    $('#modalMovieNmInput').val('');
    $('#modalRating').val('');
    $('#modalGenres').val('');
    $('#modalRuntime').val('');
    $('#modalPlot').val('');
    $('#modalTitleEng').val('');
    $('#stillCutContainer').attr('img', '');
    $('#modalPoster').attr('src', ''); // 포스터 초기화
  });

  
  
  
  
  
  

  // 영화 상영 시각
  const setMovie = (movieNo, movieNm) => {
    $('#movieNo').text(Number(movieNo));
    $('#movieTitle').text('제목: ' + movieNm);
    $('#movieTimeInput').val('');
    $('#movieTimeModal').modal('show'); // 모달 ID에 맞춰 수정
  }

  $('#manageRuntimeBtn').on('click', (event) => {
    $('#runtimeTable tbody').html('<tr><td colspan="5">로딩 중...</td></tr>');

    $.ajax({
      url: '/admin/getRuntimeList.do', 
      method: 'GET',
      success: (data) => {
        $('#runtimeTable tbody').empty();
        if (data && data.length > 0) {
          let tbody = '';
          $.each(data, (index, movie) => {
            tbody += '<tr>';
            tbody += '<td>' + movie.timeNo + '</td>';
            tbody += '<td>' + movie.movieDTO.movieNm + '</td>';
            tbody += '<td>' + movie.movieDTO.runtime + '</td>';
            tbody += '<td>' + movie.startTime + '</td>';
            tbody += '<td>' + '<button class="btn btn-primary btn-sm" onclick="setMovie(\'' + movie.movieDTO.movieNo + '\', \'' + movie.movieDTO.movieNm + '\')">시각 설정</button>' + '</td>';
            tbody += '</tr>';
          });
          $('#runtimeTable tbody').html(tbody);
        } else {
          $('#runtimeTable tbody').html('<tr><td colspan="5">영화 정보가 없습니다.</td></tr>');
        }
      },
      error: () => {
        $('#runtimeTable tbody').html('<tr><td colspan="5">로딩 실패</td></tr>');
      }
    });
  });



  
  
  
  
  
  

  
  
  
  
  const adminInsertTime = () => {
    if (confirm('등록하시겠습니까?')) {
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
    if (confirm('수정하시겠습니까?')) {
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
        success: (response) => {
      if(response.isSuccess) {        
        alert('수정이 완료되었습니다.');
        location.reload();
      } else {
        alert('수정이 실패했습니다.');
      }
        },
        error: (xhr, status, error) => {
          console.error('Error details: ', xhr.responseText);
          alert('수정에 실패했습니다. 다시 시도해주세요.');
        }
      });
    }
  };
  
  
</script>


<%@ include file="../admin/adminfooter.jsp" %>
