<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="예매" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${contextPath}/static/css/reserve.css">

	<div class="width_con">
		<div class="reserve_wrap">
				<h5 class="title">영화예매</h5>
				<div class="box_con">
					<div class="list_head">
		        <h5 class="sub_title line">영화선택</h5>
		        <div class="search">
		            <input type="text" id="srchMovie" class="inp-mv" placeholder="영화명을 입력해주세요.">
		            <div class="search_btn">
			            <a href="javascript:void(0);" class="btn_del"><i class="fa-solid fa-x"></i></a>
			            <a href="javascript:search();" class="btn-srch"><i class="fa-solid fa-magnifying-glass"></i></a>      
		            </div>
						</div>
						<div class="sort_tab">
							<a href="#" class="btnMovieType active">전체</a>
						  <a href="#" class="btnMovieTab">예매율 순</a>
						</div>
					</div>
					<!-- 영화리스트 -->
			    <div class="movie_list">
 			        <div class="scroll_inner">
			            <ul id="movieList" class="">
			            	<c:choose>
				              <c:when test="${empty movieReserveList}">
				                  <li>영화가 존재하지 않습니다.</li>
				              </c:when>
				              <c:otherwise>
				                <c:forEach var="movie" items="${movieReserveList}"> 
						            	<li><a class="movie" href="javascript:void(0);" data-movieno ="${movie.movieNo}" data-rating ="${movie.rating}"><span style="width:100px;color:#888;">${movie.rating}</span> ${movie.movieNm}</a></li>
						            	</c:forEach>
											</c:otherwise>
				           	 </c:choose>
			            </ul>
			        </div>
			    </div>
					<!-- // 영화리스트 -->
				</div>
			<!-- 날짜 -->
			<div class="date_list box_con">
				<div class="list">
				<h5 class="sub_title line">날짜</h5>
					<div class="day_con -active">
              <div class="month sub_title"></div>
             	<div class="day_list scroll_inner">
             	
             	</div>
           </div>
           <div class="none">
             <div class="desc">영화를 선택해주세요</div>
           </div>
				</div>
			</div>
			<!-- // 날짜 -->
			
			<!-- 상영시간 -->
			<div class="time_list box_con">
			    <div class="list_head">
						<h5 class="sub_title line">상영시간</h5> <!-- 년월일시분 -->
				    </div>
			    <div class="list_body">
            <div id="timeList">
           		 <!-- 선택전  -->
                <div class="none">
                    <div class="desc">날짜를 선택해주세요.</div>
                </div>
                 

                <ul class="types -active">
                <%-- <li>
	                 <c:choose>
									    <c:when test="${empty runtime}">
									   		<div class="">해당 일자에 상영 시간표가 없습니다.</div>
									    </c:when>
									    <c:otherwise>
										    <c:forEach var="runtime" items="${runtimeList}"> 
										    	<a href="javascript:void(0);" class="time">
							            	<span class="time_txt">${runtime.startTime}</span>
							            	<!-- <span class="count_txt">20 / 20 </span> -->
							            </a> 
						            </c:forEach>
									    </c:otherwise>
									</c:choose> 
								</li> --%>
							</ul>
							
            </div>
			        <div class="modal_bg"></div>
			        <div id="reserve_modal" class="info_box">
			           <div class="info">
			               <!-- 선택후 -->
			               <div class="img"></div>
			               <div class="txt_notice">
			                   <strong><span class="mvNm">&nbsp;</span></strong>
			                   <p> 본 영화는 "<span id="modalRating"> </span>" 영화입니다.</p>
			               </div>
			           </div>
			           <div class="next">
			           		 <button onclick="modalDel()" id="btnDel" class="c-btn c-gray">취소</button>
			               <button type="button" id="btnNext" class="c-btn c-cblue">인원/좌석 선택</button>
			           </div>
			       </div>
			   </div>
			</div>
			
		</div>
	</div>
	
<script>

