<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="beans.BoardBean, board.DateMgr, beans.MemberBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<!-- 글목록 페이지 -->
<%
	request.setCharacterEncoding("UTF-8");

	MemberBean loginBean = null;
	Integer loginId = null;
	
	if(session != null && session.getAttribute("mBean") != null) {
		loginBean = (MemberBean)session.getAttribute("mBean");
		loginId = loginBean.getUserid();
	}
	
	int totalRecord=0; //전체레코드수
	int numPerPage=10; // 페이지당 레코드 수 
	int pagePerBlock=10; //블럭당 페이지수 
	int totalPage=0; //전체 페이지 수
	int totalBlock=0;  //전체 블럭수 
	int nowPage=1; // 현재페이지
	int nowBlock=1;  //현재블럭
	int start=0; //디비의 select 시작번호
	int end=10; //시작번호로 부터 가져올 select 갯수
	int listSize=0; // DB로부터 추출해 list에 저장한 게시글의 수
	
	// 글목록 필터링
	String keyWord="";
	String keyField="";
	String category="";
	String tab="";
	
	// nowPage를 전송받을 때마다(페이지 클릭, 블럭넘김) 값을 받아 해당페이지 전역에 활용할 수 있도록 nowPage변수 초기화
	if(request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	// 검색할 때마다 keyField, keyWord param에서 받아 변수값 초기화
	if(request.getParameter("keyWord") != null || request.getParameter("keyWord") != "") {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	// 카테고리를 고르면 변수 초기화
	if(request.getParameter("category") != null || request.getParameter("category") != "") {
		category = request.getParameter("category");
	}
	// 탭을 고르면 변수초기화
	if(request.getParameter("tab") != null || request.getParameter("tab") != "") {
		tab = request.getParameter("tab");
	}
	
	
	// 페이지이동 시 게시글을 DB에서 추출할 때 기준이 되는 값을 초기화
	start = (nowPage * numPerPage)-numPerPage; 
	end = numPerPage;
	
	// 페이징, 글목록출력 등에 활용될 변수 초기화 (총게시글수, 총페이지수, 현재블럭, 총블럭수)
	totalRecord = bMgr.getTotalCount(keyField, keyWord, category, tab);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>커뮤니티 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset copy 2.css?after">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <script defer src="${pageContext.request.contextPath}/js/board01.js"></script>
  <script>
  	function goLogin() {
  		const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?");
  		if(result) {
  			location.href = "../login/login01";
  		}
  	}
  </script>
</head>
<body>
  <div id="wrap">

   <jsp:include page="../components/header.jsp" />

    <section>
      <h2 class="sr-only">은하수 광장✨</h2>
      <!-- 임시: 개발자용 로그인/로그아웃 -->
      <div>
      	<button type="button" onclick="location.href='forDev/loginMilky'">밀키 로그인</button>
      	<button type="button" onclick="location.href='forDev/loginToto'">또또 로그인</button>
      	<button type="button" onclick="location.href='forDev/logout'">로그아웃</button>
      </div>
      <article id="category">
        <h3 class="sr-only">카테고리</h3>
        
        <ul>
        <%// 카테고리 목록
        	ArrayList<String> cList = bMgr.getCategoryList();
        	for(int i=0; i<cList.size(); i++) {
        		// param과 비교해 현재 선택된 카테고리에 스타일 적용
        		if(!(category == null || category.equals("")) && category.equals(cList.get(i))) { %>
        			<li class="on">
       		 <% } else if((category == null || category.equals("")) && i==0) { %>
       		 	<!-- param 이 없는 초기상태에는 첫번째항목에 스타일 -->
       		 		<li class="on">
       		 <% } else {%>
       		 		<li>
       		 <% }%>
        		<a href="board01?category=<%=cList.get(i)%>&nowPage=1"><%=cList.get(i)%></a></li>
       	 <% } %>
        </ul>
        
      </article>

      <article id="post">
        
        <div id="head">
          <h2><% // 게시판제목 (전체글, 인문학, 에세이 등)
          	if(category == null || category.equals("전체")) { %>
          	<a href="board01?category=전체&nowPage=1">
          	전체글
          <%} else {%>
          	<a href="board01?category=<%=category%>&nowPage=1"> 
          	<%=category%> 게시판
          <%}%></a>
          </h2>
          
          <ul id="tab">
          <%// 탭 목록
        	ArrayList<String> tList = bMgr.getTabList();
        	for(int i=0; i<tList.size(); i++) {
        		// param과 비교해 현재 선택된 탭에 스타일 적용
        		if(!(tab == null || tab.equals("")) && tab.equals(tList.get(i))) { %>
        			<li class="on">
       		 <% } else if((tab == null || tab.equals("")) && i==0) { %>
       		 	<!-- param 이 없는 초기상태에는 첫번째항목에 스타일 -->
       		 		<li class="on">
       		 <% } else { %>
       		 		<li>
       		 <% }%>
        		<a href="javascript:tabFn('<%=tList.get(i)%>')"><%=tList.get(i)%></a></li>
       	 <% } %>
          </ul>
          
          <%
          	// 로그인 검사(session) 결과에 따른 글쓰기버튼
			if(loginId != null) {
			  if(category != null) {%>
	          <a href="./board04?category=<%=category%>">
           <% } else { %>
        	  <a href="./board04?category=전체">
           <% } %>
        	   글쓰기</a>
          <%} else { %>
        	  <a href="#" onclick="goLogin()">글쓰기</a>
          <%}%>
        </div> <!--#head-->
	
		<% // 검색햇을시
		if(!(keyWord == null || keyWord.equals(""))) { %>
			<p id="searchInfo"><span> <%=category%></span> 게시판의&nbsp;&nbsp;"<span> <%= keyWord %> </span>" 검색결과 입니다.</p>
	<%	} %>
		
		<!-- 글목록 -->
        <div id="list">
        
          <%
          // 글정보 추출
          ArrayList<BoardBean> postList = bMgr.getPostList(keyField, keyWord, category, tab, start, end);
          listSize = postList.size();
          
          // 반복문으로 출력할 게시글이 한페이지게시글수 보다 많으면 그만큼만,
          // 그보다 적으면 가진만큼만 반복
          int forCount = listSize >= numPerPage ? numPerPage : listSize;
          
          if(postList.isEmpty()) { // 추출된 게시글이 없을경우
        	  out.println("<p>등록된 게시물이 없습니다.</p>");
          } else { // 추출된 게시글이 있을경우
        	 
        	
			for(int i=0; i<forCount; i++) {
			 	BoardBean bean = postList.get(i);
			 	int boardid = bean.getBoardid();
			 	String genre = bean.getGenre();
			 	String kind = bean.getTab();
			 	String title = bean.getTitle();
			 	int commentCount = bMgr.getCommentCount(boardid);
			 	String nickname = bean.getNickname();
			 	String regDate = bean.getRegdate();	
			 	String updateDate = bean.getUpdateDate();
			 	int count = bean.getCount();
			 	String best = bean.getBest();
			 	int liked = bMgr.getLikedCount(boardid);
			 	byte[] photo = bean.getPhoto();
			 	
			 	
			 	// 날짜데이터 가공
			 	DateMgr dateMgr = new DateMgr();
			 	
			 	// 오늘날짜 추출
			 	String today = dateMgr.getToday();
			 	// 시:분 (오늘작성글)
			 	String todayPost = dateMgr.getFormatDate(regDate, "today");
			 	// 월-일 (올해이면서 오늘 이전글)
			 	String prevdayPost = dateMgr.getFormatDate(regDate, "yesterday");
			 	// 년-월-일 (올해이전글)
			 	String prevYearPost = dateMgr.getFormatDate(regDate, "lastYear");
			 	
			  %>
			<a href="board02?category=<%=category%>&num=<%=boardid%>">
	            <span class="tab"><%=kind%> / <%=genre%></span>
	            <div class="content">
	            	<p class="title">
	              <% // 인기글이면 제목에 스타일 적용 
	            	 if(best.equals("Y")) {%>
	            	 <span class="overBestLike">
            	  <% } else { %>
            		  <span>
            	  <% } %>
	                <%=title%></span>
	                <% // 댓글이 1개 이상이면 댓글 수 출력
	                  if(commentCount > 0) { %>
	                <span class="commentCount">[<%=commentCount%>]</span>
	                <%}%>
	                
	              </p>
	              <div class="postInfo">
	                <p class="postuser"><%=nickname%></p>
	                <p class="postDate">
	                	<% // 오늘 작성글이면 시:분
	                	   if(dateMgr.getIntDate(regDate, "year") == dateMgr.getIntDate(today, "year") && dateMgr.getIntDate(regDate, "date") == dateMgr.getIntDate(today, "date")) { %>
						       <%=todayPost%>
	                	<% } 
	                	   // 올해이면서 오늘이전 작성글이면 월.일
	                	   else if(dateMgr.getIntDate(regDate, "year") == dateMgr.getIntDate(today, "year") && dateMgr.getIntDate(regDate, "date") < dateMgr.getIntDate(today, "date")) { %>
	                	       <%=prevdayPost%>
	                	<% } 
	                	   // 올해이전 작성글이면 년.월.일
	                	   else if(dateMgr.getIntDate(regDate, "year") < dateMgr.getIntDate(today, "year")) { %>
	                		   <%=prevYearPost%>
	                	<% }
	                	  // 수정됐으면 덧붙임
	                	  if(updateDate != null) { %>
	                	(수정됨)
	                	<% } %>
	                </p>
	                <p class="views">조회 <span><%=count%></span></p>
	                
	                <% // 추천수가 15이상이면 스타일적용
	                   if(liked >= 15) { %>
	                	<p class="like overBestLike">
	                <% } else { %>
	                	<p class="like">
	                <% } %> 추천 <span><%=liked%></span></p>
	              </div>
	            </div>
	            
	            
	            <% // 첨부이미지가 있으면 출력
	               if(photo != null && photo.length > 0) { %>
	            	<p class="frame">
	              		<img src="data:image/jpeg;base64, <%= java.util.Base64.getEncoder().encodeToString(photo) %>" alt="#">
	            	</p>
	            <% } %>
	            
	        </a>
	           
		<%  } // for
          } // else if
          
          %>
        
        </div> <!--list-->
  		<% // 게시글이 존재한다면 (totalPage 검사) 페이지네이션 생성(현재블럭의 첫페이지~끝페이지)
        	if(totalPage != 0) { %>
		<!-- 페이지네이션 -->
        <ul id="pagination">
        <% 
    	// 페이지네이션 생성
    	// 현재 블럭에서의 시작번호 (현재블럭과 블럭당페이지수로 계산)
    	int pageStart = (nowBlock-1)*pagePerBlock+1;
        // 현재 블럭에서의 끝번호 ()
    	int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
    	
        // 현재 페이지블럭이 첫블럭이 아니라면 '이전블럭으로', '처음페이지로' 버튼 생성
        if(nowBlock > 1) { %>
	        <li class="pageBtn btnPrev"><a href="javascript:goPageFn('1')" title="첫 페이지로"><i class="fa-solid fa-angles-left"></i></a></li>
	        <li class="pageBtn btnPrev"><a href="javascript:goPageFn('<%=pageStart-1%>')" title="이전 페이지로"><i class="fa-solid fa-angle-left"></i></a></li>
      <%} //if(nowBlock > 1)
        	
        	
        		for(int nPage=pageStart; nPage<pageEnd; nPage++) { 
        			// 클릭한 페이지네이션nPage과 클릭시 전송받은 nowPage와 같다면 스타일 적용(li에 class="on")
        			if(nPage == nowPage) { %>
        				<li class="on">
       			<%  } else { %>
       					<li>
       			<%	}%>
		        	<a href="javascript:goPageFn('<%=nPage%>')"><%= nPage %></a>
		        	</li>
       		  <%} //for(int nPage=pageStart; nPage<pageEnd; nPage++)
        	
        	// 현재 페이지블럭이 마지막블럭이 아니라면 '다음블럭으로', '마지막페이지로' 버튼생성
        	if(totalBlock > nowBlock) { %>
				<li class="pageBtn btnNext"><a href="javascript:goPageFn('<%=pageStart+pagePerBlock%>')"  title="다음 페이지로"><i class="fa-solid fa-angle-right"></i></a></li>
          		<li class="pageBtn btnNext"><a href="javascript:goPageFn('<%=totalPage%>')" title="마지막 페이지로"><i class="fa-solid fa-angles-right"></i></a></li>
          <% } //if(totalBlock > nowBlock) { %>
        </ul> <!--#pagination-->
        
       <% } //if(totalPage != 0) %>
  
        <div id="postSearch">
          <form action="board01" method="get" name="frmPostSearch" autocomplete="off">
            <select name="keyField" id="keyField">
              <option value="multiple">제목+내용</option>
              <option value="title">제목</option>
              <option value="content">내용</option>
              <option value="nickname">작성자</option>
            </select>
  
            <input type="text" name="keyWord" id="keyWord" required />
            
    		<% if(!(category == null || category.equals(""))) {%>
    		<input type="hidden" name="category" value="<%=category%>" />
    		<% } %>
    	
    		<% if(!(tab == null || tab.equals(""))) {%>
    		<input type="hidden" name="tab" value="<%=tab%>" />
    		<% } %>
  
            <button>검색</button>
          </form>
        </div> <!--postSearch-->

      </article> <!-- #post-->

      <article id="bestPost">
        <h3><a href="http://localhost:8080/board/board01?nowPage=1&tab=인기">실시간 인기글</a></h3>
        
        <% // 인기글 목록 출력 
        	ArrayList<BoardBean> bestList = bMgr.getBestList();
        	if(bestList.isEmpty()) {
        		out.println("<p>등록된 인기글이 없습니다.</p>");
        	} else {
        		int roofCount = bestList.size() >= 6 ? 6 : bestList.size();
        		%>
        		<ul>
        	 <% for(int i=0; i<roofCount; i++) {
        		 BoardBean bBean = bestList.get(i);
        		 int bBoardid = bBean.getBoardid();
        		 String bTitle = bBean.getTitle(); %>
          		<li><a href="board02?num=<%=bBoardid%>"><%=bTitle%></a></li>
          	 <% }
          	 }%>
        </ul>
      </article>

    </section>

    <footer>
      푸터영역
    </footer>
    
    <form action="board01" method="get" name="pageFrm">
    	
    	<% if(!(keyWord == null || keyWord.equals(""))) {%>
    	<input type="hidden" name="keyField" value="<%=keyField%>" />
    	<input type="hidden" name="keyWord" value="<%=keyWord%>" />
    	<% } %>
    	<% if(!(category == null || category.equals(""))) {%>
    	<input type="hidden" name="category" value="<%=category%>" />
    	<% } %>
    	<% if(!(tab == null || tab.equals(""))) {%>
    	<input type="hidden" name="tab" value="<%=tab%>" />
    	<% } %>
    	
    	<input type="hidden" name="nowPage" />
    </form>
    
    <form action="board01" method="get" name="tabFrm">
    
    	<% if(!(keyWord == null || keyWord.equals(""))) {%>
    	<input type="hidden" name="keyField" value="<%=keyField%>" />
    	<input type="hidden" name="keyWord" value="<%=keyWord%>" />
    	<% } %>
    	
    	<% if(!(category == null || category.equals(""))) {%>
    	<input type="hidden" name="category" value="<%=category%>" />
    	<% } %>
    	
    	<input type="hidden" name="nowPage" value="1" />
    	<input type="hidden" name="tab" />
    </form>
    
  </div>
  <script>
    // 페이지버튼 href로 실행되는 함수 : 현재 글페이지값, 글검색값 등의 값을 전송하는 폼 submit
  	function goPageFn(page) {
  		document.pageFrm.nowPage.value = page;
  		document.pageFrm.submit();
  	}

  	function tabFn(tab) {
  		document.tabFrm.tab.value = tab;
  		document.tabFrm.submit();
  	}  	
  </script>
</body>
</html>