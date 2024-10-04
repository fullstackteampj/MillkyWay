<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="beans.MemberBean, beans.BoardBean, beans.BookBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<!-- 글수정 페이지 -->
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String category = request.getParameter("category");
		
	// 글정보 추출
	BoardBean post = bMgr.getPost(num);
	int userid = post.getUserid();
	String genre = post.getGenre();
	String tab = post.getTab();
	String title = post.getTitle();
	String content = post.getContent();
	byte[] photo = null;
	String photoName = null;
	if(post.getPhoto() != null) {
		photo = post.getPhoto();
		photoName = post.getPhotoName();
	}
	int bookid = 0;
	if(post.getBookid() > 0) {
		bookid = post.getBookid();
	}
	int status = post.getStatus();		  // 이미 삭제된 글일 시 접근제한

	
	// 해당번호 글의 userid와 로그인한 userid가 일치하지 않으면 접근제한
	boolean identify = false;
	
	// 로그인 상태면 필요한 데이터 추출(id, nickname)
	Integer loginId = null;
	String loginNickname = null; // 닉네임을 변경하였을 시 글수정 후 데이터에도 반영
	
	if(session != null && session.getAttribute("idKey") != null) {
		loginId = (Integer)session.getAttribute("idKey");
		loginNickname = bMgr.getNickname(loginId);
	
		identify = (userid == loginId);
	}
	
	// 로그인유무로 접근제한
	boolean loginOk = (session != null && loginId != null);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글쓰기 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset copy 2.css?after">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
  <script defer src="${pageContext.request.contextPath}/js/board04.js"></script>
