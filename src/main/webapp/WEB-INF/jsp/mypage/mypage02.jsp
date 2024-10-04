<%request.setCharacterEncoding("utf-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="beans.BookBean"%>
<%@page import="beans.CancelBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="myMgr" class="myPage.MyPageMgr"/>
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
	int totalRecord = myMgr.getTotalCanCount(Integer.parseInt(userId)); // 전체 레코드 수
	int numPerPage = 5; // 페이지당 레코드 수
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
	    const pagePerBlock = <%=pagePerBlock%>;
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
  <title>mypage02</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?after" />
  <script defer src="https://kit.fontawesome.com/9ad59cd5cc.js" crossorigin="anonymous"></script>

</head>

<body>

  <div id="wrap">

    <jsp:include page="../components/header.jsp" />

    <section class="myPage02">
      <h2 class="sr-only">회원페이지</h2>
      
       <jsp:include page="../components/myPageSectionHead.jsp" />

      <div class="mainContainer">
        <h3>취소/반품내역</h3>
        <ul class="cancelList">
	        <%
	        Vector<CancelBean> canList = myMgr.getCanList(Integer.parseInt(userId), start, end);
	        
	       	for(int i=0; i < canList.size(); i++) {
	       		
	       		CancelBean cBean = canList.get(i);
	       		int bookid = cBean.getBookid();
	       		
	       		BookBean bBean = myMgr.getMyBookInfo(bookid);
	       		String userName = myMgr.getUserName(Integer.parseInt(userId));
	        	%>
				<li>
				  <img src="/image?bookid=<%= bookid %>" alt="<%= bBean.getTitle() %>" />
				  <div class="bookInfo">
				    <p class="buydate"><%= cBean.getCancellation_date() %> 결제</p>
				    <p class="title"><%= bBean.getTitle() %></p>
				    <p class="author"><%= bBean.getAuthor() %></p>
				    <p class="price"><%= bBean.getPrice() %>원</p>
				  </div>
				
				  <div class="content">
				    <p class="status"><%= cBean.getStatus() %></p>
				    <p class="buyId">결제금액: <%= bBean.getPrice()*cBean.getQuantity() %>원</p>
				    <p class="reciever">수령인:<%= userName %></p>
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

</body>

</html>