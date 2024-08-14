package com.min.cinemagreen.blog.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.min.cinemagreen.dto.BlogCommentDTO;
import com.min.cinemagreen.dto.BlogDTO;
import com.min.cinemagreen.dto.ImageDTO;
import com.min.cinemagreen.dto.UserDTO;
import com.min.cinemagreen.blog.mapper.IBlogMapper;
import com.min.cinemagreen.utils.FileUploadUtils;
import com.min.cinemagreen.utils.PageUtils;
import com.min.cinemagreen.utils.SecurityUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class BlogServiceImpl implements IBlogService {

  private final IBlogMapper blogMapper;
  private final FileUploadUtils fileUploadUtils;
  private final SecurityUtils securityUtils;
  private final PageUtils pageUtils;
  
  @Transactional(readOnly = true)
  @Override
  public ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile) {
    // 저장할 디렉터리 만들기
    String uploadPath = fileUploadUtils.getSummernotePath();
    File uploadDir = new File("/summernote");//uploadPath를 직접 "D:/summernote"로 넣어줘야 정상 동작해.
    if(!uploadDir.exists()) {
      uploadDir.mkdirs();
    }
    
    // 저장할 파일명 만들기
    String filesystemName = fileUploadUtils.getFilesystemName(multipartFile.getOriginalFilename());
    
    // 저장
    File file = new File(uploadDir, filesystemName);
    try {
      multipartFile.transferTo(file);
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    return ResponseEntity.ok(Map.of("url", uploadPath + "/" + filesystemName));
    
  }

  @Override
  public int saveBlog(BlogDTO blogDTO, HttpSession session) {
  
    blogDTO.setTitle(securityUtils.preventXss(blogDTO.getTitle()));
    
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    blogDTO.setUserNo(loginUser.getUserNo());
    
    int insertResult = blogMapper.insertBlog(blogDTO);
    
    // blogDTO.contents 에 포함된 <img src="/summernote/..."> 태그 Parsing 해서 image_t 에 넣기
    Document document = Jsoup.parse(blogDTO.getContents());
    Elements elements = document.getElementsByTag("img");
    if(elements != null) {
      for(Element element : elements) {
        String src = element.attr("src");
        int lashSlash = src.lastIndexOf("/");
        String uploadPath = src.substring(0, lashSlash);
        String filesystemName = src.substring(lashSlash + 1);
        ImageDTO imageDTO = ImageDTO.builder()
            .blogNo(blogDTO.getBlogNo())
            .uploadPath(uploadPath)
            .filesystemName(filesystemName)
            .build();
        blogMapper.insertSummernoteImage(imageDTO);
      }
    }
    
    return insertResult;
    
  }
  
  @Transactional(readOnly = true)
  @Override
  public ResponseEntity<Map<String, Object>> getBlogList(HttpServletRequest request) {
    
    int page = Integer.parseInt(request.getParameter("page"));//페이지를 받아왔네.
    int display = 10; //한 페이지에 표시할 게시물 수
    int total = blogMapper.getBlogCount();//블로그 게시물 총수/ 맵퍼에 다녀와야해.
    
    pageUtils.setPaging(total, display, page);//페이징 정보를 설정
    
    Map<String, Object> params = new HashMap<>();//페이징 처리에 필요한 파라미터를 담은 Map을 생성
    params.put("begin", pageUtils.getBegin());
    params.put("end", pageUtils.getEnd());//시작과 끝을 담고 리스트 받으러 가
   
    List<BlogDTO> blogList = blogMapper.getBlogList(params); //블로그를 리스트형으로 받아오기.
    String paging = pageUtils.getAsyncPaging();//pageUtils를 사용하여 페이징 HTML 코드를 생성
    
    return ResponseEntity.ok(Map.of("blogList", blogList, "paging", paging)); //리스트랑 페이징 결과 담아서 보내.
    
  }
  
  @Override
  public int increseHit(int blogNo) {
    return blogMapper.updateHit(blogNo);
  }
  
  @Transactional(readOnly = true)
  @Override
  public BlogDTO getBlogByNo(int blogNo, HttpSession session) {

    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null)  // 로그인이 풀린 유저
      return null;  // 401
    int loginUserNo = loginUser.getUserNo();
    int writer = blogMapper.searchWriter(blogNo);
    if(writer == loginUserNo){
    blogMapper.removeNew(blogNo);
    }
    return blogMapper.getBlogByNo(blogNo);
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> saveBlogCommentParent(HttpServletRequest request) {
    
    // 작성자
    UserDTO loginUser = (UserDTO) request.getSession().getAttribute("loginUser");
    if(loginUser == null)  // 로그인이 풀린 유저
      return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);  // 401
    int loginUserNo = loginUser.getUserNo();
    // 원글 정보
    String contents = securityUtils.preventXss(request.getParameter("contents"));
    
    // 블로그 정보
    int blogNo = Integer.parseInt(request.getParameter("blogNo"));
    BlogCommentDTO blogCommentParentDTO = BlogCommentDTO.builder()
        .userNo(loginUserNo)
        .blogNo(blogNo)
        .contents(contents).build();
    
    int insertResult = blogMapper.insertBlogCommentParent(blogCommentParentDTO);
    int writer = blogMapper.searchWriter(blogNo);
    if(writer != loginUserNo){
    blogMapper.newComment(blogNo);
    }
    return ResponseEntity.ok(Map.of("isSuccess", insertResult == 1));
    
  }
  
  @Transactional(readOnly = true)
  @Override
  public ResponseEntity<Map<String, Object>> getBlogCommentList(HttpServletRequest request) {
    
    // 블로그 정보
    int blogNo = Integer.parseInt(request.getParameter("blogNo"));
    
    // 페이징 처리 정보
    int page = Integer.parseInt(request.getParameter("page"));
    int display = 3;
    int total = blogMapper.getBlogCommentCount(blogNo);
    
    pageUtils.setPaging(total, display, page);
    
    Map<String, Object> params = new HashMap<>();
    params.put("begin", pageUtils.getBegin());
    params.put("end", pageUtils.getEnd());
    params.put("blogNo", blogNo);
    
    List<BlogCommentDTO> blogCommentList = blogMapper.getBlogCommentList(params);
    String paging = pageUtils.getAsyncPaging();
    
    return ResponseEntity.ok(Map.of("blogCommentList", blogCommentList
                                  , "paging", paging
                                  , "blogCommentCount", total));
    
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> saveBlogCommentChild(HttpServletRequest request) {
    
    // 작성자
    UserDTO loginUser = (UserDTO) request.getSession().getAttribute("loginUser");
    
    if(loginUser == null)  // 로그인이 풀린 유저
      return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);  // 401
    int loginUserNo = loginUser.getUserNo();
    // 원글 정보
    int depth = Integer.parseInt(request.getParameter("depth"));
    int groupNo = Integer.parseInt(request.getParameter("groupNo"));
    int groupOrder = Integer.parseInt(request.getParameter("groupOrder"));
    
    BlogCommentDTO blogCommentParentDTO = BlogCommentDTO.builder()
        .depth(depth)
        .groupNo(groupNo)
        .groupOrder(groupOrder).build();
    
    blogMapper.updateGroupOrder(blogCommentParentDTO);

    // 블로그 정보
    int blogNo = Integer.parseInt(request.getParameter("blogNo"));
    
    // 답글 정보
    String contents = securityUtils.preventXss(request.getParameter("contents"));

    BlogCommentDTO blogCommentChildDTO = BlogCommentDTO.builder()
        .userNo(loginUser.getUserNo())
        .blogNo(blogNo)
        .contents(contents)
        .depth(depth + 1)
        .groupNo(groupNo)
        .groupOrder(groupOrder + 1).build();
    
    int insertResult = blogMapper.insertBlogCommentChild(blogCommentChildDTO);
    int writer = blogMapper.searchWriter(blogNo);
    if(writer != loginUserNo){
    blogMapper.newComment(blogNo);
    }
    return ResponseEntity.ok(Map.of("isSuccess", insertResult == 1));
    
  }
  
  @Override
  public int deletePost(BlogDTO blogDTO) {
    int blogNo = blogDTO.getBlogNo();
    return blogMapper.deletePost(blogNo);
  }
  
  @Override
  public int likeplus(BlogDTO blogDTO) {
    int blogNo = blogDTO.getBlogNo();
    return blogMapper.likeplus(blogNo);
  }
  
}
