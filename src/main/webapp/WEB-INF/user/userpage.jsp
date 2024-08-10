<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="userpage" name="title"/>
</jsp:include>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<style>
 .dead-btn{cursor: default; pointer-events: none;}
 .hidden-btn{display: none;}
 .sections.section_signup .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
 .sections.section_signup .width_con .signup form{ position: relative; transform: translateX(42%); transition: inherit;}
 .title_con h6{ margin-top: 0;}
  input { border-radius: 4px; margin-top: 2px; }
 .red{ border: 2px solid red;  border-radius: 5px;}
 .blog-div{ 
    position: absolute;
    transform: translate(430px, -950px);}
 .blog{ border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 600px; margin: 3px 0px;}
 .blog-zero{ border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 600px; margin: 3px 0px;  white-space: pre;}
 #profile-img{ border-radius: 20%;}
 .title_con{ width: 400px; position: relative; transform: translate(200px, -150px);}
 .hit{ text-align: right;}
 .profile-div{ border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 200px;  position: absolute; transform: translate(80px, -73px); overflow: hidden;}
	#profile, #profile-upload{margin: 3px;}
	#user-info-form{ border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 280px;}
	.paging { position: relative; transform: translate(260px, 0px);}
	h5{margin: 10px 10px 10px 0px; }
	.user-info{position: relative; transform: translate(37px, -10px);}
  .ticket-div{ 
    position: relative;
    transform: translate(430px, -550px);}
  .ticket{  border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 600px; margin: 3px 0px; }
  .movie-time{ text-align: right;}	
  .ticket-zero{ border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 600px; margin: 3px 0px;  white-space: pre;}
  .button:hover{background-color: #FFFFFF; border: 2px solid  #ABDEC2;}				     
  .modal-backdrop.show{ display: none !important; }
  .modal-content{ top: 150px; right: -70px; width: 350px; border: 10px solid  #ABDEC2;}
  .width_con {height: 1100px;}
  .refund{ border: 2px solid  #ABDEC2; transform: translate(-170px, 0px);}
  .gray{ background-color: #E2E2E2; }
</style>
<!--
 가져와 표시할 것 들
    {
      등급표시
      포인트량
      내가 쓴 블로그
      예매한 영화 정보
    }
 -->

<!-- @@@@@@@@@@@@@@@@@@@@@@@ -->


<div class="wrap">
  <div class="sections section_userpage">
    <div class="width_con">
      <div class="title_con white userpage">
        <h4 class="title">User Page</h4><br>
        
       <!--프로필 변경 --> 
        <h5><b>프로필 변경하기</h5>
        
        <img id="profile-img" src=" ${loginUser.profilePath}/${loginUser.profileName}" width="73" height="73">
        <form id="profile-form">
          <div class="profile-div">
            <input type="file" name="file" id="profile" accept="image/*">
            <button type="button" id="profile-upload" >프로필변경</button>
          </div><br>
        </form>
        <h5><b>개인정보 변경</b></h5>
        <form id="user-info-form"
              method="post"
              action="${contextPath}/user/updateInf.do">  
          <div class="user-info">
            <h5>이메일</h5>
            <input type="text" name="email" id="email" value="${loginUser.email}" disabled>
            <h6></h6>
		        <h5>회원등급</h5>
		        <input type="text" value="${loginUser.grade}" disabled>
		        <h6></h6>
          </div>
          <div class="user-info">
            <h5>이름</h5>
            <input type="text" name="name" id="name" value="${loginUser.name}">
          </div>
          <div class="user-info">
            <h5>휴대폰번호</h5>
            <input type="text" name="mobile" id="mobile" value="${loginUser.mobile}">
            <h6></h6>
          </div>
          <div class="user-info">
            <h5>생년월일</h5>
            <input type="text" name="birthYear" id="birth_year" value="${loginUser.birthYear}">
            <h6></h6>
          </div>
          <div class="user-info">
            <h5>주소</h5>
            <input type="button" onclick="execDaumPostcode(), fnMobileCheck(), fnAllCheck()" value="우편번호 찾기"><br>
            <input type="text" id="postcode" name="postcode" value="${loginUser.postcode}"><br>
            <input type="text" id="address" name="address" value="${loginUser.address}"><br>
            <input type="text" id="extraAddress" name="extraAddress" value="${loginUser.extraAddress}"><br>
            <input type="text" id="detailAddress" name="detailAddress" value="${loginUser.detailAddress}"> 
          </div>
          <br>
          <div class="user-info">
            <button type="submit"  class="submit dead-btn" >개인정보 변경하기</button>
          </div>
          <div></div>
              
        </form><br>
        <div>
          <button type="button" class="pw-button" onclick="location.href = '${contextPath}/user/pwchange.page'">비밀번호변경</button>
        </div><br>
        <div>
          <button type="button" onclick="leaveUser()">탈퇴하기</button>
        </div><br>
<!-- 블로그 -->
        <div class="blog-div">
	        <h5><b>내가 작성한 무비포스트</h5>
	        <div id="blog-list"></div><br>
	        <div id="paging"></div>
				</div>
<!-- 블로그 -->
        <div class="ticket-div">
          <h5><b>예매 내역</h5>
          <div id="ticket-list"></div>  
          <div id="ticket-paging"></div>
        </div>  
      </div>
  <!-- 모달을 실행할 버튼 -->
		  
		  <!-- 모달 -->
		  <div class="modal fade" id="ticket-etail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <h1 class="modal-title fs-5" id="exampleModalLabel">예매 상세 내역</h1>
		          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		        </div>
		        <div class="modal-body" id="modal-body">
		          ...
		        </div>
		        <div class="modal-footer">
              <button type="button" class="btn refund" onclick="refund()">예매취소</button>
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        </div>
		      </div>
		    </div>
		  </div>
	</div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->  


<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 
<script>
//예매취소
  const refund = ()=>{
	  
	  var ticketInfElement = document.getElementById('ticket-inf');

	  var movieNm = ticketInfElement.dataset.movieNm;
	  var seatCode = ticketInfElement.dataset.seatCode;
	  var startTime = ticketInfElement.dataset.startTime;
	  
    $.ajax({
      type: 'get',
      url: '${contextPath}/user/ticketrefund.do',
      data: {
          'movieNm': movieNm,
          'seatCode': seatCode,
          'startTime' : startTime
      },
      dataType: 'json'
    }).done(resData => {  
      alert(resData.resultMessage);
    }).fail(jqXHR => {
      alert(jqXHR.status);
    });
  }

//프로필 변경
  const profileUpload = (file)=> {  // file: 추가한 이미지 (단일 파일)
  
    if (file == null) {
        alert("파일을 선택해주세요.");
        return;
    }
  
    // FormData 객체 생성
    let formData = new FormData();  // <form>
    
    // FormData 객체에 이미지 저장하기
    formData.append('file', file);   // <input name="file" type="file">

    $.ajax({
      // FormData 객체를 서버로 보내기 (이미지를 서버로 보내기)
      type: 'post',
      url: '${contextPath}/user/profileUpload.do',
      data: formData,
      contentType: false,  // Content-Type 헤더 값 생성 방지
      processData: false,  // 객체를 보내는 경우 해당 객체를 {property: value} 형식의 문자열로 자동으로 변환해서 보내는 것을 방지
      dataType: 'json'
    }).done(resData => {  // resData == {url: '/경로/파일명'}
   	  $('#profile-img').attr('src', resData.url);
    }).fail(jqXHR => {
      alert("실패");
      alert(jqXHR.status);
    });
  }
  
  $('#profile-upload').on('click', evt => {
    const fileInput = document.getElementById('profile');
    const files = fileInput.files; // 선택된 파일 목록 가져오기

    if (files.length == 1) { // 파일이 하나만 선택되었는지 확인
      profileUpload(files[0]); // 첫 번째 파일 업로드
    } else {
      alert("변경을 원하시는 프로필 파일을 선택해주세요.");
    }
  });
//블로그 가져오기

  var page = 1;
  
  const paging = (p)=>{
    page = p;
    getBlogList();
  }
  
  const getBlogList = ()=>{   
    $.ajax({
      type: 'get',
      url: '${contextPath}/user/getUserBloglist.do',
      data: 'page=' + page,
      dataType: 'json'
    }).done(resData=>{  // {"blogList": [{}, {}, ...], "paging": "< 1 2 3 4 5 6 7 8 9 10 >"} 
      const blogList = document.getElementById('blog-list');
      const paging = document.getElementById('paging');
      if(resData.blogList.length === 0){
    	  let str = '<div class="blog-zero"> 작성하신 무비 포스트가 없습니다.      |      관람하신 영화의 무비 포스트를 작성해 보세요</div>';
           str += '<button type="button" onclick="blogWrite()">무비포스트 작성하기</button>';
        blogList.innerHTML += str;
        paging.innerHTML = '';
        return;
      }
      paging.innerHTML = resData.paging;
      blogList.innerHTML = '';
      for(const blog of resData.blogList){
        let str  = '<div class="blog button" data-blog-no="' + blog.blogNo + '" data-user-no="' + blog.userNo + '">';
            str +=   '<div><strong> 제목 : </strong>' + blog.title + '</div>';
            str +=   '<div class="hit"><strong>Hit : </strong>' + blog.hit + ' /<strong>Date : </strong>'  + blog.createDt + '</div>';
            str += '</div>';
        blogList.innerHTML += str;
      }
    })
  }
  getBlogList();

  
  const detail = ()=>{
    $(document).on('click', '.blog', evt=>{

        if (confirm("작성한 무비포스트로 이동 하시겠습니까?")) {
            if('${sessionScope.loginUser.userNo}' == evt.currentTarget.dataset.userNo){
                location.href = '${contextPath}/blog/detail.do?blogNo=' + evt.currentTarget.dataset.blogNo;
              } else {
                location.href = '${contextPath}/blog/updateHit.do?blogNo=' + evt.currentTarget.dataset.blogNo;
              }
        }
    })
  }
  detail();
  
//////////////////////////////////////////  
//예매내역
  

  var ticketPage = 1;
  
  const ticketPaging = (p)=>{
	  ticketPage = p;
	  fnMovieTicket();
  }
  const fnMovieTicket = ()=>{   
    $.ajax({
      type: 'get',
      url: '${contextPath}/user/getuserticket.do',
      data: 'page=' + ticketPage,
      dataType: 'json'
    }).done(resData=>{   
      const ticketList = document.getElementById('ticket-list');
      const ticketPaging = document.getElementById('ticket-paging');
      if(resData.ticketList.length === 0){
   	   ticketList.innerHTML = '<div class="ticket-zero"> 예매 내역이 없습니다.    |    AI챗봇에게 영화를 추천받아 보세요.</div>';
        return;
      }
      ticketPaging.innerHTML = resData.ticketPaging;
      ticketList.innerHTML = '';
      for(const ticket of resData.ticketList){
	    	// 문자열을 Date 객체로 변환
	    	const ticketTime = new Date(ticket.startTime);
	    	// 현재 날짜와 시간 가져오기
	    	const currentDate = new Date();
	    	// 날짜 비교
	    	if (currentDate <= ticketTime) {
	    		
	            let str  = '<div class="ticket button" data-bs-toggle="modal" data-bs-target="#ticket-etail" data-movie-nm="'+ ticket.movieNm +'" data-seat-code="' + ticket.seatCode + '" data-start-time="' + ticket.startTime + '">';
	                str +=   '<div> <strong>제목 :</strong> ' + ticket.movieNm + '</div>';
	                str +=   '<div class=movie-time> <strong>상영시간</strong> : ' + ticket.startTime + ' / <strong>좌석 :</strong> '  + ticket.seatCode + '</div>';
	                str += '</div>';
	            ticketList.innerHTML += str;
	    	}  else {
	    	      
	            let str  = '<div class="ticket button gray" data-bs-toggle="modal" data-bs-target="#ticket-etail" data-movie-nm="'+ ticket.movieNm +'" data-seat-code="' + ticket.seatCode + '" data-start-time="' + ticket.startTime + '">';
	                str +=   '<div> <strong>제목 :</strong> ' + ticket.movieNm + ' | <strong>상영 완료</strong></div>';
	                str +=   '<div class=movie-time> <strong>상영시간</strong> : ' + ticket.startTime + ' / <strong>좌석 :</strong> '  + ticket.seatCode + '</div>';
	                str += '</div>';
	            ticketList.innerHTML += str;
	    	}
      }
    })
  }
  fnMovieTicket();

//티켓디테일///////////// 
  const ticketDetail = ()=>{
	  
    $(document).on('click', '.ticket', evt=>{
	     var movieNm = evt.currentTarget.dataset.movieNm,
	         seatCode = evt.currentTarget.dataset.seatCode,
	         startTime = evt.currentTarget.dataset.startTime;
	     $.ajax({
         type: 'get',
         url: '${contextPath}/user/ticketdetail.do',
         data: {
             'movieNm': movieNm,
             'seatCode': seatCode,
             'startTime' : startTime
         },
         dataType: 'json'
       }).done(ticketInf => {  
    	   const modalBody = document.getElementById('modal-body');
           modalBody.innerHTML = '';
           let str  = '<div id="ticket-inf" data-movie-nm="'+ ticketInf.movieNm +'" data-seat-code="' + ticketInf.seatCode + '" data-start-time="' + ticketInf.startTime + '">';
               str += '<div><strong>제목</strong> : ' + ticketInf.movieNm + '</div>';
		           str += '<div><strong>상영시간</strong> : ' + ticketInf.startTime + ' / <strong>좌석</strong> : '  + ticketInf.seatCode + '</div>';
	             str += '<hr>';
               str += '<div><strong>러닝타임</strong> : ' + ticketInf.runtime + ' / <strong>관람등급</strong> : '  + ticketInf.rating + '</div>';
               str += '<div><strong>예매일</strong> : ' + ticketInf.ticketDt + ' / <strong>관람인원</strong> : '  + ticketInf.personCount + '</div>';
               str += '<hr>';
               str += '<div><strong>결제수단</strong> : ' + ticketInf.payMethod + ' / <strong>결제금액</strong> : '  + ticketInf.amount + '</div>';
               str += '<div><strong>결제상태</strong> : ' + ticketInf.payState + '</div>';
               str += '<div><strong>결제취소일자</strong> : ' + ticketInf.cancelDt + ' / <strong>결제취소상태</strong> : '  + ticketInf.cancelStatus + '</div>';
               str += '</div>';
            modalBody.innerHTML += str;
           
       
       })
    })
  }
  ticketDetail();
//sns로그인유저 비밀번호변경 버튼 숨기기
  const fnSnsPwNone = ()=>{
    
   if("${loginUser.sns}" == 1){
      $(".pw-button").addClass("hidden-btn");
    }
  }
  
//카카오 주소 API
  function execDaumPostcode() {
      new daum.Postcode({
          oncomplete: function(data) {
              var addr = ''; 
              var extraAddr = ''; 
              if (data.userSelectedType === 'R') {
                  addr = data.roadAddress;
              } else { 
                  addr = data.jibunAddress;
              }
              if(data.userSelectedType === 'R'){
                  if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                      extraAddr += data.bname;
                  }
                  if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                  }
                  if(extraAddr !== ''){
                      extraAddr = ' (' + extraAddr + ')';
                  }
                  document.getElementById("extraAddress").value = extraAddr;
              } else {
                  document.getElementById("extraAddress").value = '';
              }
              document.getElementById('postcode').value = data.zonecode;
              document.getElementById("address").value = addr;
              document.getElementById("detailAddress").focus();
          }
      }).open();
  }

//mobile 정규식 검사
  var mobileCheck = true,
      birthCheck = true;
  

  const fnMobileCheck = ()=>{
    
    const mobile = document.getElementById('mobile');
    var regMobile = /^010(-{0,1}[0-9]{4}){2}$/;
    if(regMobile.test(mobile.value)){
      $("#mobile").next("h6").html('' );
      mobileCheck = true;
    } else {
      $("#mobile").next("h6").html('010을 포함한 11자리 숫자로 입력해 주세요' );
      mobileCheck = false;
    }
  }
  $(document).on("keyup","#mobile", evt=>{
    fnMobileCheck();
  })
//생년월일 입력 검사
  
  const fnBirthCheck = ()=>{
    
    const birthYear = document.getElementById('birth_year');
    var regbirthYear = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
    if(regbirthYear.test(birthYear.value)){
      $("#birth_year").next("h6").html('생년월일 확인되었습니다.' );
      birthCheck = true;
    } else {
      $("#birth_year").next("h6").html('생년월일 8자리를 입력해 주세요 ex)20000101');
      birthCheck = false;
    }
  }
  
  $(document).on("keyup","#birth_year", evt=>{
    fnBirthCheck();
  })
  
  
  const fnAllCheck = ()=>{
    if(mobileCheck == true && birthCheck == true){
        $(".submit").removeClass("dead-btn");
    }else{
        $(".submit").addClass("dead-btn");
    }
    if(mobileCheck == false){
      $("#mobile").addClass("red");
    } else {
      $("#mobile").removeClass("red");
    }
    if(birthCheck == false){
      $("#birth_year").addClass("red");
    } else {
      $("#birth_year").removeClass("red");
    }
  }
  
  $(document).on("keyup", "#mobile, #name, #birth_year, #postcode, #address, #detailAddress, #extraAddress", evt=>{
    fnAllCheck();
  });
  
  
  window.onload = ()=>{
    fnSnsPwNone();
    fnMobileCheck();
    fnBirthCheck();
    fnAllCheck();
  } 
  
//예매

  const getUserTicket = ()=>{
    location.href = "${contextPath}/user/getuserticket.do";
  }
  
//블로그 쓰기 이동

  const blogWrite = ()=>{
    location.href = "${contextPath}/blog/write.page";
  }
//탈퇴
  const leaveUser = () => {
    // 회원 탈퇴 확인 메시지 표시
    if (confirm("정말 회원 탈퇴를 하시겠습니까?")) {
      // 회원 탈퇴 처리 URL로 이동
     location.href = "${contextPath}/user/leave.do";
    }
  };
  
//비밀번호변경 메세지
  if('${pwchangeMessage}' !== ''){
    alert('${pwchangeMessage}');
  }

//업데이트 결과 메세지.
  if('${updateMessage}' !== ''){   
    alert('${updateMessage}');
  } 

</script>

<%@ include file="../layout/footer.jsp" %>