<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>
<c:choose>
  <c:when test="${empty param.title}">CINEMAGREEN STORE</c:when>
  <c:otherwise>${param.title}</c:otherwise>
</c:choose>
</title>

<script src="${contextPath}/static/lib/jquery-3.7.1.min.js"></script>
<script src="${contextPath}/static/jquery-ui-1.13.3.custom/jquery-ui.min.js"></script>
<script src="${contextPath}/static/bootstrap-5.3.3-dist/js/bootstrap.min.js"></script>
<script src="${contextPath}/static/summernote-0.8.18-dist/summernote-lite.min.js"></script>
<script src="${contextPath}/static/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link rel="stylesheet" href="${contextPath}/static/jquery-ui-1.13.3.custom/jquery-ui.min.css">
<link rel="stylesheet" href="${contextPath}/static/bootstrap-5.3.3-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${contextPath}/static/summernote-0.8.18-dist/summernote-lite.min.css">
<link rel="stylesheet" href="${contextPath}/static/css/init.css">
<link rel="stylesheet" href="${contextPath}/static/css/common.css">
<link rel="stylesheet" href="${contextPath}/static/css/header.css">
<link rel="stylesheet" href="${contextPath}/static/css/store.css">

</head>
<body>
  <div class="wrap">
    <div class="nav_cover"></div>
    <div id="header" class="sections section_00">
      <div class="width_con">
        <a href="index.html" class="btn_home"><img src="img/logo.svg">멋진로고</a>
        <div class="btn_open_nav"><div></div></div>
        <ul class="nav">
          <li><a href="${contextPath}/reserve/reserve.do">예매</a></li>
          <li><a href="#">영화</a></li>
          <li><a href="#">고객지원</a></li>
	      <li><a href="#">마이페이지</a></li>
	      <li><a href="${contextPath}/store/store.page">스토어</a></li>
        </ul>
        <c:if test="${empty sessionScope.loginUser}">
          <ul class="nav_customer">
            <li><a href="${contextPath}/user/signin.page"><i class="fa-solid fa-arrow-right-from-bracket"></i>로그인</a></li>
            <li><a href="${contextPath}/user/signup.page"><i class="fa-solid fa-user-plus"></i>회원가입</a></li>
          </ul>
        </c:if>
        <c:if test="${not empty sessionScope.loginUser}">
          <ul class="nav_customer">
            <li><a href="마이페이지로가기">${sessionScope.loginUser.name}</a>님 반갑습니다</li>
            <li><a href="${contextPath}/user/signout.do">로그아웃</a></li>
          </ul>
        </c:if>
      </div>
    </div> 
  </div>
