package com.min.cinemagreen.utils;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class SecurityUtils {

  /* SHA-256
   * 1. 256비트(32바이트)로 암호화하는 해시 알고리즘이다.
   * 2. 암호화는 가능하고 복호화는 불가능하다. (단방향 알고리즘)  */
  
  public String getSha256(String source) {
    StringBuilder builder = new StringBuilder();
    try {
      MessageDigest md = MessageDigest.getInstance("SHA-256");
      md.update(source.getBytes());
      byte[] b = md.digest();
      for(int i = 0; i < b.length; i++) {
        builder.append(String.format("%02X", b[i]));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return builder.toString();
  }
  
  /* 크로스 사이트 스크립팅 (Cross Site Scripting)
   * 1. 입력 란에 스크립트 코드를 넣는 공격 방식이다.
   * 2. 스크립트 코드에 반드시 필요한 <script> 태그의 무력화를 위해서
   *    "<" 기호는 "&lt;"으로 바꾸고 ">" 기호는 "&gt;"으로 바꾼다.  */
  
  public String preventXss(String source) {
    return source.replace("<", "&lt;").replace(">", "&gt;");
  }
  
  /* 인증 코드 생성기
   * 1. 대문자 + 숫자 조합으로 생성한다.
   * 2. 코드 길이, 대문자 사용 여부, 숫자 사용 여부를 받아서 생성한다.  */
  
  public String getRandomCode(int length, boolean letter, boolean number) {
    /* [ABCD....][01234...] 리스트 만들어 랜덤 인덱스로 추출 */
    List<String> source = new ArrayList<>();
    if(letter) {
      for(char ch = 'A'; ch <= 'Z'; ch++)
        source.add(ch + "");
    }
    if(number) {
      for(char ch = '0'; ch <= '9'; ch++)
        source.add(ch + "");
    }
    SecureRandom random = new SecureRandom();
    StringBuilder builder = new StringBuilder();
    if(letter || number) {
      for(int count = 0; count < length; count++)
        builder.append( source.get(random.nextInt(source.size())) );
    }
    return builder.toString();
  }
  
}
