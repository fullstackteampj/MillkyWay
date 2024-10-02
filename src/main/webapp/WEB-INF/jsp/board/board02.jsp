<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.BoardBean, beans.CommentBean, beans.MemberBean, beans.BookBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<jsp:useBean id="dMgr" class="board.DateMgr" />
<!-- 글보기 페이지 -->
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	
	// 조회수 증가
	bMgr.upCount(num);
	
	Integer loginId = null;
	String loginNickname = null;
	
	// 로그인 상태면 필요한 데이터 추출(id, nickname)
	if(session != null && session.getAttribute("idKey") != null) {
		loginId = (Integer)session.getAttribute("idKey");
		loginNickname = bMgr.getNickname(loginId);
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
	String photoName = post.getPhotoName();
	String content = post.getContent();
	int userid = post.getUserid();
	int status = post.getStatus();
	int bookid = post.getBookid();
	
	// 댓글 페이징
	int totalRecord=0; //전체레코드수
	int numPerPage=10; // 페이지당 레코드 수 
	int pagePerBlock=5; //블럭당 페이지수 
	int totalPage=0; //전체 페이지 수
	int totalBlock=0;  //전체 블럭수
	int nowPage=1; // 현재페이지
	int nowBlock=1;  //현재블럭
	int start=0; //디비의 select 시작번호
	int end=numPerPage; //시작번호로 부터 가져올 select 갯수
	int listSize=0; // DB로부터 추출해 list에 저장한 댓글 수
	
	
	// 페이지이동 시 게시글을 DB에서 추출할 때 기준이 되는 값을 초기화
	start = (nowPage-1)*numPerPage;
	end = numPerPage;
	
	// 페이징, 글목록출력 등에 활용될 변수 초기화 (총게시글수, 총페이지수, 현재블럭, 총블럭수)
	totalRecord = bMgr.getCommentCount(num);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산

	// 페이지네이션 변수 초기화
	// 현재 블럭에서의 시작번호 (현재블럭과 블럭당페이지수로 계산)
	int pageStart = (nowBlock-1)*pagePerBlock+1;
    // 현재 블럭에서의 끝번호 ()
	int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
    
	String category="";

	// 카테고리를 고르면 변수 초기화
	if(request.getParameter("category") != null || request.getParameter("category") != "") {
		category = request.getParameter("category");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%=title%> | 은하수책방</title>
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
	            <p onclick="scrollFn('button')">댓글 <span><%=bMgr.getCommentCount(num)%></span></p>
	          </div>
	        </div> <!--readHead-bottom-->
	      </div> <!--readHead-->
	
	      <div id="readContent">
	        <div id="contentDetail">
	          <% // 이미지가 존재하면 출력
	          	 if(photo != null && photo.length > 0) { %>
		            <img src="data:image/jpeg;base64, <%= java.util.Base64.getEncoder().encodeToString(photo) %>" alt="<%=photoName%>">
		            <br />
	          <% } %>
	          <p>
	          	<pre><%=content%></pre>
	          </p>
	          <% // 선택한 도서가 존재하면 출력
	          	if(bookid > 0) { 
	          		BookBean book = bMgr.getBook(bookid);
	          	%>
	          	
	          	<div id="bookLink">
	          		<h4>🔍 이야기 중인 책을 알고싶다면?</h4>
		          	<a href="/shop/shop02?bookid=<%=bookid%>">
		          		<% // 첨부이미지가 있으면 출력
		                if(book.getPhoto() != null) { %>
			   			<img src="data:image/jpeg;base64, <%= java.util.Base64.getEncoder().encodeToString(book.getPhoto()) %>" alt="<%= book.getTitle() %>">
		   			 <% } else { %>
		   			 	<img src="https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg" alt="<%= book.getTitle() %>">
		   			 <% } %>
		          		<p>
		          			<span><%=book.getTitle()%></span>
		          			<span><%=book.getAuthor()%></span>
		          		</p>
		          	</a>
	          	</div>
	          <% } %>
	        </div>
	
	        <p id="likeBtn" onclick="
	        <% // 로그인 시에만 글 추천 가능
	           if(loginId != null) { %>
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
			if(loginId != null) { 
				if(userid == loginId) {%>
		  <div id="postMng">
	        <a href="board05?category=<%=category%>&num=<%=num%>" class="readBtn">삭제 <i class="fa-solid fa-trash-can"></i></a>
	        <a href="board03?category=<%=category%>&num=<%=num%>" class="readBtn">수정 <i class="fa-solid fa-pencil"></i></a>
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
	          <span onclick="scrollFn('post')">본문보기</span>
	        </div> <!-- div#commentMng -->
	      </div> <!--commentHead-->
	
	      <% ArrayList<CommentBean> clist = bMgr.getCommentList(num, start, end);
			listSize = clist.size();
			
          
          // 반복문으로 출력할 댓글이 한페이지댓글수 보다 많으면 그만큼만,
          // 그보다 적으면 가진만큼만 반복
          int forCount = 0;
          if(listSize >= numPerPage) {forCount = numPerPage;}
          else {forCount = listSize;}
          %>
  		
      	<div id="commentCont"> 
		<%// 추출된 댓글이 있을경우
          if(!clist.isEmpty()) { %>
		  <% for(int i=0; i<forCount; i++) {
				CommentBean bean = clist.get(i);
				int commentId = bean.getCommentid();
				String comNickname = bean.getNickname();
				String comRegdate = bean.getRegdate();
				String comContent = bean.getContent();
				int comUserid = bean.getUserid();
				int comPos = bean.getPos();
				int comDepth = bean.getDepth();
				int comStatus = bean.getStatus();
				String comUpdate = bean.getUpdateDate();
				
				//status==0인건 정상출력/status=9면서 대댓이있는건 내용대체출력+버튼미출력
				// 만약 depth가 있으면 class에 depth-뎁스값 부여
		        if(comStatus==0) { %>
	    	<div class="comment comment-<%=num%> comid-<%=commentId%><%if(comDepth > 0) {%> depth depth-<%=comDepth%><%}%>" >
	    	
	          <div class="commentInfo">
	          	<div class="authorInfo">
		            <% // 글작성자와 댓글작성자가 같을경우 작성자표시
		           		if(userid == comUserid) {%>
		            	<span class="commentAuthor same">
		            <% } else { %>
		            	<span class="commentAuthor">
		         	<% } %>
		            <%=comNickname%></span>
		            
		            <% // 업데이트일이 존재할 시 (수정됨) 출력
		            	if(comUpdate != null) { %>
		            	<span class="comUpdate">(수정됨)</span>
		            <% } %>
	          	</div> <!-- .authorInfo -->
	            
	            <div class="commentAdd">
	              <span class="commentDate"><%=comRegdate%></span>
	              
              	<% // 로그인 시에만 답글버튼
				if(loginId != null) { %>
	              <div class="author-addOns">
					<span onclick="toggleReply(this);"><i class="fa-solid fa-reply" title="답글"></i></span>
				 
               	<% // 내댓글일 때만 수정/삭제버튼
					if(comUserid == loginId) {%>
	                <span onclick="toggleEdit(this);"><i class="fa-solid fa-pencil" title="댓글수정"></i></span>
	                <span onclick="commentDelete(<%=commentId%>, <%=loginId%>, <%=comPos%>, <%=num%>, <%=end%>, <%=comUserid%>, <%=nowBlock%>, <%=nowPage%>, <%=pagePerBlock%>, <%=totalPage%>)"><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
	            <%	} %>
	              </div> <!-- .author-addOns -->
         	<% } //if(loginId != null) %>
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
		          <button type="button" onclick="editSubmit(<%=commentId%>, <%=loginId%>, '<%=loginNickname%>', <%=num%>, '<%=request.getRemoteAddr()%>', <%=end%>, <%=comUserid%>, <%=nowBlock%>, <%=nowPage%>, <%=pagePerBlock%>, <%=totalPage%>)">수정</button>
		        </div>
			</form>
	        
	        <!-- 대댓글 폼 (숨김/답글버튼으로 토글) -->
	        <form action="commentReply" name="replyFrm" id="replyFrm" method="post" autocomplete="off" class="off">
		        <div id="writeComment">
		          <p class="commentAuthor">
		            <span>답글</span><%=loginNickname%>
		          </p>
		          <textarea name="inputComment" placeholder="답글을 작성해보세요!"></textarea>
		          <button type="button" onclick="replySubmit(<%=commentId%>, <%=loginId%>, '<%=loginNickname%>', <%=num%>, '<%=request.getRemoteAddr()%>', <%=commentId%>, <%=comDepth%>, <%=comPos%>, <%=end%>, <%=nowBlock%>, <%=nowPage%>, <%=pagePerBlock%>, <%=totalPage%>)">작성</button>
		        </div>
			</form>
			
	        <% // status=9면서 대댓이있는건 내용대체출력+버튼미출력
	          } else if(comStatus==9 && bMgr.hasComReply(commentId)) { %>
	        	<div class="comment comment-<%=num%> comid-<%=commentId%><%if(comDepth > 0) {%> depth depth-<%=comDepth%><%}%>">
		    	
		          <div class="commentInfo">
		            <div class="authorInfo">
		            <% // 글작성자와 댓글작성자가 같을경우 작성자표시
		           		if(userid == comUserid) {%>
		            	<span class="commentAuthor same">
		            <% } else { %>
		            	<span class="commentAuthor">
		         	<% } %>
		            <%=comNickname%></span>
	          	</div> <!-- .authorInfo -->
		            
		            <div class="commentAdd">
		              <span class="commentDate"><%=comRegdate%></span>
		            </div> <!-- commentAdd -->
		            
		          </div> <!-- commentInfo -->
		          
		          <div class="commentMsg">
		            <p class="text">삭제된 댓글입니다.</p>
		          </div>
	        	</div> <!-- comment -->
	        <% } // else if(status==9)
	     	} //for(int i=0; i<forCount; i++) %>
     <% } // if(!clist.isEmpty())%>
	  	</div> <!--commentCont-->
		
		
		<!-- 페이지네이션 -->
		<%// 게시글이 존재한다면 (totalPage 검사) 페이지네이션 생성(현재블럭의 첫페이지~끝페이지)
        if(totalPage != 0) { %>
	        <ul id="comPagination">
	        <%   	
	        // 현재 페이지블럭이 첫블럭이 아니라면 '이전블럭으로', '처음페이지로' 버튼 생성
	        if(nowBlock > 1) { %>
		        <li class="pageBtn btnPrev" title="첫 페이지로"><i class="fa-solid fa-angles-left"></i></li>
		        <li class="pageBtn btnPrev" title="이전 페이지로" onclick="goPrevBlock(<%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=end%>);"><i class="fa-solid fa-angle-left"></i></li>
	      <%} //if(nowBlock > 1)
        	
        	
        		for(int nPage=pageStart; nPage<pageEnd; nPage++) { %>
        			<!-- 클릭한 페이지네이션nPage과 클릭시 전송받은 nowPage와 같다면 스타일 적용(li에 class="on") -->
        			<li onclick="goComPage(<%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=nPage%>, <%=end%>)"
        			<% if(nowPage == nPage) { %>class="on" <% } %>
        			><%=nPage%></li>
       		  <%} //for(int nPage=pageStart; nPage<pageEnd; nPage++)
        	
        	// 현재 페이지블럭이 마지막블럭이 아니라면 '다음블럭으로', '마지막페이지로' 버튼생성
        	if(totalBlock > nowBlock) { %>
				<li class="pageBtn btnNext" title="다음 페이지로" onclick="goNextBlock(<%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=end%>);"><i class="fa-solid fa-angle-right"></i></li>
          		<li class="pageBtn btnNext" title="마지막 페이지로" onclick="goLastPage(<%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=end%>);"><i class="fa-solid fa-angles-right"></i></li>
          <% } //if(totalBlock > nowBlock) %>
        	</ul> <!--#pagination-->
      <% } // if(totalPage != 0)%>
        
	   
		<% // 로그인 되어있을 때만 댓글폼 노출
			if(loginId != null) { 
			 	
			 	// 오늘날짜 추출
			 	// String today = dMgr.getToday(); --페이지가 로드되었을 때 기준시각
			%>
				<form name="commentFrm" id="commentFrm" method="post" autocomplete="off">
			        <div id="writeComment">
			          <p class="commentAuthor">
			            <%=loginNickname%>
			          </p>
			          <textarea name="inputComment" placeholder="댓글을 작성해보세요!"></textarea>
			          <!-- <button type="button" onclick="comSubmit(<%=loginId%>, '<%=loginNickname%>', <%=num%>, '<%=request.getRemoteAddr()%>', '<%=userid%>')">작성</button> -->
			          <button type="button" onclick="comSubmit(<%=loginId%>, '<%=loginNickname%>', <%=num%>, '<%=request.getRemoteAddr()%>', <%=start%>, <%=end%>)">작성</button>
			        </div>
				</form>
		<% } else { %>
			<div id="loginNotice">
				<p>로그인 이후에 댓글을 작성할 수 있습니다.</p>
				<a href="/login/login01">로그인</a>
			</div>
		<% } %>
	      
	    </div> <!--commentBox-->
	    
	
	    <div id="btns"> <!--임시-->
	      <a href="./board01">목록</a>
	      <%
          	// 로그인 검사(session) 결과에 따른 글쓰기버튼
          	if(loginId != null) { %>
	          <a href="./board04?category=<%=category%>">글쓰기</a>
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
		
		<form action="board02" method="get" name="pageFrm">
    	
    	<% if(!(category == null || category.equals(""))) {%>
    	<input type="hidden" name="category" value="<%=category%>" />
    	<% } %>
    	<input type="hidden" name="num" value="<%=num%>" />
    	<% if(nowPage > 0) {%>
    	<input type="hidden" name="tab" value="<%=nowPage%>" />
    	<% } %>
    	
    	<input type="hidden" name="nowPage" />
    	</form>
	  </section>
	
	  
	  <footer>
	    푸터영역
	  </footer>
  </div>
</body>
</html>