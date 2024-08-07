package com.min.cinemagreen.utils;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Component
public class PageUtils {

  private int total;    // 전체 개수 (데이터베이스에서 구하는 정보)
  private int display;  // 한 페이지에 표시할 개수 (요청 파라미터, 디폴트 20개)
  private int page;     // 페이지 번호 (요청 파라미터, 디폴트 1 페이지)
  private int begin;    // 각 페이지에 표시할 시작 번호 (계산, setPaging() 메소드)
  private int end;      // 각 페이지에 표시할 종료 번호 (계산, setPaging() 메소드)
  
  private int totalPage;          // 전체 페이지의 개수 (계산, setPaging() 메소드)
  private int pagePerBlock = 10;  // 한 블록에 표시할 페이지의 개수 (결정한다.)
  private int beginPage;          // 한 블록에 표시할 시작 페이지 (계산, setPaging() 메소드)
  private int endPage;            // 한 블록에 표시할 종료 페이지 (계산, setPaging() 메소드)
  
  public void setPaging(int total, int display, int page) {
    
    this.total = total;
    this.display = display;
    this.page = page;
    
    begin = (page - 1) * display + 1;
    end = begin + display - 1;
    
    totalPage = (int)Math.ceil((double)total / display);
    beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
    endPage = Math.min(beginPage + pagePerBlock - 1, totalPage);
    
  }
  
  public String getPaging(String requestURI, String sort, int display) {
    
    StringBuilder builder = new StringBuilder();
    
    // <div>
    builder.append("<div class=\"paging\">");
    
    // <
    if(beginPage == 1)
      builder.append("<button type=\"button\" style=\"color: silver;\">&lt;</button>");
    else
      builder.append("<button type=\"button\" onclick=\"location.href='"+requestURI+"?page="+(beginPage-1)+"&sort="+sort+"&display="+display+"'\">&lt;</button>");
    
    // 1 2 3 4 5 6 7 8 9 10
    for(int p = beginPage; p <= endPage; p++) {
      if(p == page) {
        builder.append("<button type=\"button\" style=\"color: limegreen;\" onclick=\"location.href='"+requestURI+"?page="+(p)+"&sort="+sort+"&display="+display+"'\">"+p+"</button>");
      } else {
        builder.append("<button type=\"button\" onclick=\"location.href='"+requestURI+"?page="+(p)+"&sort="+sort+"&display="+display+"'\">"+p+"</button>");        
      }
    }
    
    // >
    if(endPage == totalPage) {
      builder.append("<button type=\"button\" style=\"color: silver;\">&gt;</button>");
    } else {
      builder.append("<button type=\"button\" onclick=\"location.href='"+requestURI+"?page="+(endPage+1)+"&sort="+sort+"&display="+display+"'\">&gt;</button>");
    }
    
    // </div>
    builder.append("</div>");
    
    return builder.toString();
    
  }
  
  public String getAsyncPaging() {
    
    StringBuilder builder = new StringBuilder();
    
    // <div>
    builder.append("<div class=\"paging\">");
    
    // <
    if(beginPage == 1)
      builder.append("<button type=\"button\" style=\"color: silver;\">&lt;</button>");
    else
      builder.append("<button type=\"button\" onclick=\"paging(" + (beginPage - 1) + ")\">&lt;</button>");
    
    // 1 2 3 4 5 6 7 8 9 10
    for(int p = beginPage; p <= endPage; p++) {
      if(p == page) {
        builder.append("<button type=\"button\" style=\"color: limegreen;\" onclick=\"paging(" + p + ")\">" + p + "</button>");
      } else {
        builder.append("<button type=\"button\" onclick=\"paging(" + p + ")\">" + p + "</button>");        
      }
    }
    
    // >
    if(endPage == totalPage) {
      builder.append("<button type=\"button\" style=\"color: silver;\">&gt;</button>");
    } else {
      builder.append("<button type=\"button\" onclick=\"paging(" + (endPage + 1) + ")\">&gt;</button>");
    }
    
    // </div>
    builder.append("</div>");
    
    return builder.toString();
    
  }
  
  public String getAsyncticketPaging() {
    
    StringBuilder builder = new StringBuilder();
    
    // <div>
    builder.append("<div class=\"paging\">");
    
    // <
    if(beginPage == 1)
      builder.append("<button type=\"button\" style=\"color: silver;\">&lt;</button>");
    else
      builder.append("<button type=\"button\" onclick=\"ticketPaging(" + (beginPage - 1) + ")\">&lt;</button>");
    
    // 1 2 3 4 5 6 7 8 9 10
    for(int p = beginPage; p <= endPage; p++) {
      if(p == page) {
        builder.append("<button type=\"button\" style=\"color: limegreen;\" onclick=\"paging(" + p + ")\">" + p + "</button>");
      } else {
        builder.append("<button type=\"button\" onclick=\"ticketPaging(" + p + ")\">" + p + "</button>");        
      }
    }
    
    // >
    if(endPage == totalPage) {
      builder.append("<button type=\"button\" style=\"color: silver;\">&gt;</button>");
    } else {
      builder.append("<button type=\"button\" onclick=\"ticketPaging(" + (endPage + 1) + ")\">&gt;</button>");
    }
    
    // </div>
    builder.append("</div>");
    
    return builder.toString();
    
  }
  
}
