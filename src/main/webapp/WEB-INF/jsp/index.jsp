<%@ page import="beans.BookBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" %>
<%@ page import="beans.BoardBean"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<jsp:useBean id="iMgr" class="index.IndexMgr" />

<%
	String userId = (String) session.getAttribute("idKeyS");
	if (userId == null) {
		/*
	    자바스크립트에서 인식하는 null과 자바에서 인식하는 null이 서로 다른듯 함
	    자바의 null값을 자바스크립트 함수에 <%= 형태로 넣을 경우 문자열 "null"로 변환되어 
	    실제 자바스크립트 함수에서는 유효성 검사를 진행하지 못함
		*/
	    userId = ""; // userId가 null인 경우 빈 문자열로 초기화
	}

	int ranCount = 0;
	String category = null;
%>

<%--
	작동확인 완료
    <% 
		int bookid = 2; // 사용할 bookid를 설정합니다
	%>
	<img src="/image?bookid=1" alt="연금술사">
--%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>BookAbout</title>
	
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
  <script defer src="https://kit.fontawesome.com/9ad59cd5cc.js" crossorigin="anonymous"></script>
  <script defer src="${pageContext.request.contextPath}/js/index.js?after"></script>

</head>

<body>
  <div id="wrap">

	<jsp:include page="./components/header.jsp" />
    
    <section>
      <div class="recommendSlide">
        <p class="frame">
          <video src="${pageContext.request.contextPath}/images/bookabout.mp4" autoplay loop muted style="width: 1200px; height: auto;"></video>
          <video src="${pageContext.request.contextPath}/images/modernCafe.mp4" autoplay loop muted style="width: 1200px; height: auto;"></video>
        </p>
        <a href="#" class="prev">&lt;</a>
        <a href="#" class="next">&gt;</a>
      </div>

      <div class="bestSlide">
	  <h2><a href="shop/shop01?category=국내도서">국내도서 <span>바로가기</span></a></h2>
		<%
		// 국내도서 총 갯수중 랜덤 5개 추출
		category = "국내도서";
		ranCount = iMgr.getCatCount(category);
		int[] ranList = new int[5];
		
		for (int i = 0; i < 5; i++) {
		    int ranId;
		    boolean flag;
		
		    do {
		        flag = false;
		        ranId = (int) Math.floor(Math.random() * ranCount) + 1;
		
		        // 중복 확인
		        for (int j = 0; j < i; j++) {
		            if (ranList[j] == ranId) {
		            	flag = true; // 중복이면 true로 설정
		                break;
		            }
		        }
		    } while (flag); // 중복이면 다시 랜덤 생성
		
		    ranList[i] = ranId; // 중복이 없으면 ID 저장
		    BookBean ranBBean = iMgr.getRanBook(ranId - 1, category);
			%>
	        <div class="bookCard">
				<img src="/image?bookid=<%=ranBBean.getBookid()%>" alt="<%= ranBBean.getTitle() %>">
				<a href="shop/shop02?bookid=<%= ranBBean.getBookid() %>">
				    <h3 class="title"><%= ranBBean.getTitle() %></h3>
				    <p class="author"><%= ranBBean.getAuthor() %></p>
				</a>
			    <span class="pointer">
			        <i class="fa-solid fa-ellipsis-vertical"></i>
			        <i class="fa-solid fa-x"></i>
			    </span>
			    <div class="addCartContainer">
	        		<p class="addToCart" onClick="addToCart('<%=userId%>','<%=ranBBean.getBookid()%>','<%=ranBBean.getTitle()%>','<%=i%>')">장바구니에 추가</p>
			    </div>
			</div>
			<%
		}
		%>
      </div>
	  
      
      <div class="bestSlide">
   	  <h2><a href="shop/shop01?category=해외도서">해외도서 <span>바로가기</span></a></h2>
		<%
		// 국내도서 총 갯수중 랜덤 5개 추출
		category = "해외도서";
		ranCount = iMgr.getCatCount(category);
		
		for (int i = 0; i < 5; i++) {
		    int ranId;
		    boolean flag;
		
		    do {
		        flag = false;
		        ranId = (int) Math.floor(Math.random() * ranCount) + 1;
		
		        // 중복 확인
		        for (int j = 0; j < i; j++) {
		            if (ranList[j] == ranId) {
		            	flag = true; // 중복이면 true로 설정
		                break;
		            }
		        }
		    } while (flag); // 중복이면 다시 랜덤 생성
		
		    ranList[i] = ranId; // 중복이 없으면 ID 저장
		    BookBean ranBBean = iMgr.getRanBook(ranId - 1, category);
			%>
	        <div class="bookCard">
				<img src="/image?bookid=<%=ranBBean.getBookid()%>" alt="<%= ranBBean.getTitle() %>">
				<a href="shop/shop02?bookid=<%= ranBBean.getBookid() %>">
				    <h3 class="title"><%= ranBBean.getTitle() %></h3>
				    <p class="author"><%= ranBBean.getAuthor() %></p>
				</a>
			    <span class="pointer">
			        <i class="fa-solid fa-ellipsis-vertical"></i>
			        <i class="fa-solid fa-x"></i>
			    </span>
			    <div class="addCartContainer">
	        		<p class="addToCart" onClick="addToCart('<%=userId%>','<%=ranBBean.getBookid()%>','<%=ranBBean.getTitle()%>','<%=i+5%>')">장바구니에 추가</p>
			    </div>
			</div>
			<%
		}
		%>
      </div>

      <div class="boardContainer">

        <div class="latestBoard">
          <h3><a href="/board/board01">최신 게시물<span>더보기</span></a></h3>
          <ul class="latestBoardList">
	          <%
	          Vector<BoardBean> latestList = iMgr.getLastBoardList();
	          
	          for(int i=0; i<latestList.size(); i++) {
	        	  BoardBean bean = latestList.get(i);
	        	  %>
	        	  <li id="latest0<%= i %>">
		        	  <a href="/board/board02?num=<%= bean.getBoardid() %>"><%= bean.getContent() %></a>
		        	  <span class="author"><%= bean.getNickname() %></span>
	        	  </li>
	        	  <%
	          }
	          %>
          </ul>
        </div>
        

        <div class="bestBoard">
          <h3><a href="/board/board01?nowPage=1&tab=인기">인기 게시물<span>더보기</span></a></h3>
          <ul class="bestBoardList">
	          <%
	          Vector<BoardBean> bestList = iMgr.getBestBoardList();
	          
	          for(int i=0; i<bestList.size(); i++) {
	        	  BoardBean bean = bestList.get(i);
	        	  %>
	        	  <li id="best0<%= i %>">
		        	  <a href="/board/board02?num=<%= bean.getBoardid() %>"><%= bean.getContent() %></a>
		        	  <span class="author"><%= bean.getNickname() %></span>
	        	  </li>
	        	  <%
	          }
	          %>
          </ul>
        </div>

      </div>

    </section>

	<jsp:include page="./components/footer.jsp" />
	
	<jsp:include page="./components/aside.jsp" />

  </div>

</body>

</html>