</head>
<body>
  <div id="wrap">
   
    <jsp:include page="../components/header.jsp" />

    <section>
      <h2><a href="board01">은하수 광장✨</a></h2>
      <form action="boardEdit" method="post" name="FrmPost" id="FrmPost" enctype="multipart/form-data" autocomplete="off">
      	<input type="hidden" name="boardid" value="<%=num%>" />
      	<input type="hidden" name="nickname" value="<%=loginNickname%>" />
		<input type="hidden" name="userip" value="<%=request.getRemoteAddr()%>" />
		<input type="hidden" name="category" value="<%=category%>" />
        <div id="writeArea">
          <select name="postGenre" id="postGenre" required>	          
	        <!-- 카테고리목록 출력 -->
	        <%  ArrayList<String> cList = bMgr.getCategoryList();
	        	for(int i=1; i<cList.size(); i++) {%>
	           	<option value="<%=cList.get(i)%>"
	           	<% // 선택했던 카테고리에 selected
	           		if(cList.get(i).equals(genre)) { %> selected <% } %>
	           	><%=cList.get(i)%></option>
	        <% } %>
          </select>
          
          <div id="writeHead">
            <select name="postTab" id="postTab">
            <!-- 탭테이블의 0,1,2 항목은 전체,인기,일반 고정 -->
            <!-- 카테고리목록 출력 -->
	        <%  ArrayList<String> tList = bMgr.getTabList();
	        	for(int i=2; i<tList.size(); i++) {%>
	           	<option value="<%=tList.get(i)%>"
	           	<% // 선택했던 카테고리에 selected
	           		if(cList.get(i).equals(genre)) { %> selected <% } %>
	           	><%=tList.get(i)%></option>
	        <% } %>
            </select>
  
            <input type="text" name="postTit" placeholder="제목을 입력해 주세요." value="<%=title%>" />
          </div>
  
          <div id="postEditor">
            <textarea name="postCont"><%=content%></textarea>
          </div>

        </div>
        
        <div id="uploadArea">
          <h3>첨부파일</h3>

          <div id="upload">
            <ul id="uploadName">
              <% if(photo == null) { %>
              <li>선택된 파일이 없습니다.</li>
              <% } else { %>
              <li><%= photoName %></li>
              <% } %>
            </ul>
            <label for="uploadFile">파일찾기</label>
            <input type="file" name="uploadFile" id="uploadFile" accept="image/*" />
          </div>
        </div>
        
        <div id="bookSearchArea">
          <h3>연관도서</h3>
		  <div id="selectedBook" onclick="postBookFn()">
	  	  <% if(bookid > 0) {
	  	  	 BookBean book = bMgr.getBook(bookid); %>
	  	  	  <img src="/image?bookid=<%= bookid %>" alt="<%=book.getTitle()%>" />
	  	  	  <div>
	  	  	  	<p><%=book.getTitle()%></p>
	  	  	  	<p><%=book.getAuthor()%></p>
	  	  	  </div>
	  	  <% } else { %>
		  	🔍 이 책에 대해 이야기하고 계신가요?
		  <% } %>
		  </div>
		  <input type="hidden" id="postBook" name="postBook" />
		</div>

        <div id="postBtn">
          <button type="button" onclick="cancelChk()">목록</button>
          <button type="button" onclick="writeChk()">작성</button>
        </div>
      </form>
      
      <div id="postBookFrm">
      	<div id="formHead">
	      	<h4>도서 검색</h4>
	      	<i class="fa-solid fa-xmark" onclick="postBookFn()"></i>
      	</div>
      	
      	<input onkeyup="if(window.event.keyCode==13){(postBookSearchFn())}" id="postBookSearch" placeholder="도서명 & 작가명으로 검색해보세요" autocomplete="off" />
      	<ul id="bookSearchList">
   		<%
   		String keyword = " ";
   		ArrayList<BookBean> bList = bMgr.getSearchBookList(keyword);
   		// 추출된 책이 있을경우
		  if(!bList.isEmpty()) {
		  	for(int i=0; i<bList.size(); i++) { 
				BookBean bean = bList.get(i); %>
		   		<li onclick="bookSelectFn(<%=bean.getBookid()%>, '<%=bean.getTitle()%>', '<%=bean.getAuthor()%>')">
		   			<div>
			   			<span><%= bean.getTitle() %></span>
			   			<span><%= bean.getAuthor() %></span>
		   			</div>
		   			<% // 첨부이미지가 있으면 출력
		   			if(bean.getPhoto() != null) { %>
		   			<img src="data:image/jpeg;base64, <%= java.util.Base64.getEncoder().encodeToString(bean.getPhoto()) %>" alt="<%= bean.getTitle() %>">
	   			 <% } else { %>
	   				<img src="https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg" alt="<%= bean.getTitle() %>">
	   			 <% } %>
		   		</li>
	 		<% } %>
	   	<% } %>
      	</ul>
      </div>
      
    </section>

    <footer>
      푸터영역
    </footer>
  </div>

  <script>
	//페이지 로드 시, 로그인이 안되어있거나 글작성자와 로그인유저가 다를시 접근제한 (직접 주소창으로 접근 시 제한)
	window.onload = function() {
		if(!<%=loginOk%> || !<%=identify%> || <%=status!=0%>) {
			alert("권한이 없습니다.");
			location.href = "board02?num=" + <%=num%>;
    	}
  	}
  
  	// 목록보기 버튼
  	function cancelChk() {
  		const result = confirm("작성 중인 내용은 삭제됩니다.\n글 작성을 취소하고 목록으로 돌아가시겠습니까?");
  		if(result) {
  			location.href = "/board/board01?category=<%=category%>";
  		}
  	}
  
  	// 글작성 버튼 - 유효성검사 후 submit
    function writeChk() {
      const $frm = document.FrmPost;

      if($frm.postGenre.value == "") {
        alert("카테고리를 선택해주세요.");
        $frm.selectCategory.focus();
        return;
      }

      if($frm.postTit.value == null || $frm.postTit.value == "") {
        alert("제목을 입력해주세요.");
        $frm.postTit.focus();
        return;
      }

      if($frm.postCont.value == null || $frm.postCont.value == "") {
        alert("내용을 입력해주세요.");
        $frm.postCont.focus();
        return;
      }
      
      // 글 작성자와 로그인유저 id가 다를 시 권한없음
      if(!<%=identify%>) {
    	alert("권한이 없습니다.");
		location.href = "board02?num=" + <%=num%>;
      }
      
      $frm.submit();
      
    }
  </script>
</body>
</html>