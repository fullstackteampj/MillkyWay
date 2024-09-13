<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, board.BoardBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String loginId = (String)session.getAttribute("idKey");
	int boardid = Integer.parseInt(request.getParameter("num"));
	BoardBean post = bMgr.getPost(boardid);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글제목 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
  <script>
	function goLogin() {
		const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?");
		if(result) {
			location.href = "/login/login01";
		}
	}
  </script>
</head>
<body>
  <div id="wrap">
	  <jsp:include page="../components/header.jsp" />
	 
	  <section>
	    <h2><a href="./board01">은하수 광장✨</a></h2>
	
	    <div id="postBox">
	      <div id="readHead">
	        <div id="readHead-top">
	          <p id="readTit"><%= post.getTitle() %></p>
	        </div> <!--readHead-top-->
	
	        <div id="readHead-bottom">
	          <div id="regInfo">
	            <span id="postAuthor"><%= post.getNickname() %></span>
	            <span id="postRegdate"><%= post.getRegdate() %></span>
	          </div>
	
	          <div id="feedback">
	            <p>조회 <span><%= post.getCount() %></span></p>
	            <p>추천 <span><%= post.getLiked() %></span></p>
	          </div>
	        </div> <!--readHead-bottom-->
	      </div> <!--readHead-->
	
	      <div id="readContent">
	        <div id="contentDetail">
	          <p>
	          <% if(post.getPhoto() != null) { %>
		            <img src="#" alt="#">
	          <% } %>
	            <%= post.getContent() %>
	          </p>
	        </div>
	
	        <p id="likeBtn">
	          <span><%= post.getLiked() %></span>
	          <i class="fa-regular fa-thumbs-up"></i>
	        </p>
	      </div>
	
	      <div id="postMng">
	        <a href="board05" class="readBtn">삭제 <i class="fa-solid fa-trash-can"></i></a>
	        <a href="board03?num=<%= post.getBoardid() %>" class="readBtn">수정 <i class="fa-solid fa-pencil"></i></a>
	      </div> <!--postMng-->
	    </div> <!--postBox-->
	
	    <div id="commentBox">
	      <div id="commentHead">
	        <div id="commentOpt">
	          <h3>댓글 [<span>3</span>]</h3>
	          <select name="commentSort" id="commentSort">
	            <option value="등록순">등록순</option>
	            <option value="최신순">최신순</option>
	          </select>
	        </div>
	
	        <div id="commentMng">
	          <span onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">본문보기</span>
	          <span>새로고침</span> <!--임시:비동기로 새로고침하는거추가-->
	        </div>
	      </div> <!--commentHead-->
	
	      <div id="commentCont">
	        <div class="comment">
	          <div class="commentInfo">
	            <span class="author">머글</span>
	            <div class="commentAdd">
	              <span class="commentDate">2024-09-01 13:44:23</span>
	              <div class="author-addOns">
	                <span><i class="fa-solid fa-pencil" title="댓글수정"></i></span>
	                <span><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
	              </div>
	            </div>
	          </div>
	          <div class="commentMsg">
	            <p class="text">얘는 골룸이에영</p>
	          </div>
	        </div> <!--comment-->
	
	        <div class="comment">
	          <div class="commentInfo">
	            <span class="author">총균쇠똥구리</span>
	            <div class="commentAdd">
	              <span class="commentDate">2024-09-01 13:44:23</span>
	              <div class="author-addOns">
	                <span><i class="fa-solid fa-pencil" title="댓글수정"></i></span>
	                <span><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
	              </div>
	            </div>
	          </div>
	          <div class="commentMsg">
	            <p class="text">나랑 닮아서 볼때마다 기분나븜</p>
	          </div>
	        </div> <!--comment-->
	
	        <div class="comment">
	          <div class="commentInfo">
	            <span class="author">책읽기는내일부터</span>
	            <div class="commentAdd">
	              <span class="commentDate">2024-09-01 13:44:23</span>
	              <div class="author-addOns">
	                <span><i class="fa-solid fa-pencil" title="댓글수정"></i></span>
	                <span><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
	              </div>
	            </div>
	          </div>
	          <div class="commentMsg">
	            <p class="text">13권에 나옴니다 ! !</p>
	          </div>
	        </div> <!--comment-->
	      </div> <!--commentCont-->
	
	      <form name="commentFrm" id="commentFrm" method="post">
	        <div id="writeComment">
	          <p class="commentAuthor">
	            또또밍기
	          </p>
	          <textarea name="inputComment" placeholder="댓글을 작성해보세요!"></textarea>
	          <button>작성</button>
	        </div>
	      </form>
	    </div> <!--commentBox-->
	
	    <div id="btns"> <!--임시-->
	      <a href="./board01">목록</a>
	      
	      <%
          	// 로그인 검사(session) 결과에 따른 글쓰기버튼
          	if(loginId != null) { %>
	          <a href="./board04">글쓰기</a>
          <%} else { %>
        	  <a href="#" onclick="goLogin()">글쓰기</a>
          <%}%>
	    </div>
	
	  </section>
	
	  
	  <footer>
	    푸터영역
	  </footer>
  </div>
</body>
</html>