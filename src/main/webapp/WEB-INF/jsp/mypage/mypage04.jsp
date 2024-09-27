<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@ page import="beans.BoardBean" %>
<jsp:useBean id="myMgr" class="myPage.MyPageMgr" />
<%
	if (session.getAttribute("idKeyS") == null) {
	    %>
	    <script>
	        alert("세션이 만료되었습니다. 로그인 페이지로 이동합니다.");
	        location.href="/login/login01";
	    </script>
	    <%
	    return;
	}
	String userId = (String) session.getAttribute("idKeyS");
%>

<%
	//페이징 기법
	int totalRecord = myMgr.getTotalMyBoardCount(Integer.parseInt(userId)); // 전체 레코드 수
	// int totalRecord = 51;
	int numPerPage = 9; // 페이지당 레코드 수
	int pagePerBlock = 10; // 블럭당 페이지 수
	
	int totalPage = (totalRecord + numPerPage - 1) / numPerPage; // 전체 페이지 수
	int totalBlock = (totalPage + pagePerBlock - 1) / pagePerBlock; // 전체 블록 수
	
	int nowPage = 1; // 현재 페이지
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int nowBlock = (nowPage - 1) / pagePerBlock + 1; // 현재 블록 번호
	
	int start = (nowPage * numPerPage) - numPerPage; // DB의 셀렉트 시작번호
	int end = numPerPage; // 시작번호로 부터 가져올 셀렉트의 갯수
	
	int listSize = 0; //현재 읽어온 게시물의 수
%>
      
	<script>
	<%--
	alert("<%=totalRecord%>");
	alert("<%=totalBlock%>");
	--%>
	function paging(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value) {
	    // 블록 번호를 기준으로 시작 페이지 계산
	    const pagePerBlock = <%= pagePerBlock %>;
	    const newPage = pagePerBlock * (value - 1) + 1;
	    document.readFrm.nowPage.value = newPage;
	    document.readFrm.submit();
	} 
	</script>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>mypage04</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?after" />
  <script defer src="https://kit.fontawesome.com/9ad59cd5cc.js" crossorigin="anonymous"></script>
  <script defer src="${pageContext.request.contextPath}/js/myPage04.js?after"></script>

</head>

<body>

  <div id="wrap">

    <jsp:include page="../components/header.jsp" />

    <section  class="myPage04">
      <h2 class="sr-only">회원페이지</h2>
      
       <jsp:include page="../components/myPageSectionHead.jsp" />

      <div class="mainContainer">
        <h3>내가 쓴 글</h3>
        <ul class="myBoardList">
	      	<%
     		Vector<BoardBean> myBoardList = myMgr.getMyBoardList(Integer.parseInt(userId), start, end);
	      	for(int i=0; i<myBoardList.size(); i++) {
	      		BoardBean bean = myBoardList.get(i);
	      		%>
		    	<li>
		            <div class="boardContainer">
		              <p class="title"><%=bean.getTitle() %></p>
		              <p class="regDate"><%=bean.getRegdate() %></p>
		              <p class="content"><%=bean.getContent() %></p>
		            </div>
		            
		            <div class="controls">
		              <i class="fa-solid fa-chevron-down on"></i>
		              <i class="fa-solid fa-chevron-up"></i>
		              <button type="button">
		              	<a href="/board/board01?boardid=<%=bean.getBoardid()%>">수정</a>
		              </button>
		              <button type="button" onClick="javascript:delCheck(<%=bean.getBoardid()%>)">
		             	  	삭제
		            	      </button>
		            </div>
	         	</li>
	      		<%
	      	}//for
	      	%>
        </ul>
        
        <!-- 레코드 출력 종료 -->

		<!-- 페이지 및 블럭 처리 시작 -->

		<ul class="listSeletor">
          <%
        	int pageStart = (nowBlock - 1)*pagePerBlock + 1;
			// 하단 페이지 시작번호
			int pageEnd = (pageStart + pagePerBlock) <= totalPage ? pageStart + pagePerBlock : totalPage + 1;
			// 하단 페이지 끝 번호
			if(totalPage != 0){
				if(nowBlock > 1){
					%>
					<li>
						<a href="javascript:block('<%= nowBlock - 1 %>')">prev</a>
					</li>
					<%
				}//if(nowBlock > 1)
				
				for( ; pageStart<pageEnd; pageStart++){
					if(pageStart==nowPage){
						%>
						<li class="on">
							<a href="javascript:paging('<%= pageStart %>')">
							[<%= pageStart %>]
							</a>
						</li>
						<%
					}else{
						%>
						<li>
							<a href="javascript:paging('<%= pageStart %>')">
							[<%= pageStart %>]
							</a>
						</li>
						<%
					}
				}//for( ; pageStart<pageEnd; pageStart++)
							
				if (totalBlock > nowBlock ) {
					%>
					<li>
						<a href="javascript:block('<%=nowBlock + 1%>')">next</a>
					</li>
					<%
				}//if(totalBlock > nowBlock )
			}//if(totalPage != 0)
      		%>
        </ul>
        
        <form name="readFrm" method="get">
			<input type="hidden" name="nowPage" value="<%= nowPage %>" />
		</form>
		
      </div>
    </section>


	<jsp:include page="../components/footer.jsp" />

	<jsp:include page="../components/aside.jsp" />

  </div>

<script>
	function delCheck(boardId) {
		if(confirm("정말로 게시글을 영구히 삭제하시겠습니까?\n삭제된 글은 다시 불러올 수 없습니다.")) {
			location.href = "/procs/BoardDel?boardId=" + boardId;
		}else{
			return;
		}
	}
</script>

</body>

</html>