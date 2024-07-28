package com.min.cinemagreen.openai;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/* 응답 결과
 * 
 * 1. id      : 생성된 응답의 고유 ID
 * 2. object  : 응답 객체의 유형 (일반적으로 chat.completion)
 * 3. created : 응답이 생성된 타임스탬프
 * 4. model   : 사용된 모델의 이름
 * 5. choices : 생성된 응답의 리스트. 각 응답은 메시지의 역할(role)과 내용(content)을 포함
 * 6. usage   : 요청의 토큰 사용량을 나타내는 정보 (입력 토큰 수, 출력 토큰 수, 총 토큰 수)  */

/* 응답 예시
  {
    "id": "chatcmpl-6x5eQ4Px5mL1e7Q4e5R9j8X9A",
    "object": "chat.completion",
    "created": 1675277923,
    "model": "gpt-3.5-turbo",
    "choices": [
      {
        "message": {
          "role": "assistant",
          "content": "To make a cup of tea, start by boiling some water. Then, place a tea bag in a cup and pour the hot water over it. Let it steep for a few minutes, remove the tea bag, and add any desired sweeteners or milk. Enjoy your tea!"
        },
        "finish_reason": "stop",
        "index": 0
      }
    ],
    "usage": {
      "prompt_tokens": 20,
      "completion_tokens": 44,
      "total_tokens": 64
    }
  }
*/

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ChatResponse {
  
  private List<Choice> choices;
  private Map<String, Integer> usage;
  
  @NoArgsConstructor
  @AllArgsConstructor
  @Data
  public static class Choice {
    private int index;
    private Message message;
  }
  
}