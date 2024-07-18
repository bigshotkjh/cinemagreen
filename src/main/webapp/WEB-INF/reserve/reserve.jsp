<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="예매" name="title"/>
</jsp:include>
<style>	
	dl, ol, ul {list-style:none; padding:0;}
	a{color:#111; text-decoration:none;}
	.width_con{padding: var(--mrgn-half); }
 .title{font-size:22px; font-weight:600;}
 .scroll_inner{overflow-y: scroll;}
 .sub_title{font-size:18px; font-weight:600; padding-bottom:15px;}
 h5.sub_title.line::after {content: ''; width: 100%; height: 1px; background: #ddd; display: block; margin-top: 15px;}
 .sort_tab a{padding: 2px 10px;}
 .sort_tab a.active{font-weight:600; background:#ddd; border-radius: 4px;}
 .list_head{width:100%;}
 .reserve_wrap .search{ width:270px; position:relative; float:right;}
 .reserve_wrap .search .search_btn{position: absolute; right: var(--mrgn-half); top: 50%; transform: translate(0%, -50%); color:#111;}
 .reserve_wrap .search .inp-mv{ width: 100%; height: 35px; border-radius: 38px; background: #f5f9fc; font-size: 13px; color: #111; border: 0;
    outline: none; padding: 0 65px 0 16px;}
  .movie_list {margin-top:var(--mrgn-half)}
 .date_list {width:200px;}
  .date_list .day_list{display: flex; flex-direction: column;  height: 420px;}
  .date_list .month.sub_title{ width: 95px; height: 40px;text-align: center; background: #eee; margin-bottom: 0; font-weight: 400;
  display: flex;
    justify-content: center;
    align-items: center;
    padding: 0; }
  button.mon { width:95px;  margin-top: 1px; padding: 5px; border :0;}
  button.mon.sat{color:#0072e2;}
  button.mon.sun{color:#e40202;}
  .movie-day{ margin-right:15px;}
  #movieList{height: 370px;}
  #movieList .movie {display:block; height:33px; display: flex; align-items: center;}
	#movieList .movie.active ,button.mon.active {background: #bbb; point-event:none;}
  .box_con{ width:33%; height:600px; background:#fff; vertical-align: top; display: inline-block; padding:15px;}
 .btn_del {display:none; color:#888; padding-right:5px;}
</style>
	<div class="width_con">
		<div class="reserve_wrap">
				<h5 class="title">예매</h5>
				<div class="box_con">
					<div class="list_head">
		        <h5 class="sub_title line">영화선택</h5>
		        <div class="search">
		            <input type="text" id="srchMovie" class="inp-mv" placeholder="영화명을 입력해주세요.">
		            <div class="search_btn">
			            <a href="javascript:void(0);" class="btn_del"><i class="fa-solid fa-x"></i></a>
			            <a href="#" class="btn-srch"><i class="fa-solid fa-magnifying-glass"></i></a>      
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
			            <ul id="movieList">
			            	<li><a class="movie active" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a>  </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            	<li><a class="movie" href="javascript:void(0)"><span>상영등급 </span> 영화제목</a> </li>
			            </ul>
			        </div>
			    </div>
					<!-- // 영화리스트 -->
				</div>
			<!-- 날짜 -->
			<div class="date_list box_con">
				<div class="list">
				<h5 class="sub_title line">날짜</h5>
					<div class="day_con">
              <div class="month sub_title"></div>
             	<div class="day_list scroll_inner">
             	</div>
           </div>	
					
						<ul id="playSdtList"></ul>
				</div>
			</div>
			<!-- // 날짜 -->
			
			<!-- 상영시간 -->
			<div class="time box_con">
			    <div class="list_head">
			        <h5 class="sub_title line">상영시간</h5>
			        <div class="types">
			        		<p>1관 / 2D ()</p>
			            <a href="javascript:void(0);" class="">
			            	<span class="time_txt" >17:30 ~ 17:06</span>
			            	<span  class="count_txt">60 / 60 </span>
			            </a>
			        </div>
			    </div>
			    <div class="list_body">
            <div id="timeList">
           		 <!-- 선택wjs -->
                <div class="none">
                    <div class="desc">영화, 날짜를<br>선택해주세요</div>
                </div>
            </div>
			        
			        <div class="info_box">
			           <div class="info">
			               <!-- 선택후 -->
			               <div class="img"></div>
			               <div class="text">
			                   <strong><span class="mvNm">&nbsp;</span></strong>
			                   <dl>
			                       <dt>상영관</dt>
			                       <dd class="scNm"></dd>
			                   </dl>
			                   <dl>
			                       <dt>상영등급</dt>
			                       <dd class="rtNm"></dd>
			                   </dl>
			                   <dl>
			                       <dt>날짜</dt>
			                       <dd class="plDt"></dd>
			                   </dl>
			                   <dl>
			                       <dt>상영시간</dt>
			                       <dd class="tiNm"></dd>
			                   </dl>
			               </div>
			           </div>
			           <div class="next">
			               <button type="button" id="btnNext">인원/좌석 선택</button>
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
	
	var movieList = $('#movieList a.movie');
	movieList.click(function(){
		movieList.removeClass('active');
		$(this).addClass('active');
	});
	
	var sort_t = $(".sort_tab > a");
	sort_t.click(function(){
		sort_t.removeClass('active');
		$(this).addClass('active');
	});
	
});


const dataDate = new Date();
let year = dataDate.getFullYear();
let month = dataDate.getMonth();
let dataDay = dataDate.getDay()
let date = dataDate.getDate();
let dayNumber = Number(date);
$('div.month').text(year+ "." + (Number(month)+1));

const reserveDate = $('div.day_list');

const weekDay = ["일", "월", "화", "수", "목", "금", "토"];
let thisWeek = [];
let button = "";
let spanWeekDay = "";
let spanDay = "";
let div = "";
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
		button.setAttribute('data-day',yyyy+mm+dd+d);
	} else if(d == '02'){
		d=weekDay[2];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy+mm+dd+d);
	} else if(d == '03'){
		d=weekDay[3];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy+mm+dd+d);
	} else if(d == '04'){
		d=weekDay[4];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy+mm+dd+d);
	} else if(d == '05'){
		d=weekDay[5];
		button.classList = "mon";
		button.setAttribute('data-day',yyyy+mm+dd+d);
	} else if(d == '06'){
		d=weekDay[6];
		button.classList ="mon sat";
		button.setAttribute('data-day',yyyy+mm+dd+d);
	} else if(d == '00'){
		d=weekDay[0];
		button.classList="mon sun";
		button.setAttribute('data-day',yyyy+mm+dd+d);
	}
	if(i===dayNumber){
		button.classList="mon active";
		//해당날짜는 버튼이 눌려있게 설정함
	}
	spanDay.innerHTML =  d;
	button.append(spanDay);
	reserveDate.append(button);
	
	
	thisWeek[i] = yyyy + "-" + mm +'-' +dd +'-'+d ;
}
	
$('.day_list .mon').click(function(){
		$('.day_list .mon').removeClass('active');
		$(this).addClass('active');
})

		
		
</script>
<%@ include file="../layout/footer.jsp" %>
