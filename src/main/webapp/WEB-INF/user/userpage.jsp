<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="userpage" name="title"/>
</jsp:include>
<style>
 .dead-btn{cursor: default; pointer-events: none;}
 .hidden-btn{display: none;}
 .sections.section_signup .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
 .sections.section_signup .width_con .signup form{ position: relative; transform: translateX(42%); transition: inherit;}
 .title_con h6{ margin-top: 0;}
  input { border-radius: 4px; margin-top: 2px; }
 .red{ border: 2px solid red;  border-radius: 5px;}
 .blogdiv{ 
    position: absolute;
    transform: translate(430px, -900px);}
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
						     
</style>
<!--
 가져와 표시할 것 들
    {
      등급표시
      포인트량
      내가 쓴 블로그
      내가 쓴 bbss
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
        <div>
          <button type="button" onclick="getUserTicket()">예매가져오기</button>
        </div><br>
<!-- 블로그 -->
        <div class="blogdiv">
	        <h5><b>내가 작성한 무비포스트</h5>
	        <div id="blog-list"></div><br>
	        <div id="paging"></div>
				</div>
<!-- 블로그 -->
	          
      </div>
	</div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->  


<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 
<script>

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
        let str  = '<div class="blog" data-blog-no="' + blog.blogNo + '" data-user-no="' + blog.userNo + '">';
            str +=   '<div> 제목 : ' + blog.title + '</div>';
            str +=   '<div class="hit"> Hit : ' + blog.hit + ' /Date : '  + blog.createDt + '</div>';
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