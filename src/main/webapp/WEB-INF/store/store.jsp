<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="CINEMAGREEN STORE" name="title"/>
</jsp:include>
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
                  10,000P
                </div>
              </div>
              <!-- Product actions-->
              <div class="p-4 pt-0">
                <!-- Product price-->
                10,000P
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
                15,000P
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
                  15,000P
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
                    27,000P
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
                        40,000P
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
          <img src="../images/snack1.png"/>
            <!-- Product details-->
            <div class="p-4">
              <div class="text-center">
              <!-- Product name-->
              <h5 class="fw-bolder">황태 스낵</h5>
              <!-- Product reviews-->
                <div class="d-flex center small text-warning mb-2">
                  <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                  </div>
                  <!-- Product price-->
                    2,000P
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
            <img src="../images/snack1.png"/>
              <!-- Product details-->
              <div class="p-4">
                <div class="text-center">
                <!-- Product name-->
                <h5 class="fw-bolder">(특가)황태 스낵</h5>
                <!-- Product reviews-->
                  <div class="d-flex center small text-warning mb-2">
                    <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                    </div>
                    <!-- Product price-->
                <span class="text-muted text-decoration-line-through">2,000P</span>
                    1,000P
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
          <img src="../images/snack3.png"/>
            <!-- Product details-->
            <div class="p-4">
              <div class="text-center">
              <!-- Product name-->
              <h5 class="fw-bolder">오징어 튀김 세트</h5>
              <!-- Product reviews-->
                <div class="d-flex center small text-warning mb-2">
                  <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                    <div class="bi-star-fill"></div>
                  </div>
                  <!-- Product price-->
                  4,000P
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
            <img src="../images/snack4.png"/>
              <!-- Product details-->
              <div class="p-4">
                <div class="text-center">
                <!-- Product name-->
                <h5 class="fw-bolder">오징어 튀김</h5>
                <!-- Product reviews-->
                  <div class="d-flex center small text-warning mb-2">
                    <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                      <div class="bi-star-fill"></div>
                    </div>
                    <!-- Product price-->
                    2,000P
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
