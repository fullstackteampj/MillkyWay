<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.BoardBean, beans.CommentBean, beans.MemberBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<jsp:useBean id="dMgr" class="board.DateMgr" />
<!-- 글보기 페이지 -->
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	
	// 조회수 증가
	bMgr.upCount(num);
	
	MemberBean loginBean = null;
	Integer loginId = null;
	String loginNickname = null;
	// 로그인 상태면 필요한 데이터 추출(id, nickname)
	if(session != null && session.getAttribute("mBean") != null) {
		loginBean = (MemberBean)session.getAttribute("mBean");
		loginId = loginBean.getUserid();
		loginNickname = loginBean.getNickname();
	}
	
	BoardBean post = bMgr.getPost(num);
	// 글정보 추출
	String title = post.getTitle();
	String nickname = post.getNickname();
	String regdate = post.getRegdate();
	String updateDate = post.getUpdateDate();
	int count = post.getCount();
	int liked = bMgr.getLikedCount(num);
	byte[] photo = post.getPhoto();
	String content = post.getContent();
	int userid = post.getUserid();
	int status = post.getStatus();
	
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
  <script defer src="${pageContext.request.contextPath}/js/board02.js"></script>
</head>
<body>
  <div id="wrap">
	  <jsp:include page="../components/header.jsp" />
	 
	  <section>
	    <h2><a href="./board01">은하수 광장✨</a></h2>
	    
		<% // status가 0인 게시글만 내용출력, 9일경우 alert 후 목록으로 이동
	    if(post != null && status == 0) { %>
	    <div id="postBox">
	    
	      <div id="readHead">
	        <div id="readHead-top">
	          <p id="readTit"><%=title%></p>
	        </div> <!--readHead-top-->
	
	        <div id="readHead-bottom">
	          <div id="regInfo">
	            <span id="postAuthor"><%=nickname%></span>
	            <span id="postRegdate"><%=regdate%>
	            <%// 수정됐으면 덧붙임
               	if(updateDate != null) { %>
               		<span class="edited">(수정됨)</span>
             <% } %>
	            </span>
	          </div>
	
	          <div id="feedback">
	            <p>조회 <span><%=count%></span></p>
	            <p>추천 <span><%=liked%></span></p>
	          </div>
	        </div> <!--readHead-bottom-->
	      </div> <!--readHead-->
	
	      <div id="readContent">
	        <div id="contentDetail">
	          <% // 이미지가 존재하면 출력
	          	 if(photo != null && photo.length > 0) { %>
		            <img src="data:image/jpeg;base64, <%= java.util.Base64.getEncoder().encodeToString(photo) %>" alt="#">
		            <br />
	          <% } %>
	          <p>
	          	<pre><%=content%></pre>
	          </p>
	        </div>
	
	        <p id="likeBtn" onclick="
	        <% // 로그인 시에만 글 추천 가능
	           if(loginBean != null) { %>
	        	uplike(<%=num%>, <%=loginId%>, this)
	        <% } else { %>
	        	alert('로그인이 필요한 서비스 입니다.')
	        <% } %>
	        ">
	          <span><%=liked%></span>
	          <i class="fa-regular fa-thumbs-up"></i>
	        </p>
	      </div>
		 <!-- 임시: 개발자용 추천버튼 -->
       	 <button type="button" onclick="location.href='forDev/likebug?num=<%=num%>'">추천버그버튼(인기글은15개부터)</button>
      	
		<% // 내글일 때만 수정/삭제버튼
			if(loginBean != null) { 
				if(userid == loginId) {%>
		  <div id="postMng">
	        <a href="board05?num=<%=num%>" class="readBtn">삭제 <i class="fa-solid fa-trash-can"></i></a>
	        <a href="board03?num=<%=num%>" class="readBtn">수정 <i class="fa-solid fa-pencil"></i></a>
	      </div> <!--postMng-->
		<%		}
			} %>
	      
	    </div> <!--postBox-->
	
	    <div id="commentBox" class="commentBox-<%=num%>">
	    
	      <div id="commentHead">
	        <div id="commentOpt">
	          <h3>댓글 [<span><%= bMgr.getCommentCount(num) %></span>]</h3>
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
	
	      <% ArrayList<CommentBean> clist = bMgr.getCommentList(num); 
			listSize = clist.size();
          
          // 반복문으로 출력할 댓글이 한페이지댓글수 보다 많으면 그만큼만,
          // 그보다 적으면 가진만큼만 반복
          int forCount = 0;
          if(listSize >= numPerPage) {forCount = numPerPage;}
          else {forCount = listSize;}
          %>
		<div id="commentCont">
		<%
          if(!clist.isEmpty()) {// 추출된 댓글이 있을경우
        	  
			for(int i=0; i<forCount; i++) {
				CommentBean bean = clist.get(i);
				int commentId = bean.getCommentid();
				String comNickname = bean.getNickname();
				String comRegdate = bean.getRegdate();
				String comContent = bean.getContent();
				int comUserid = bean.getUserid();
				int comPos = bean.getPos();
				int comDepth = bean.getDepth();
		%>
	    	<div class="comment comment-<%=num%>">
	    	
	          <div class="commentInfo">
	            <% // 글작성자와 댓글작성자가 같을경우 작성자표시
	           		if(userid == comUserid) {%>
	            	<span class="author same">
	           <% } else { %>
	            	<span class="author">
	         	 <% } %>
	            <%=comNickname%></span>
	            
	            <div class="commentAdd">
	              <span class="commentDate"><%=comRegdate%></span>
	              
	              <div class="author-addOns">
	              	<% // 로그인 시에만 답글버튼
					if(loginBean != null) { %>
						<span onclick="toggleReply(this);"><i class="fa-solid fa-reply" title="답글"></i></span>
				 <% } %>
	                <% // 내댓글일 때만 수정/삭제버튼
					if(loginBean != null) { 
						if(comUserid == loginId) {%>
	                <span onclick="toggleEdit(this);"><i class="fa-solid fa-pencil" title="댓글수정"></i></span>
	                <span><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
	                <%	}
					} %>
	                
	              </div> <!-- .author-addOns -->
	            </div> <!-- commentAdd -->
	            
	          </div> <!-- commentInfo -->
	          
	          <div class="commentMsg">
	            <p class="text"><%=comContent%></p>
	          </div>
	        </div> <!-- .comment -->
	        
	        <!-- 댓글수정 폼 (숨김/수정버튼으로 토글) -->
	        <form action="commentEdit" name="comEditFrm" id="comEditFrm" method="post" autocomplete="off" class="off">
		        <div id="writeComment">
		          <p class="commentAuthor">
		            <span>수정</span><%=loginNickname%>
		          </p>
		          <textarea name="inputComment" placeholder="댓글을 작성해보세요!"><%=comContent%></textarea>
		          <button type="button" onclick="replySubmit()">수정</button>
		        </div>
		        
		        
		        <input type="hidden" name="userid" value="<%=loginId%>" />
		      	<input type="hidden" name="nickname" value="<%=loginNickname%>" />
		      	<input type="hidden" name="ref" value="<%=num%>" />
		      	<input type="hidden" name="parent_commentid" value="<%=commentId%>" />
		      	<input type="hidden" name="pos" value="<%=comPos%>" />
		      	<input type="hidden" name="depth" value="<%=comDepth%>" />
		      	<input type="hidden" name="userip" value="<%=request.getRemoteAddr()%>" />
			</form>
	        
	        <!-- 대댓글 폼 (숨김/답글버튼으로 토글) -->
	        <form action="commentReply" name="replyFrm" id="replyFrm" method="post" autocomplete="off" class="off">
		      	<input type="hidden" name="userid" value="<%=loginId%>" />
		      	<input type="hidden" name="nickname" value="<%=loginNickname%>" />
		      	<input type="hidden" name="ref" value="<%=num%>" />
		      	<input type="hidden" name="parent_commentid" value="<%=commentId%>" />
		      	<input type="hidden" name="pos" value="<%=comPos%>" />
		      	<input type="hidden" name="depth" value="<%=comDepth%>" />
		      	<input type="hidden" name="userip" value="<%=request.getRemoteAddr()%>" />
		        <div id="writeComment">
		          <p class="commentAuthor">
		            <span>답글</span><%=loginNickname%>
		          </p>
		          <textarea name="inputComment" placeholder="댓글을 작성해보세요!"></textarea>
		          <button type="button" onclick="replySubmit()">작성</button>
		        </div>
			</form>
	     <% } //for %>
	   <% } // if%>
		</div> <!--commentCont-->
	   
		<% // 로그인 되어있을 때만 댓글폼 노출
			if(loginBean != null) { 
			 	
			 	// 오늘날짜 추출
			 	String today = dMgr.getToday();
			%>
				<form name="commentFrm" id="commentFrm" method="post" autocomplete="off">
			        <div id="writeComment">
			          <p class="commentAuthor">
			            <%=loginNickname%>
			          </p>
			          <textarea name="inputComment" placeholder="댓글을 작성해보세요!"></textarea>
			          <button type="button" onclick="comSubmit(<%=loginId%>, '<%=loginNickname%>', <%=num%>, '<%=request.getRemoteAddr()%>', '<%=userid%>', '<%=today%>')">작성</button>
			        </div>
				</form>
		<% } else { %>
			<p>로그인 이후에 댓글을 작성할 수 있습니다.</p>
		<% } %>
	      
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
	    <% } else {// if(status == 9) %>
	    <div id="postBox">
	    </div>
	    <script>
	    	alert("삭제된 게시글입니다.");
	    	location.href="board01";
	    </script>
		<% } %>
	  </section>
	
	  
	  <footer>
	    푸터영역
	  </footer>
  </div>
</body>
</html>