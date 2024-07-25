package com.min.cinemagreen.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.PropertySource;
//import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/* application.properties 파일의 프로퍼티 값 읽어오기
 * 
 *   @org.springframework.context.annotation.PropertySource(value = "classpath:application.properties")
 * 
 *   @Autowired
 *   private org.springframework.core.env.Environment env;
 *   
 *   env.getProperty("spring.mail.username")  */

//@PropertySource(value = "classpath:application.properties")
@Component
public class MailUtils {
  
  @Autowired
  private JavaMailSender javaMailSender;
  
  @Value(value = "${spring.mail.username}")
  private String username;
  
  public void sendMail(String to, String subject, String content) {
    
    try {

      MimeMessage mimeMessage = javaMailSender.createMimeMessage();
      MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);
      helper.setFrom(username);
      helper.setTo(new InternetAddress(to));
      helper.setSubject(subject);
      mimeMessage.setContent(content, "text/html; charset=UTF-8");
      
      javaMailSender.send(mimeMessage);
      
    } catch (Exception e) {
      e.printStackTrace();
    }
    
  }
  
}