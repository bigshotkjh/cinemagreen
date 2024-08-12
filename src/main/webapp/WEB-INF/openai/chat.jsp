<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="OPENAI" name="title"/>
</jsp:include>

<style>
  * {
    box-sizing: border-box;
  }
  .wrap {
    width: 640px;
    margin: 20px auto;
  }
  .talking-list {
    width: 640px;
    height: 640px;
    overflow-y: auto;
    border : 1px solid gray;
    background-color: skyblue;
  }
  .message {
    width: 640px;
    height: 100px;
    resize: none;
    padding: 10px;
  }
  .message-wrap {
    margin-top: 5px;
  }
  .talking-list {
    position: relative;
    padding: 5px;
    margin-top: 10px;
  }
  .my-message, .gpt-message {
    margin-bottom: 5px;
  }
  .my-message {
    text-align: left;
  }
  .gpt-message {
    text-align: right;
  }
  .my-message-content, .gpt-message-content {
    padding: 5px;
    display: inline-block;
    max-width: 48%;
    border-radius: 3px;
    white-space: pre-line;
    font-size: 0.8em;
  }
  .my-message-content {
    text-align: left;
    background-color: yellow;
  }
  .gpt-message-content {
    text-align: right;
    background-color: white;
  }
</style>

<div class="wrap">

  <h5 class="title">Chat With ChatGPT</h5>
  
  <div class="message-wrap">
    <textarea class="message" id="message" wrap="hard" placeholder="GPT가 답해드립니다!"></textarea>    
  </div>
  <div>
    <input type="button" value="전송" class="btn btn-primary send-btn" id="send-btn">
    <input type="button" value="종료" class="btn btn-danger stop-btn" id="stop-btn">
  </div>
  
  <div id="talking-list" class="talking-list"></div>

</div>

<script>

// 메시지 입력 창
const message = $('#message');

// 대화 목록
const talkingList = $('#talking-list');

//대화 초기화
const initMessage = ()=>{
  message.val('');
  message.focus();
}

// 메시지 입력 후 엔터
const messageKeyup = ()=>{
  message.on('keyup', evt=>{
    if(message.val().trim() !== '' && evt.keyCode === 13 && !evt.shiftKey) {  // keyCode가 13인 키는 Enter이므로 Enter를 눌렀다는 의미, Shift+Enter는 textarea에서 줄 바꿀 때 사용하므로 제외해야 함
      message.val(message.val().trimEnd());
      chatWithOpenAI();
    }
  })
}

// 메시지 입력 후 전송 버튼
const sendBtnClick = ()=>{
  $('#send-btn').on('click', evt=>{
    if(message.val().trim() !== '') {      
      chatWithOpenAI();
    }
  })
}

// OPENAI와의 채팅
const chatWithOpenAI = () => {
  talkingList.append('<div class="my-message"><div class="my-message-content">' + message.val() + '</div></div>');
  talkingList.scrollTop(talkingList.prop('scrollHeight'));
  $.ajax({
    type: 'get',
    url: '${contextPath}/openai/start.do',
    data: 'prompt=' + message.val()
  }).done(resData=>{
    talkingList.append('<div class="gpt-message"><div class="gpt-message-content">' + resData + '</div></div>');
    talkingList.scrollTop(talkingList.prop('scrollHeight'));
  }).fail(jqXHR=>{
    talkingList.append('<div class="gpt-message"><div class="gpt-message-content">' + jqXHR.status + ' ' + JSON.parse(jqXHR.responseText).message + '</div></div>');
    talkingList.scrollTop(talkingList.prop('scrollHeight'));
  })
  initMessage();
}

// 채팅 종료
const stopBtnClick = ()=>{
  $('#stop-btn').on('click', evt=>{
    if(!confirm('채팅서비스를 종료할까요?')){
      return;
    }
    $.ajax({
      type: 'get',
      url: '${contextPath}/openai/end.do'
    }).done(resData=>{
      alert(resData);
      initMessage();
      talkingList.empty();
    })
  })
}

messageKeyup();
sendBtnClick();
stopBtnClick();

</script>

<%@ include file="../layout/footer.jsp" %>