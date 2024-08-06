<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="Movie Postlist" name="title"/>
</jsp:include>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style>
  .sections.section_signin .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
  .sections.section_signin .width_con .signin form{ position: relative; transform: translateX(42%); transition: inherit;}
  .title_con h6{ margin-top: 0;}
  input { border-radius: 4px;}
  .blog {
    width: 500px;
    cursor: pointer;
    background-color: beige;
    border-bottom: 1px solid gray;
    margin-bottom: 10px;
  }position: relative; transform: translate(0px, -150px);
  .blog{ position: relative; transform: translate(0px, 0px);}
  .paging { position: relative; transform: translate(-360px, 20px);}
  button{position: relative; transform: translate(1000px, -20px);}
  #blog-list {border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 510px; position: relative; transform: translate(420px, 0px);}
  .right {text-align: right;}
  .aaa {position: relative; transform: translate(0px, -150px);}
</style>


<div class="wrap">
  <div class="sections section_signin">
    <div class="width_con">
      <div class ="aaa">
        <div class="title_con white signin">
          <h4 class="title">Movie Postlist</h4><br>
					<div>
					  <button type="button" onclick="blogWrite()">무비포스트 작성하기</button>
					</div>
					<div id="blog-list"></div>
          <div id="paging"></div>
        </div>
      </div>
    </div>
  </div>

<script>

  if('${saveBlogMessage}' !== '')
    alert('${saveBlogMessage}');

  var page = 1;
  
  const paging = (p)=>{
    page = p;
    getBlogList();
  }
  
  const getBlogList = ()=>{    
    $.ajax({
      type: 'get',
      url: '${contextPath}/blog/getBlogList.do',
      data: 'page=' + page,
      dataType: 'json'
    }).done(resData=>{  // {"blogList": [{}, {}, ...], "paging": "< 1 2 3 4 5 6 7 8 9 10 >"}
      const blogList = document.getElementById('blog-list');
      const paging = document.getElementById('paging');
      if(resData.blogList.length === 0){
        blogList.innerHTML = '<div>등록된 블로그가 없습니다.</div>';
        paging.innerHTML = '';
        return;
      }
      paging.innerHTML = resData.paging;
      blogList.innerHTML = '';
      for(const blog of resData.blogList){
        let str = '<div class="blog" data-blog-no="' + blog.blogNo + '" data-user-no="' + blog.userNo + '">';
        str += '<div>제목 : ' + blog.title + '</div>';
        str += '<div class="right">작성자 : ' + blog.name + ' /조회수 : ' + blog.hit + ' /작성일 : ' + blog.createDt + '</div>';
        str += '</div>';
        blogList.innerHTML += str;
      }
    })
  }
  
  const detail = ()=>{
    $(document).on('click', '.blog', evt=>{
      if('${sessionScope.loginUser.userNo}' == evt.currentTarget.dataset.userNo){
        location.href = '${contextPath}/blog/detail.do?blogNo=' + evt.currentTarget.dataset.blogNo;
      } else {
        location.href = '${contextPath}/blog/updateHit.do?blogNo=' + evt.currentTarget.dataset.blogNo;
      }
    })
  }
  
  getBlogList();
  detail();
  
//블로그 쓰기 이동

  const blogWrite = ()=>{
    location.href = "${contextPath}/blog/write.page";
  }
  
</script>

<%@ include file="../layout/footer.jsp" %>