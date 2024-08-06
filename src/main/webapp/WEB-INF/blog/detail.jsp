<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="Movie Post" name="title"/>
</jsp:include>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style>
  .title_con h6{ margin-top: 0;}
  input { border-radius: 4px;}
  #blog-comment-btn {
    width: 100px;
    height: 36px;
    border: 1px solid gray;
    cursor: pointer;
    text-align: center;
    line-height: 36px;
    margin-bottom: 30px;
  }
  #blog-comment-btn:hover {
    background-color: #EEEEEE;
  }
  .blind {
    display: none;
  }
  .paging {
    margin: 30px 0;
  }
  .title_con {position: relative; transform: translate(0px, -150px);}
  .blog-content {position: relative; transform: translate(250px, 0px);}
  .blog {border-radius: 5px; padding: 5px; background-color: #FFFFF4; margin: 5px; width: 900px; overflow: hidden;}
  #parent-form {position: relative; transform: translate(250px, 0px);}
  .data {text-align: right; width: 600px;}
  .title.data {text-align: right; width: 400px;}
  .movie-title {position: relative; transform: translate(200px, 0px) !important;}
</style>


<div class="wrap">
  <div class="sections">
    <div class="width_con">
      <div class ="aaa">
        <div class="title_con white signin">
          <h4 class="movie-title">Movie Postlist</h4><br>
          <div class="blog-content">
	          <h5 class="blog title"><b>제목 | ${blog.title}</h5>
	          <div class="blog data">${blog.name}| HIT : ${blog.hit} | 작성일 : ${blog.createDt} </div>
	          <div class="blog contents ">${blog.contents}</div>
	          <div id="blog-comment-btn">
	            <span>댓글</span>
	            <span id="blog-comment-count"></span>
	          </div>
            <div id="blog-comment-list" class="blind"></div>
          </div>
					
					<hr>
					
					<div>
					  <form id="parent-form">
					    <input type="hidden" name="blogNo" value="${blog.blogNo}">
					    <textarea id="contents" name="contents" rows="3" cols="50" placeholder="댓글을 입력해 주세요."></textarea>    
					    <button type="button" id="save-parent-btn">등록</button>
              <button type="button" onclick="history.back()">뒤로가기</button>
					  </form>
					</div>
        </div>
      </div>
    </div>
  </div>

<script>

  const signinCheck = () => {
    if('${sessionScope.loginUser}' === '') {
      if(confirm('로그인이 필요한 기능입니다. 로그인 하시겠습니까?')) {
        location.href = '${contextPath}/user/signin.page';
        return true;
      } else {
        return false;
      }
    }
  }

  $('#contents').on('click', evt=>{
    signinCheck();
  })
  
  const saveBlogCommentParent = ()=>{    
    $('#save-parent-btn').on('click', evt=>{
      if(signinCheck()){
        return;
      }
      $.ajax({
        type: 'post',
        url: '${contextPath}/blog/saveBlogCommentParent.do',
        data: $('#parent-form').serialize(),  // <form> 내부의 모든 입력을 파라미터 형식으로 보낼 때 사용한다. 입력 요소들은 name 속성을 가지고 있어야 한다.
        dataType: 'json'
      }).done(resData=>{  // resData == {"isSuccess": true}
        if(resData.isSuccess){
          alert('댓글 등록 성공');
          paging(1);
          $('#blog-comment-list').removeClass('blind');
          $('#contents').val('');
        } else {
          alert('댓글 등록 실패')
        }
      }).fail(jqXHR=>{
        alert(jqXHR.status);
      })
    })
  }

  const toggleBlogCommentList = ()=>{    
    $('#blog-comment-btn').on('click', evt=>{
      $('#blog-comment-list').toggleClass('blind');
    })
  }

  var page = 1;
  
  const paging = (p)=>{
    page = p;
    getBlogCommentList();
  }

  const getBlogCommentList = ()=>{
    $.ajax({
      type: 'get',
      url: '${contextPath}/blog/getBlogCommentList.do',
      data: 'blogNo=${blog.blogNo}&page=' + page,
      dataType: 'json'
    }).done(resData=>{
      document.getElementById('blog-comment-count').innerHTML = resData.blogCommentCount + '개';
      const blogCommentList = document.getElementById('blog-comment-list');
      const paging = document.getElementById('paging');
      if(resData.blogCommentList.length === 0){
        blogCommentList.innerHTML = '<div>등록된 댓글이 없습니다.</div>';
        return;
      }
      blogCommentList.innerHTML = '';
      for(const [index, blogComment] of resData.blogCommentList.entries()){
        let str = '';
        let indents = 0;
        for(let i = 0; i < blogComment.depth; i++) {
          indents += 20;
        }
        str += '<div style="padding-left: ' + indents + 'px;">';
        if(blogComment.state === -1) {
          str += '<div>삭제된 댓글입니다.</div>';
        } else {
          str += '<div>' + blogComment.name + '(' + blogComment.createDt + ')</div>';
          str += '<div><pre>' + blogComment.contents + '</pre></div>';
          str += '<div><button type="button" class="open-form-btn" data-index="' + index + '">답글</button></div>';
        }
        str += '<form class="child-form show' + index + ' blind">';
        str += '  <input type="hidden" name="depth" value="' + blogComment.depth + '">';
        str += '  <input type="hidden" name="groupNo" value="' + blogComment.groupNo + '">';
        str += '  <input type="hidden" name="groupOrder" value="' + blogComment.groupOrder + '">';
        str += '  <input type="hidden" name="blogNo" value="${blog.blogNo}">';
        str += '  <textarea name="contents" rows="3" cols="50" placeholder="댓글을 입력해 주세요."></textarea>';
        str += '  <button type="button" class="save-child-btn">등록</button>';
        str += '</form>';
        str += '</div>';
        blogCommentList.innerHTML += str;
      }
      blogCommentList.innerHTML += resData.paging;
    }).fail(jqXHR=>{
      alert(jqXHR.status);
    })
  }
  
  const openForm = ()=>{    
    $(document).on('click', '.open-form-btn', evt=>{
      if(signinCheck()){
        return;
      }
      const childForm = $('.child-form');
      console.log(childForm);
      const show = $('.show' + $(evt.target).data('index'));
      if(show.hasClass('blind')){
        childForm.addClass('blind');
        show.removeClass('blind');
      } else {
        childForm.addClass('blind');
      }
    })
  }
  
  const saveBlogCommentChild = ()=>{    
    $(document).on('click', '.save-child-btn', evt=>{
      if(signinCheck()){
        return;
      }
      $.ajax({
        type: 'post',
        url: '${contextPath}/blog/saveBlogCommentChild.do',
        data: $(evt.target).closest('.child-form').serialize(),  // <form> 내부의 모든 입력을 파라미터 형식으로 보낼 때 사용한다. 입력 요소들은 name 속성을 가지고 있어야 한다.
        dataType: 'json'
      }).done(resData=>{  // resData == {"isSuccess": true}
        if(resData.isSuccess){
          alert('댓글 등록 성공');
          paging(1);
          $('#blog-comment-list').removeClass('blind');
        } else {
          alert('댓글 등록 실패')
        }
      }).fail(jqXHR=>{
        alert(jqXHR.status);
      })
    })
  }
  
  saveBlogCommentParent();
  toggleBlogCommentList();
  getBlogCommentList();
  openForm();
  saveBlogCommentChild();
  
</script>

<%@ include file="../layout/footer.jsp" %>