<body>
  <!-- Header-->
  <header class="bg-dark py-5">
    <div class="text-center text-white">
      <h1 class="display-4 fw-bolder">Shop in style</h1>
      <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
    </div>
  </header>
  <!-- Section-->
  <section class="py-5">
    <div class="container">
      <div class="row width4 center">

		<div class="col mb-5">
          <div class="card h-100">
            <!-- Product image-->
            <img src="../images/ticket1.png"/>
              <!-- Product details-->
            <div class="p-4">
              <div class="text-center">
                <!-- Product name-->
                <h5 class="fw-bolder">일반 관람권</h5>
                <!-- Product reviews-->
                <div class="d-flex center small warning mb-2">
                  <div class="bi-star-fill"></div>
                  <div class="bi-star-fill"></div>
                  <div class="bi-star-fill"></div>
                  <div class="bi-star-fill"></div>
                </div>
                <!-- Product price-->
                $40.00 - $80.00
              </div>
            </div>
            <!-- Product actions-->
            <div class="p-4 pt-0">
            <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
		   </div>
         </div>
       </div>

       <div class="col mb-5">
         <div class="card h-100">
            <!-- Product image-->
            <img src="../images/ticket2.png"/>
            <!-- Product details-->
            <div class="p-4">
              <div class="text-center">
                <!-- Product name-->
                <h5 class="fw-bolder">싱글 패키지</h5>
                <!-- Product reviews-->
                <div class="d-flex center small text-warning mb-2">
                  <div class="bi-star-fill"></div>
                  <div class="bi-star-fill"></div>
                  <div class="bi-star-fill"></div>
                  <div class="bi-star-fill"></div>
                  <div class="bi-star-fill"></div>
                </div>
                <!-- Product price-->
                <span class="text-muted text-decoration-line-through">$20.00</span>
                $18.00
              </div>
            </div>
            <!-- Product actions-->
            <div class="p-4 pt-0">
              <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
            </div>
          </div>
        </div>

        <div class="col mb-5">
          <div class="card h-100">
            <!-- Product image-->
            <img src="../images/ticket3.png"/>
            <!-- Product details-->
            <div class="p-4">
              <div class="text-center">
                <!-- Product name-->
                <h5 class="fw-bolder">러브콤보 패키지</h5>
                <!-- Product reviews-->
                  <div class="d-flex center small text-warning mb-2">
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                  </div>
                  <!-- Product price-->
                  <span class="text-muted text-decoration-line-through">$50.00</span>
                  $25.00
                 </div>
               </div>
               <!-- Product actions-->
               <div class="p-4 pt-0">
                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
               </div>
             </div>
           </div>

           <div class="col mb-5">
             <div class="card h-100">
             <!-- Product image-->
             <img src="../images/ticket4.png"/>
               <!-- Product details-->
               <div class="p-4">
                 <div class="text-center">
                 <!-- Product name-->
                 <h5 class="fw-bolder">패밀리 패키지</h5>
                 <!-- Product reviews-->
                   <div class="d-flex center small text-warning mb-2">
                     <div class="bi-star-fill"></div>
                       <div class="bi-star-fill"></div>
                       <div class="bi-star-fill"></div>
                       <div class="bi-star-fill"></div>
                       <div class="bi-star-fill"></div>
                     </div>
                     <!-- Product price-->
                      $40.00
                   </div>
                 </div>
                 <!-- Product actions-->
                 <div class="p-4 pt-0">
                   <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                 </div>
               </div>
             </div>

			 <div class="col mb-5">
			   <div class="card h-100">
			   <!-- Product image-->
			   <img src="../images/ticket4.png"/>
			     <!-- Product details-->
			     <div class="p-4">
			       <div class="text-center">
			       <!-- Product name-->
			       <h5 class="fw-bolder">패밀리 패키지</h5>
			       <!-- Product reviews-->
			         <div class="d-flex center small text-warning mb-2">
			           <div class="bi-star-fill"></div>
			             <div class="bi-star-fill"></div>
			             <div class="bi-star-fill"></div>
			             <div class="bi-star-fill"></div>
			             <div class="bi-star-fill"></div>
			           </div>
			           <!-- Product price-->
			            $40.00
			          </div>
			        </div>
			        <!-- Product actions-->
			        <div class="p-4 pt-0">
			          <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
			        </div>
			      </div>
			    </div>


				<div class="col mb-5">
				  <div class="card h-100">
                    <!-- Sale badge-->
                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
				  <!-- Product image-->
				  <img src="../images/ticket4.png"/>
				    <!-- Product details-->
				    <div class="p-4">
				      <div class="text-center">
				      <!-- Product name-->
				      <h5 class="fw-bolder">패밀리 패키지</h5>
				      <!-- Product reviews-->
				        <div class="d-flex center small text-warning mb-2">
				          <div class="bi-star-fill"></div>
				            <div class="bi-star-fill"></div>
				            <div class="bi-star-fill"></div>
				            <div class="bi-star-fill"></div>
				            <div class="bi-star-fill"></div>
				          </div>
				          <!-- Product price-->
				           $40.00
				        </div>
				      </div>
				      <!-- Product actions-->
				      <div class="p-4 pt-0">
				        <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
				      </div>
				    </div>
				  </div>

			<div class="col mb-5">
			  <div class="card h-100">
			  <!-- Product image-->
			  <img src="../images/ticket4.png"/>
			    <!-- Product details-->
			    <div class="p-4">
			      <div class="text-center">
			      <!-- Product name-->
			      <h5 class="fw-bolder">패밀리 패키지</h5>
			      <!-- Product reviews-->
			        <div class="d-flex center small text-warning mb-2">
			          <div class="bi-star-fill"></div>
			            <div class="bi-star-fill"></div>
			            <div class="bi-star-fill"></div>
			            <div class="bi-star-fill"></div>
			            <div class="bi-star-fill"></div>
			          </div>
			          <!-- Product price-->
			           $40.00
			        </div>
			      </div>
			      <!-- Product actions-->
			      <div class="p-4 pt-0">
			        <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
			      </div>
			    </div>
			  </div>

			  <div class="col mb-5">
			    <div class="card h-100">
			    <!-- Product image-->
			    <img src="../images/ticket4.png"/>
			      <!-- Product details-->
			      <div class="p-4">
			        <div class="text-center">
			        <!-- Product name-->
			        <h5 class="fw-bolder">패밀리 패키지</h5>
			        <!-- Product reviews-->
			          <div class="d-flex center small text-warning mb-2">
			            <div class="bi-star-fill"></div>
			              <div class="bi-star-fill"></div>
			              <div class="bi-star-fill"></div>
			              <div class="bi-star-fill"></div>
			              <div class="bi-star-fill"></div>
			            </div>
			            <!-- Product price-->
			             $40.00
			          </div>
			        </div>
			        <!-- Product actions-->
			        <div class="p-4 pt-0">
			          <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
			        </div>
			      </div>
			    </div>
			
			
        </div>
      </div>
    </div>
  </body>
</html>
