<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="beans.BoardBean, beans.CommentBean, beans.MemberBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");

	// 서블릿 req에서 필요한 데이터 추출
	int num = (int)request.getAttribute("boardid");	
	int postuser = (int)request.getAttribute("postuser");
	
	Integer loginId = null;
	String loginNickname = null;
	
	// 로그인 상태면 필요한 데이터 추출(id, nickname)
	if(session != null && session.getAttribute("idKey") != null) {
		loginId = (Integer)session.getAttribute("idKey");
		loginNickname = bMgr.getNickname(loginId);
	}
	
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
	
	// 페이징, 글목록출력 등에 활용될 변수 초기화 (총게시글수, 총페이지수, 현재블럭, 총블럭수)
	totalRecord = (int)request.getAttribute("commentCount");
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
	
	// 페이지네이션 초기화
	if(request.getAttribute("nowBlock") != null) {
		nowBlock = (int)request.getAttribute("nowBlock");    		
	}
	// 현재 블럭에서의 시작번호 (현재블럭과 블럭당페이지수로 계산)
	int pageStart = (nowBlock-1)*pagePerBlock+1;
    if(request.getAttribute("pageStart") != null) {
    	pageStart = (int)request.getAttribute("pageStart");
    }
	
    // 현재 블럭에서의 끝번호 ()
   	int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
	if(request.getAttribute("pageEnd") != null) {
        pageEnd = (int)request.getAttribute("pageEnd");    		
	}
	
	if(request.getAttribute("nowPage") != null) {
		nowPage = (int)request.getAttribute("nowPage");    		
	}
	
	// 페이지이동 시 게시글을 DB에서 추출할 때 기준이 되는 값을 초기화
	start = (nowPage-1)*numPerPage;
	if(request.getAttribute("start") != null) {
		start = (int)request.getAttribute("start");    		
	}
	end = numPerPage;
	if(request.getAttribute("end") != null) {
		end = (int)request.getAttribute("end");    		
	}
	//start = ((nowPage-1)*numPerPage)+bMgr.getTotalPrevDelCount(num, nowPage, numPerPage);
	//end = numPerPage+bMgr.getDeleteComCount(num, start, numPerPage);
	
	int commentCount = (int)request.getAttribute("commentCount");
	ArrayList<CommentBean> clist = (ArrayList<CommentBean>)request.getAttribute("clist");
	
	int activeComCount = bMgr.getActiveComCount(num);
%>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 댓글</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset copy 2.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<script defer src="${pageContext.request.contextPath}/js/header.js"></script>
<script defer src="${pageContext.request.contextPath}/js/board02.js"></script>
</head>
<body>
	<div id="commentHead">
	        <div id="commentOpt">
	          <h3>댓글 [<span><%= activeComCount %></span>]</h3>
	          <select name="commentSort" id="commentSort">
	            <option value="등록순">등록순</option>
	            <option value="최신순">최신순</option>
	          </select>
	        </div> <!-- div#commentOpt -->
	
	        <div id="commentMng">
	          <span onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">본문보기</span>
	        </div> <!-- div#commentMng -->
      </div> <!--commentHead-->
	
      <% listSize = clist.size();
         
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
	    	<div class="comment comment-<%=num%> comid-<%=commentId%>
	    		<%if(comDepth > 0) {%> depth depth-<%=comDepth%>"
	    		<% int depthPx = comDepth <= 16 ?  (30 * comDepth) : (30 * 16); %>
	    		style="margin-left: <%=depthPx%><%}%>px;">
	    	
	          <div class="commentInfo">
	            <div class="authorInfo">
		            <% // 글작성자와 댓글작성자가 같을경우 작성자표시
		           		if(postuser == comUserid) {%>
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
                <span onclick="commentDelete(<%=commentId%>, <%=loginId%>, <%=comPos%>, <%=num%>, <%=end%>, <%=comUserid%>, <%=nowBlock%>, <%=nowPage%>, <%=pagePerBlock%>, <%=totalPage%>);"><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
             <% } %>
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
   		  } else if(comStatus==9) { %>
        	<div class="comment comment-<%=num%> comid-<%=commentId%>
    		<%if(comDepth > 0) {%> depth depth-<%=comDepth%>"
    		<% int depthPx = comDepth <= 16 ?  (30 * comDepth) : (30 * 16); %>
    		style="margin-left: <%=depthPx%><%}%>px;">
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
	        <li class="pageBtn btnFirst" title="첫 페이지로" onclick="goComBlock(this, <%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=end%>);"><i class="fa-solid fa-angles-left"></i></li>
	        <li class="pageBtn btnPrev" title="이전 페이지로"  onclick="goComBlock(this, <%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=end%>);"><i class="fa-solid fa-angle-left"></i></li>
      <%} //if(nowBlock > 1)
       	
       	
      for(int nPage=pageStart; nPage<pageEnd; nPage++) { %>
		<!-- 클릭한 페이지네이션nPage과 클릭시 전송받은 nowPage와 같다면 스타일 적용(li에 class="on") -->
		<li onclick="goComPage(<%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=nPage%>, <%=end%>)"
		<% if(nowPage == nPage) { %>class="on" <% } %>><%=nPage%></li>
	  <%} //for(int nPage=pageStart; nPage<pageEnd; nPage++)

		// 현재 페이지블럭이 마지막블럭이 아니라면 '다음블럭으로', '마지막페이지로' 버튼생성
	 		if(totalBlock > nowBlock) { %>
			<li class="pageBtn btnNext" title="다음 페이지로" onclick="goComBlock(this, <%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=end%>);"><i class="fa-solid fa-angle-right"></i></li>
	   		<li class="pageBtn btnLast" title="마지막 페이지로" onclick="goComBlock(this, <%=num%>, <%=nowBlock%>, <%=pagePerBlock%>, <%=totalPage %>, <%=end%>);"><i class="fa-solid fa-angles-right"></i></li>
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
		          <button type="button" onclick="comSubmit(<%=loginId%>, '<%=loginNickname%>', <%=num%>, '<%=request.getRemoteAddr()%>', <%=start%>, <%=end%>)">작성</button>
		        </div>
			</form>
	<% } else { %>
			<div id="loginNotice">
				<p>로그인 이후에 댓글을 작성할 수 있습니다.</p>
				<a href="/login/login01">로그인</a>
			</div>
	<% } %>
</body>
</html>