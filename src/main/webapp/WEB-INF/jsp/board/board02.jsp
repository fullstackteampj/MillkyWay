<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, board.BoardBean, board.CommentBean, beans.MemberBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");

	MemberBean loginBean = (MemberBean)session.getAttribute("mBean");
	Integer loginId = loginBean.getUserid();
	String loginNickname = loginBean.getNickname();
	int boardid = Integer.parseInt(request.getParameter("num"));
	BoardBean post = bMgr.getPost(boardid);
	
	int totalRecord=0; //전체레코드수
	int numPerPage=30; // 페이지당 레코드 수 
	int pagePerBlock=10; //블럭당 페이지수 
	int totalPage=0; //전체 페이지 수
	int totalBlock=0;  //전체 블럭수 
	int nowPage=1; // 현재페이지
	int nowBlock=1;  //현재블럭
	int start=0; //디비의 select 시작번호
	int end=10; //시작번호로 부터 가져올 select 갯수
	int listSize=0; // DB로부터 추출해 list에 저장한 게시글의 수
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글제목 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset copy 2.css?after">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
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
	          <% // 이미지가 존재하면 출력
	          	 if(post.getPhoto().length > 0) { %>
		            <img src="data:image/jpeg;base64, <%= java.util.Base64.getEncoder().encodeToString(post.getPhoto()) %>" alt="#">
		            <br />
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
	          <h3>댓글 [<span><%= bMgr.getCommentCount(boardid) %></span>]</h3>
	          <select name="commentSort" id="commentSort">
	            <option value="등록순">등록순</option>
	            <option value="최신순">최신순</option>
	          </select>
	        </div> <!-- div#commentOpt -->
	
	        <div id="commentMng">
	          <span onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">본문보기</span>
	          <span>새로고침</span> <!--임시:비동기로 새로고침하는거추가-->
	        </div> <!-- div#commentMng -->
	      </div> <!--commentHead-->
	
	
	      
	      
	      <% ArrayList<CommentBean> clist = bMgr.getCommentList(boardid); 
			listSize = clist.size();
          
          // 반복문으로 출력할 댓글이 한페이지게시글수 보다 많으면 그만큼만,
          // 그보다 적으면 가진만큼만 반복
          int forCount = 0;
          if(listSize >= numPerPage) {forCount = numPerPage;}
          else {forCount = listSize;}
          
          if(!clist.isEmpty()) {// 추출된 게시글이 있을경우 %>
		<div id="commentCont">
        <%
			for(int i=0; i<forCount; i++) {
				CommentBean bean = clist.get(i);
				String nickname = bean.getNickname();
				String regdate = bean.getRegdate();
				String content = bean.getContent();
				int userid = bean.getUserid();
		%>
	    	<div class="comment">
	    	
	          <div class="commentInfo">
	            <% // 글작성자와 댓글작성자가 같을경우 작성자표시
	            if(post.getUserid() == userid) { %>
	            	<span class="author same">
	         <% } else { %>
	            	<span class="author">
	         <% } %>
	            <%=nickname%></span>
	            
	            <div class="commentAdd">
	              <span class="commentDate"><%=regdate%></span>
	              
	              <div class="author-addOns">
	                <span><i class="fa-solid fa-reply" title="답글"></i></span>
	                <span><i class="fa-solid fa-pencil" title="댓글수정"></i></span>
	                <span><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
	              </div>
	            </div>
	            
	          </div>
	          
	          <div class="commentMsg">
	            <p class="text"><%=content%></p>
	          </div>
	        </div> <!--comment-->
	     <% } //for %>
		</div> <!--commentCont-->
	   <% } // if%>
	     	        
	      
	
	      <form action="boardComment" name="commentFrm" id="commentFrm" method="post">
	      	<input type="hidden" name="userid" value="<%=loginId%>">
	      	<input type="hidden" name="nickname" value="<%=loginNickname%>">
	      	<input type="hidden" name="ref" value="<%=boardid%>">
	      	<input type="hidden" name="userip" value="<%=request.getRemoteAddr()%>">
	        <div id="writeComment">
	          <p class="commentAuthor">
	            <%=loginNickname%>
	          </p>
	          <textarea name="inputComment" placeholder="댓글을 작성해보세요!"></textarea>
	          <button type="button" onclick="javascript:commentChk()">작성</button>
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
  <script>
	function goLogin() {
		const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?");
		if(result) {
			location.href = "/login/login01";
		}
	}
	
	function commentChk() {
		const frm = document.commentFrm;
		if(frm.inputComment.value == "" || frm.inputComment.value == null) {
			alert("내용이 입력되지 않았습니다.");
			frm.inputComment.focus();
			return;
		}
		
		frm.submit();
	}
  </script>
</body>
</html>