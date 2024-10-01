<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardMgr, beans.BookBean, java.util.ArrayList" %>
<%
	ArrayList<BookBean> bList = (ArrayList<BookBean>)request.getAttribute("bList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="formHead">
      	<h4>도서 검색</h4>
      	<i class="fa-solid fa-x" onclick="postBookFn()"></i>
   	</div>
     	
   	<input onkeyup="if(window.event.keyCode==13){(postBookSearchFn())}" id="postBookSearch" placeholder="도서명을 검색해보세요!" />
	<ul id="bookSearchList">
	<% // 추출된 책이 있을경우
	  if(!bList.isEmpty()) {
	  	for(int i=0; i<bList.size(); i++) { 
			BookBean bean = bList.get(i); %>
	   		<li onclick="bookSelectFn()">
		   			<div>
			   			<span><%= bean.getTitle() %></span>
			   			<span><%= bean.getAuthor() %></span>
		   			</div>
		   			<% // 첨부이미지가 있으면 출력
	                if(bean.getPhoto() != null && bean.getPhoto().length > 0) { %>
		   			<img src="data:image/jpeg;base64, <%= java.util.Base64.getEncoder().encodeToString(bean.getPhoto()) %>" alt="#">
	   			 <% } %>
		   		</li>
 		<% } %>
   	<% } %>
   	</ul>
</body>
</html>