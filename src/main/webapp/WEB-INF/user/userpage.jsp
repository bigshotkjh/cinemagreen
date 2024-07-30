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
  input { border-radius: 4px; margin-top: 2px;}
 .red{ border: 2px solid red;}
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
        <form id="user-info-form"
              method="post"
              action="${contextPath}/user/updateInf.do">
          <div>
            <h5>이메일</h5>
            <input type="text" name="email" id="email" value="${loginUser.email}" disabled>
            <h6></h6>
          </div>
          <div>
            <h5>이름</h5>
            <input type="text" name="name" id="name" value="${loginUser.name}">
          </div>
          <div>
            <h5>휴대폰번호</h5>
            <input type="text" name="mobile" id="mobile" value="${loginUser.mobile}">
            <h6></h6>
          </div>
          <div>
            <h5>생년월일</h5>
            <input type="text" name="birthYear" id="birth_year" value="${loginUser.birthYear}">
            <h6></h6>
          </div>
          
          <div>
            <h5>주소</h5>
            <input type="button" onclick="execDaumPostcode(), fnMobileCheck(), fnAllCheck()" value="우편번호 찾기"><br>
            <input type="text" id="postcode" name="postcode" value="${loginUser.postcode}"><br>
            <input type="text" id="address" name="address" value="${loginUser.address}"><br>
            <input type="text" id="extraAddress" name="extraAddress" value="${loginUser.extraAddress}"><br>
            <input type="text" id="detailAddress" name="detailAddress" value="${loginUser.detailAddress}"> 
          </div>
          <br>
       
          <div>
            <button type="submit"  class="submit dead-btn" >개인정보 변경하기</button>
          </div>
              
        </form><br>
       
          <div>
            <button type="button" class="pw-button" onclick="location.href = '${contextPath}/user/pwchange.page'">비밀번호변경</button>
          </div><br>
       
          <div>
            <button type="button" onclick="leaveUser()">탈퇴하기</button>
          </div><br>
       
          <div>
            <button type="button" onclick="getBlogList()">내가 쓴 blog</button>
          </div>
<!-- 블로그 -->
          <div id="paging"></div>
          <div id="blog-list"></div>
<!-- 블로그 -->
          
    </div>
  </div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->  


<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 
<script>
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
      alert("done도착");
      const blogList = document.getElementById('blog-list');
      const paging = document.getElementById('paging');
      if(resData.blogList.length === 0){
        alert("블로그없는거 도착");
        blogList.innerHTML = '<div>등록된 블로그가 없습니다.</div>';
        paging.innerHTML = '';
        return;
      }
      alert("블로그는 있어.");
      paging.innerHTML = resData.paging;
      blogList.innerHTML = '';
      for(const blog of resData.blogList){
        let str = '<div class="blog" data-blog-no="' + blog.blogNo + '" data-user-no="' + blog.userNo + '">';
        str += '<div>' + blog.name + '</div>';
        str += '<div>' + blog.title + '</div>';
        str += '<div>' + blog.hit + '</div>';
        str += '<div>' + blog.createDt + '</div>';
        str += '</div>';
        blogList.innerHTML += str;
      }
    })
    /*alert("done실패?");*/
  }
  
  getBlogList();

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
  

/* 헤더에 이름 안바뀌는 사유로 봉인.
//ajax
  const fnUpdateInf = () => {
    $.ajax({
      type: 'post',
      url: '${contextPath}/user/updateInf.do',
      data: $('#user-info-form').serialize(),
      dataType: 'json'
    }).done(resData => {
      if (resData.isSuccess) {
        alert('정보 변경 성공');
      } else {
        alert('정보 등록 실패');
      }
    }).fail(jqXHR => {
      alert(jqXHR.status);
    });
  }
  
  $('#submitbtn').on('click', evt=>{
    fnUpdateInf();
  })
  */
  
//탈퇴
  const leaveUser = () => {
    // 회원 탈퇴 확인 메시지 표시
    if (confirm("정말 회원 탈퇴를 하시겠습니까?")) {
      // 회원 탈퇴 처리 URL로 이동
     location.href = "${contextPath}/user/leave.do";
    }
  };
  
//////////////////////////////////////////////////////////////////////  
  
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