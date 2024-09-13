<%@page import="beans.BookBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" %>
<%@page import="beans.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<jsp:useBean id="iMth" class="index.IndexMethod" /> 

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
  <script defer src="${pageContext.request.contextPath}/js/function.js"></script>

</head>

<body>
  <div id="wrap">

	<jsp:include page="./components/header.jsp" />
    
    <section>
      <h2 class="sr-only">메인컨텐츠</h2>
      <div class="recommendSlide">
        <p class="frame">
          <video src="${pageContext.request.contextPath}/images/bookabout.mp4" autoplay loop muted style="width: 1200px; height: auto;"></video>
          <video src="${pageContext.request.contextPath}/images/modernCafe.mp4" autoplay loop muted style="width: 1200px; height: auto;"></video>
        </p>
        <a href="#" class="prev">&lt;</a>
        <a href="#" class="next">&gt;</a>
      </div>

      <div class="bestSlide">
		<%
		for(int i=0; i<4; i++) {
			int ranId = (int)Math.floor((Math.random()*87 + 1));
			BookBean ranBBean = iMth.getRanBook(ranId);
			%>
	        <div class="bookCard">
				<img src="/image?bookid=<%= ranId %>" alt="<%= ranBBean.getTitle() %>">
				<a href="shop/shop02?bookid=<%= ranId %>">
				    <h3 class="title"><%= ranBBean.getTitle() %></h3>
				    <p class="author"><%= ranBBean.getAuthor() %></p>
				</a>
			    <span class="pointer">
			        <i class="fa-solid fa-ellipsis-vertical"></i>
			        <i class="fa-solid fa-x"></i>
			    </span>
			    <div class="addCartContainer">
			        <p class="addCart">장바구니에 추가</p>
			    </div>
			</div>
			<%
		}
		%>
      </div>

      <div class="boardContainer">

        <div class="latestBoard">
          <h3><a href="/board/board01">최신글</a></h3>
          <ul class="latestBoardList">
	          <%
	          Vector<BoardBean> latestList = iMth.getLastBoardList();
	          
	          for(int i=0; i<latestList.size(); i++) {
	        	  BoardBean bean = latestList.get(i);
	        	  %>
	        	  <li id="latest0<%= i %>">
		        	  <a href="/board/board02?boardId=<%= bean.getBoardid() %>"><%= bean.getContent() %></a>
		        	  <span class="author"><%= bean.getAuthor() %></span>
	        	  </li>
	        	  <%
	          }
	          %>
          </ul>
        </div>
        

        <div class="bestBoard">
          <h3><a href="/board/board01">인기글</a></h3>
          <ul class="bestBoardList">
	          <%
	          Vector<BoardBean> bestList = iMth.getBestBoardList();
	          
	          for(int i=0; i<bestList.size(); i++) {
	        	  BoardBean bean = bestList.get(i);
	        	  %>
	        	  <li id="best0<%= i %>">
		        	  <a href="/board/board02?boardId=<%= bean.getBoardid() %>"><%= bean.getContent() %></a>
		        	  <span class="author"><%= bean.getAuthor() %></span>
	        	  </li>
	        	  <%
	          }
	          %>
          </ul>
        </div>

      </div>

    </section>

    <footer>
      <address>&copy;Designed by teamMillkyWay</address>
    </footer>

  </div>

</body>

</html>