package com.min.cinemagreen.openai;

import java.util.List;

import lombok.Data;

/* 요청 파라미터
 * 
 * 1. model       : 사용할 모델의 이름 (예 : gpt-3.5-turbo)
 * 2. messages    : 대화의 히스토리를 나타내는 리스트. 각 Message는 역할(role)과 내용(content)을 포함, 역할에는 user, assistant, system 등이 존재
 * 3. max_tokens  : 생성할 응답의 최대 토큰 수
 * 4. temperature : 응답의 창의성 수준(0에서 1사이의 실수). 낮을수록 보수적인 응답, 높을수록 창의적인 응답
 * 5. top_p       : 응답의 다양성을 조절(0에서 1사이의 실수). 낮을수록 높은 확률의 단어에 집중하여 응답을 생성
 * 6. n           : 응답의 개수 (디폴트 1)  */

/* 요청 예시
  {
    "model": "gpt-3.5-turbo",
    "messages": [
      {"role": "system", "content": "You are a helpful assistant."},
      {"role": "user", "content": "How do I make a cup of tea?"}
    ],
    "max_tokens": 150,
    "temperature": 0.7
  }
*/

@Data
public class ChatRequest {
  
  private String model;
  private List<Message> messages;
  private int max_tokens;
  private double temperature;
  private double top_p;
  private int n;
  
  public ChatRequest(String model, List<Message> messages) {
      this.model = model;
      this.messages = messages;
      this.max_tokens = 100;  // 한 번에 최대 100 토큰의 요청을 사용(조정 가능)
      this.n = 1;
  }
  
}