$(function() {

	$("#srchMovie").on("keyup", function(e) {
		var txt = $(this).val().trim();
		if (txt == "") {
			$(".btn_del").hide();
		} else {
			$(".btn_del").show();
		}
	});
	
	$(".btn_del").on("click", function() {
		$("#srchMovie").val("").keyup();
	});
	
	
	$('.none').css('display','block');
	var movieList = $('#movieList a.movie');
	movieList.click(function(){
		movieList.removeClass('active');
		$('.day_list .mon').removeClass('active');
		$('#timeList .none').css('display','block');
		
		$(this).addClass('active');
		$('.-active').css('display','block');
		$('.types.-active').css('display','none');
		$('.date_list .none').css('display','none');
	});
	

	var sort_t = $(".sort_tab > a");
	sort_t.click(function(){
		sort_t.removeClass('active');
		$(this).addClass('active');
	});
	
	$(".time_list .types .time").on('click',function(){
		$(".modal_bg").addClass('open');
		$("#reserve_modal").addClass('open');
	})
});
	
//모달open
function openModal(rating,movieNo,timeNo){
	$(".modal_bg").addClass('open');
	$("#reserve_modal").addClass('open');
	console.log(movieNo);
	 document.getElementById('modalRating').innerText = rating;
	 $("#btnNext").attr('onclick','location.href="${contextPath}/reserve/seat.do?movieNo='+ selectedMovieNo + '&timeNo=' + timeNo + '"');
}

//모달close
function modalDel() {
	$(".modal_bg").removeClass('open');
	$("#reserve_modal").removeClass('open');
}

const dataDate = new Date();
let year = dataDate.getFullYear();
let month = dataDate.getMonth();
let dataDay = dataDate.getDay()
let date = dataDate.getDate();
let dayNumber = Number(date);
$('div.month').text(year+ "." + (Number(month)+1));

const reserveDate = $('.day_list');

const weekDay = ["일", "월", "화", "수", "목", "금", "토"];
let button = "";
let spanWeekDay = "";
let spanDay = "";
let div = "";
let selectedDate = "";

for(let i = dayNumber ; i<=dayNumber+13 ; i++) {
	
	div = document.createElement("div");
	button = document.createElement("button");
	spanWeekMonth = document.createElement("span");
	spanWeekDay = document.createElement("span");
	spanDay = document.createElement("strong");
	spanWeekMonth.classList="movie-week-month";
	spanWeekDay.classList = 'movie-day';
	spanDay.classList ='movie-week-day';
	let resultDay = new Date(year, month, i);
	let yyyy = resultDay.getFullYear();
	let mm = Number(resultDay.getMonth())+1;
	let dd = resultDay.getDate();
	let d = resultDay.getDay();
	
	mm = String(mm).length === 1 ? '0'+mm : mm;
	dd = String(dd).length === 1 ? '0'+dd : dd;
	d = String(d).length === 1 ? '0'+d : d;
	spanWeekMonth.innerHTML = mm;
	spanWeekDay.innerHTML = dd;
	
	button.append(spanWeekDay);
	if(d == '01'){
		d=weekDay[1];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy + '-' + mm + '-' + dd);
	} else if(d == '02'){
		d=weekDay[2];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy + '-' + mm + '-' + dd);
	} else if(d == '03'){
		d=weekDay[3];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy + '-' + mm + '-' + dd);
	} else if(d == '04'){
		d=weekDay[4];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy + '-' + mm + '-' + dd);
	} else if(d == '05'){
		d=weekDay[5];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy + '-' + mm + '-' + dd);
	} else if(d == '06'){
		d=weekDay[6];
		button.classList ="mon sat";
		button.setAttribute('data-day',yyyy + '-' + mm + '-' + dd);
	} else if(d == '00'){
		d=weekDay[0];
		button.classList="mon sun";
		button.setAttribute('data-day',yyyy + '-' + mm + '-' + dd);
	}
	
	if(i===dayNumber){
		button.classList="mon today";
		//해당날짜는 표시
	}
	
	spanDay.innerHTML =  d;
	button.append(spanDay);
	reserveDate.append(button);

}

	//검색
	function search(){
		let search = $('#srchMovie').val();
		console.log(search);
		if (search.length > 0) {
			$.ajax({
				 type: "GET",
		     url : "/reserve/movieSearch.do",
		     data : {
		         "search":search
		     },
		     dataType: "json",
		     success:function(resdata) {
           showList(resdata);
         },
		     errer : function (e) {
         	alert(e);
		     }
			});
		}else {
        // 검색어가 없으면 기본 영화 목록을 보여주기
        $('#movieList').empty();
    }
	}	
	function showList(movies) {
	    let movieList = $('#movieList');
	    movieList.empty();  // 기존 리스트 초기화

	    if (movies.length === 0) {
	        movieList.append('<li>영화가 존재하지 않습니다.</li>');
	    } else {
	        movies.forEach(movie => {
	            let movieItem = `<li><a class="movie" href="javascript:void(0);" data-movieno ="${movie.movieNo}" data-rating ="${movie.rating}"><span style="width:100px;color:#888;">${movie.rating}</span> ${movie.movieNm}</a></li>`;
	            movieList.append(movieItem);
	        });
	    }
	}

