package com.min.cinemagreen.openai;

import java.util.ArrayList;
import java.util.List;

import org.apache.coyote.BadRequestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/openai")
@Controller
public class ChatController {
    
  @Autowired
  private RestTemplate restTemplate;
  
  @Value("${openai.model}")
  private String model;
  
  @Value("${openai.api.url}")
  private String apiUrl;
  
  @GetMapping(value = "/chat.page")
  public String chatPage() {
    return "openai/chat";
  }
  
  @GetMapping(value = "/start.do")
  public ResponseEntity<String> startDo(HttpSession session, @RequestParam String prompt) throws Exception {
  
    // system 초기 메시지
    String systemContent = "You are a thoughtful assistant. Respond to all input in 20 words and answer in english.";
    
    // 첫채팅이라면 system 초기 메시지 작성 
    // 채팅중이라면 user 메시지 작성 
    @SuppressWarnings("unchecked")
    List<Message> messages = (List<Message>)session.getAttribute("messages");
    if(messages == null) {
      messages = new ArrayList<>();
      messages.add(new Message("system", systemContent));
      // System.out.println("세션에 올린 요청 : " + "system" + "/" + systemContent);
    } else {
      messages.add(new Message("user", prompt));
      // System.out.println("세션에 올린 요청 : " + "user" + "/" + prompt);
    }
    session.setAttribute("messages", messages);
      
    // 요청 생성(ChatRequest)
    ChatRequest request = new ChatRequest(model, messages);
    
    // API 호출 및 응답 받기(ChatResponse)
    ChatResponse response;
    try {
       response = restTemplate.postForObject(apiUrl, request, ChatResponse.class);
       messages.add(response.getChoices().get(0).getMessage());
       // System.out.println("세션에 올린 응답 : " + response.getChoices().get(0).getMessage().getRole() + "/" + response.getChoices().get(0).getMessage().getContent());
       System.out.println("현재 토큰 상황 : " + response.getUsage());  // gpt-3.5-model's max-tokens is 4096 tokens.
       session.setAttribute("messages", messages);
       
    } catch(Exception e) {
      throw new BadRequestException("OPENAI_API_KEY 확인 요망");
    }
    
    // 응답이 없는 경우
    if (response == null || response.getChoices() == null || response.getChoices().isEmpty()) {
      return new ResponseEntity<String>("No response", HttpStatus.NO_CONTENT);
    }
    
    // 응답 내용(content) 반환
    return ResponseEntity.ok(response.getChoices().get(0).getMessage().getContent());
      
  }
  
  @GetMapping(value = "/end.do")
  public ResponseEntity<String> endDo(HttpSession session) {
    if(session.getAttribute("messages") != null)
      session.removeAttribute("messages");
    return ResponseEntity.ok("채팅서비스가 종료되었습니다.");
  }
  
}