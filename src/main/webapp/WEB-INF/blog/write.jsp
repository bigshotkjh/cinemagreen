<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="WritePage" name="title"/>
</jsp:include>

<style>
  
  .dead-btn{cursor: default; pointer-events: none;}
  .sections.section_signin .width_con .title_con h4{ position: relative; transform: translateX(100%); transition: inherit;}
  .sections.section_signin .width_con .signin form{ position: relative; transform: translateX(42%); transition: inherit;}
  .title_con h6{ margin-top: 0;}
  input { border-radius: 4px;}
  div.note-modal.open{ position: fixed; top: 200px; }
  div.note-modal-backdrop { display: none !important; }
  #blog-write-form{ border-radius: 5px; padding: 5px; background-color: #FFFFF4; width: 1035px;}
  .title_con{ position: relative; transform: translate(180px, -150px);}
</style>


<div class="wrap">
  <div class="sections">
    <div class="width_con">
      <div class ="aaa">
        <div class="title_con white signin">
          <h4 class="title">Blog write</h4><br>
          <form id="blog-write-form"
              method="post"
              action="${contextPath}/blog/saveBlog.do">
            <div>
              <label for="title">제목</label>
              <input type="text" name="title" id="title" placeholder="필수 입력사항 입니다.">
            </div>
            <div>
              <textarea name="contents" id="contents" placeholder="내용 작성"></textarea>
            </div>
            <div>
              <button type="submit" class="submit dead-btn">작성완료</button>
              <button type="button" onclick="history.back()">취소하기</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>



<script>
$('#contents').summernote({
	  toolbar: [
	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    ['fontsize', ['fontsize']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['height', ['height']],
	    ['insert', ['link', 'picture', 'video']]
	  ],
	  width: 1024,
	  height: 500,
	  lang: 'ko-KR',
	  callbacks: {
	    onImageUpload: function(files) {  // files : 추가한 이미지
	      const maxWidth = 1000; // 최대 가로 크기
	      const maxHeight = 800; // 최대 세로 크기

	      for (let i = 0; i < files.length; i++) {
	        const img = new Image();
	        img.src = URL.createObjectURL(files[i]);

	        img.onload = () => {
	          // 이미지 크기 조절 비율 계산
	          let width = img.width;
	          let height = img.height;
	          const ratio = Math.min(maxWidth / width, maxHeight / height);

	          if (ratio < 1) {
	            width = Math.floor(width * ratio);
	            height = Math.floor(height * ratio);
	          }

	          // Canvas에 그리기
	          const canvas = document.createElement('canvas');
	          canvas.width = width;
	          canvas.height = height;
	          const ctx = canvas.getContext('2d');
	          ctx.drawImage(img, 0, 0, width, height);

	          // Canvas에서 Blob 생성
	          canvas.toBlob((blob) => {
	            // FormData 객체 생성
	            let formData = new FormData();
	            // FormData 객체에 이미지 저장하기
	            formData.append('file', blob, files[i].name);

	            // FormData 객체 처리
	            $.ajax({
	              // FormData 객체를 서버로 보내기
	              type: 'post',
	              url: '${contextPath}/blog/summernote/imageUpload.do',
	              data: formData,
	              contentType: false,  // Content-Type 헤더 값 생성 방지
	              processData: false,  // 객체를 보내는 경우 해당 객체를 {property: value} 형식의 문자열로 자동으로 변환해서 보내는데 이를 방지해야 한다.
	              // 서버가 저장한 이미지의 경로와 이름을 반환 받기
	              dataType: 'json'
	            }).done(resData => {  // resData == {url: '/경로/파일명'}
	              // summernote 편집기에 이미지 표시하기
	              $('#contents').summernote('insertImage', resData.url);
	            });
	          }, 'image/jpeg'); // 원하는 이미지 포맷 설정
	        };
	      }
	    }
	  }
	});
	
	const titleCheck = () => {
	    if ($("#title").val() == null || $("#title").val().trim() === "") {
	        $(".submit").addClass("dead-btn");
	    } else {
	        $(".submit").removeClass("dead-btn");
	    }
	}
	
	$(document).on("keyup", "#title", (evt) => {
	    titleCheck();
	});



</script>
<%@ include file="../layout/footer.jsp" %>