//날짜선택 
$('.day_list .mon').click(function(){
	$('#timeList .none').css('display','none');
	$('.-active').css('display','block');
	
	selectedDate = this.getAttribute('data-day');
  console.log("Selected Date:", selectedDate);
	$('.day_list .mon').removeClass('active');
  $(this).addClass('active')
  
  const activeMovie = document.querySelector('.movie.active');
	 
  selectedMovieNo = activeMovie.getAttribute('data-movieno'); //movieno가지고오기
  selectedRating = activeMovie.getAttribute('data-rating'); //rating가지고오기

  console.log(selectedMovieNo, selectedRating);
  $.ajax({
    type: "GET",
    data: { 
    	"movieNo": selectedMovieNo,
    	"rating": selectedRating
    	}, 
    url: "/reserve/getRuntime.do?movieNo=" + selectedMovieNo + "&selectedDate="+selectedDate, 
    dataType: 'json'
  }).done(resData => {
   	let timeList = $('#timeList .types');
     	timeList.empty();  
       if (resData.length === 0) {
       	timeList.append('<div class="desc">해당 일자에 상영 시간표가 없습니다.</div>');
       }else{  
      	resData.forEach(runtime => {
         	let time = '<li>';
           	time += '<a href="javascript:openModal(\'' + selectedRating +'\',\'' + selectedMovieNo +'\',\'' + runtime.timeNo +'\');" class="time">';
           	time += '<span class="time_txt">' + runtime.startTime + '</span>';
           	time += '</a>';
           	time += '</li>';
         timeList.append(time);
         });
       }
  	})
    .fail(jqXHR => {
       alert(jqXHR.responseText);
       console.log(jqXHR.responseText);
         })
  
})
</script>
<script>
    /*  영화선택 -> 날짜선택으로 수정중 
    function selectMovie(movieNo, rating, selectedDate) {
        $.ajax({
          url: "/reserve/getRuntime.do?movieNo=" + movieNo + "&selectedDate="+selectedDate, 
          type: "GET",
          dataType: 'json'
        }).done(resData => {
         	let timeList = $('#timeList .types');
           	timeList.empty();  
             if (resData.length === 0) {
             	timeList.append('<div class="desc">해당 일자에 상영 시간표가 없습니다.</div>');
             }else{  
            	resData.forEach(runtime => {
               	let time = '<li>';
                 	time += '<a href="javascript:openModal(\'' + rating +'\',\'' + movieNo +'\',\'' + runtime.timeNo +'\');" class="time">';
                 	time += '<span class="time_txt">' + runtime.startTime + '</span>';
                 	time += '</a>';
                 	time += '</li>';
               timeList.append(time);
               });
             }
        	})
          .fail(jqXHR => {
             alert(jqXHR.responseText);
             console.log(jqXHR.responseText);
	           })
   			 } */
    </script>
<%@ include file="../layout/footer.jsp" %>
