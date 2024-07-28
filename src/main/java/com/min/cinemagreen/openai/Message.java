package com.min.cinemagreen.openai;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * ChatRequest와 ChatResponse에서 사용되는 Message
 * 1. role
 *   1) user      : GPT에게 질문하는 사용자
 *   2) assistant : 사용자의 질문을 받는 AI 비서, user 와 system 사이
 *   3) system    : GPT
 * 2. content
 *   1) 대화 내용
 *   2) 한글 토큰이 영문 토큰에 비해 2배 이상 비싸므로 영문을 사용이 가능하면 영문 우선 사용 권장
 */

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Message {
  private String role;
  private String content;
}