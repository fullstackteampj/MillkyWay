<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="beans.BoardBean, beans.BookBean, beans.MemberBean, beans.BoardFilterBean, beans.boardPagingBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<jsp:useBean id="dMgr" class="board.DateMgr" />
<%
	String readPosts = (String)request.getAttribute("readPosts");
%>
<!-- 글목록 페이지 -->
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
</head>
<body>
	<c:set var="loginId" value="${loginId}" />
	<c:set var="filter" value="${filter}" />
	
  <div id="wrap">

	<jsp:include page="../components/header.jsp" />
    <section>
      <h2 class="sr-only">은하수 광장✨</h2>
      <article id="category">
        <h3 class="sr-only">카테고리</h3>
        
        <ul>
        <c:forEach var="categoryItem" items="${cList}">
        	<c:choose>
        		<%-- 현재 선택된 카테고리에 스타일 적용 --%>
        		<c:when test="${not empty filter.category && filter.category == categoryItem}">
        			<li class="on">
        		</c:when>
        		<c:otherwise >
        			<%-- 초기상태에는 첫번째항목에 스타일 --%>
        			<c:if test="${empty filter.category && status.index == 0}">
        				<li class="on">
        			</c:if>
        			<%-- 그 외는 스타일X --%>
        			<c:if test="${not empty filter.category || status.index > 0}">
        				<li>
        			</c:if>
        		</c:otherwise>
        	</c:choose>
        	<a href="board01?category=${categoryItem}&nowPage=1">${categoryItem}</a></li>
       	 </c:forEach>
        </ul>
        
      </article>

      <article id="post">
        
        <div id="head">
          <h2>
          	<c:choose>
          		<c:when test="${empty filter.category || filter.category == '전체'}">
	          		<a href="board01?category=전체&nowPage=1">전체글</a>          		
          		</c:when>
          		<c:otherwise>
          			<a href="board01?category=${filter.category}&nowPage=1">${filter.category} 게시판</a>
          		</c:otherwise>
          	</c:choose>
          </h2>
          
          <ul id="tab">
          	<c:forEach var="tabItem" items="${tList}">
       			<li class="${filter.tab == tabItem ? 'on' : ''}">
       				<a href="javascript:tabFn('${tabItem}')">${tabItem}</a>
       			</li>
          	</c:forEach>
          </ul>
          
          <%-- 로그인검사에 따른 글쓰기버튼 --%>
          <c:choose>
          	<c:when test="${not empty loginId}">
          		<c:choose>
          			<c:when test="${not empty filter.category}">
          				<a href="./board04?category=${filter.category}">글쓰기</a>
          			</c:when>
          			<c:otherwise>
          				<a href="./board04?category=전체">글쓰기</a>
          			</c:otherwise>
          		</c:choose>
          	</c:when>
          	
          	<c:otherwise>
          		<a href="#" onclick="goLogin()">글쓰기</a>
          	</c:otherwise>
          </c:choose>
        </div> <%--#head--%>
	
		<c:if test="${not empty filter.keyWord}">
			<p id="searchInfo">
				<span>${filter.category}</span> 게시판의 <span>" ${filter.keyWord} "</span> 검색결과 입니다.
			</p>
		</c:if>
		
		<%-- 글목록 --%>
        <div id="list">
        	<c:choose>
        		<%-- 추출된 게시글이 없는경우 --%>
        		<c:when test="${empty postList}">
        			<p><span>" ${filter.category} / ${filter.tab} "</span>에 등록된 게시물이 없습니다.</p>
        		</c:when>
        		<%-- 있는경우 --%>
        		<c:otherwise>
        			<%-- 게시글 출력 --%>
        			<c:forEach var="post" items="${postList}">
        				<a href="board02?category=${filter.category}&num=${post.boardid}">
				            <span class="kind">${post.tab} / ${post.genre}</span>
				            
				            <div class="content">
				            	<p class="contentHead">
				            		<%-- 인기글이면 제목에 스타일 적용 --%>
					            	<c:choose>
					            		<%-- 인기글 --%>
					            		<c:when test="${post.best == 'Y'}">
					            			<%-- 쿠키를 검사해 읽었던 글이면 스타일적용 --%>
					            			<c:choose>
					            				<%-- 읽었던글 --%>
					            				<c:when test="${readPosts.contains(String.valueOf(post.boardid))}">
					            					<span class="title overBestLike read">${post.title}</span>
					            				</c:when>
					            				<%-- 읽었던글 아님 --%>
					            				<c:otherwise>
					            					<span class="title overBestLike">${post.title}</span>
					            				</c:otherwise>
					            			</c:choose>
					            		</c:when>
					            		<%-- 인기글 아님 --%>
					            		<c:otherwise>
					            			<c:choose>
						            			<%-- 읽었던글 --%>
					            				<c:when test="${readPosts.contains(String.valueOf(post.boardid))}">
					            					<span class="title read">${post.title}</span>
					            				</c:when>
					            				<%-- 읽었던글 아님 --%>
					            				<c:otherwise>
					            					<span class="title">${post.title}</span>
					            				</c:otherwise>
				            				</c:choose>
					            		</c:otherwise>
					            	</c:choose>
				              		<%-- 댓글이 존재하면 댓글수 출력 --%>
				              		<c:set var="activeComCount" value="${bMgr.getActiveComCount(post.boardid)}"></c:set>
				              		<c:if test="${activeComCount > 0}">
				              			<span class="commentCount">[${activeComCount}]</span>
				              		</c:if>
								</p>
				              	
								<div class="postInfo">
									<p class="postuser">${post.nickname}</p>
									<p class="postDate">
										<c:set var="today" value="${dMgr.getToday()}" />
										<%-- 오늘 작성글이면 시:분 --%>
										<c:choose>
											<c:when test="${dMgr.getIntDate(post.regdate, 'year') == dMgr.getIntDate(today, 'year') && dMgr.getIntDate(post.regdate, 'date') == dMgr.getIntDate(today, 'date')}">
												${dMgr.getFormatDate(post.regdate, 'today')}
											</c:when>
											<%-- 올해이면서 오늘이전 작성글이면 월.일 --%>
											<c:when test="${dMgr.getIntDate(post.regdate, 'year') == dMgr.getIntDate(today, 'year') && dMgr.getIntDate(post.regdate, 'date') < dMgr.getIntDate(today, 'date')}">
	                                            ${dMgr.getFormatDate(post.regdate, 'yesterday')}
	                                        </c:when>
	                                        <%-- 올해이전 작성글이면 년.월.일 --%>
	                                        <c:otherwise>
	                                            ${dMgr.getFormatDate(post.regdate, 'lastYear')}
	                                        </c:otherwise>
										</c:choose>
										<%-- 수정됐으면 덧붙임 --%>
										<c:if test="${not empty post.updateDate}">(수정됨)</c:if>
									</p>
									<p class="views">조회 <span>${post.count}</span></p>
									<%-- 추천수가 15이상이면 스타일적용 --%>
									<c:set var="liked" value="${bMgr.getLikedCount(post.boardid)}"></c:set>
									<p class="${liked >= 15 ? 'like overBestLike' : 'like'}">추천 <span>${liked}</span></p>
								</div> <%-- div.postInfo --%>
								
							</div> <%-- div.content --%>
								
							<%-- 첨부이미지가 있으면 출력 --%>
							<c:if test="${not empty post.photo}">
								<p class="frame">
                                	<img src="data:image/jpeg;base64, ${post.encodedPhoto}" alt="${post.photoName}">
                                	<%-- <img src="data:image/jpeg;base64, ${fn:escapeXml(java.util.Base64.getEncoder().encodeToString(post.photo))}" alt="${post.photoName}">
										 <img src="data:image/jpeg;base64, <= java.util.Base64.getEncoder().encodeToString(photo) %>" alt="<=photoName%>"> --%>
								</p>
							</c:if>
							
						</a>
        			</c:forEach>
        		</c:otherwise>
        	</c:choose>
        
        </div> <%-- #list --%>
        
        <%-- 게시글이 존재한다면 (totalPage 검사) 페이지네이션 생성(현재블럭의 첫페이지~끝페이지) --%>
		<c:set var="paging" value="${paging}" />
        <c:if test="${paging.totalPage != 0}">
        
			<%-- 페이지네이션 --%>
        	<ul id="pagination">
				<%-- 현재 페이지블럭이 첫블럭이 아니라면 이전 블럭/첫페이지로 버튼 --%>
	        	<c:if test="${paging.nowBlock > 1 }">
	        		<li class="pageBtn btnPrev">
	        			<a href="javascript:goPageFn('1')" title="첫 페이지로">
	        				<i class="fa-solid fa-angles-left"></i>
	        			</a>
	        		</li>
		        	<li class="pageBtn btnPrev">
		        		<a href="javascript:goPageFn('${paging.pageStart - 1}')" title="이전 페이지로">
		        			<i class="fa-solid fa-angle-left"></i>
		        		</a>
		        	</li>
	        	</c:if> <%-- if(paging.nowBlock > 1) --%>
	        	
	        	<c:forEach var="nPage" begin="${paging.pageStart}" end="${paging.pageEnd - 1}">
	        		<%-- 클릭한 페이지네이션과 현재페이지가 같다면 스타일 적용 --%>
	        		<li class="${nPage == paging.nowPage ? 'on' : ''}">
	        			<a href="javascript:goPageFn('${nPage}')">${nPage}</a>
	        		</li>
	        	</c:forEach>
	        	
	        	<%-- 현재 페이지블럭이 마지막블럭이 아니라면 다음 블럭/마지막페이지로 버튼 --%>
	        	<c:if test="${paging.totalBlock > paging.nowBlock}">
	        		<li class="pageBtn btnNext">
	        			<a href="javascript:goPageFn('${paging.pageStart + paging.pagePerBlock}')"  title="다음 페이지로">
	        				<i class="fa-solid fa-angle-right"></i>
	        			</a>
	        		</li>
          			<li class="pageBtn btnNext">
	          			<a href="javascript:goPageFn('${paging.totalPage}')" title="마지막 페이지로">
	          				<i class="fa-solid fa-angles-right"></i>
	          			</a>
          			</li>
	        	</c:if>
        	</ul> <%-- #pagination --%>
        </c:if> <%-- if(paging.totalPage != 0) --%>
  
        <div id="postSearch">
          <form action="board01" method="get" name="frmPostSearch" autocomplete="off">
            <select name="keyField" id="keyField">
              <option value="multiple">제목+내용</option>
              <option value="title">제목</option>
              <option value="content">내용</option>
              <option value="nickname">작성자</option>
            </select>
  
            <input type="text" name="keyWord" id="keyWord" required />
            
            <c:if test="${not empty filter.category}">
            	<input type="hidden" name="category" value="${filter.category}" />
            </c:if>
    	
            <c:if test="${not empty filter.tab}">
            	<input type="hidden" name="category" value="${filter.tab}" />
            </c:if>
            <button>검색</button>
          </form>
        </div> <%--postSearch--%>
        
	  <%-- 임시: 개발자용 글복사버그 
	  <button type="button" onclick="location.href='forDev/postbug?category=<category%>'">글복사버그</button>--%>

      </article> <%-- #post--%>

	  <div id="rightBox">
	      <article id="bestPost">
	        <h3><a href="http://localhost:8080/board/board01?nowPage=1&tab=인기">🌟 실시간 인기글</a></h3>
	        
	        <c:choose>
	        	<c:when test="${empty bestList}">
	        		<p>등록된 인기글이 없습니다.</p>
	        	</c:when>
	        	<c:otherwise>
	        		<ul>
		        		<c:forEach var="bBean" items="${bestList}" varStatus="status">
		        			<c:if test="${status.index < 6}">
		        				<li><a href="board02?num=${bBean.boardid}">${bBean.title}</a></li>
		        			</c:if>
		        		</c:forEach>
	        		</ul>
	        	</c:otherwise>
	        </c:choose>
	      </article>
	      
	      <article id="bestBook">
	      	<h3>🔥 지금 핫한 책</h3>
	      	<i class="fa-solid fa-circle-question"></i>
	      	<span>최근 50개의 글 중 연관도서로 많이 언급된 도서목록입니다.</span>
	      	
	      	<c:choose>
	      		<c:when test="${empty bestBookList}">
	      			<p>최근 언급된 도서가 없습니다.</p>
	      		</c:when>
	      		<c:otherwise>
	      			<ul>
	      				<c:forEach var="bestBookInfo" items="${bestBookList}" varStatus="status">
	      					<c:if test="${status.index < 10}">
	                            <c:set var="bookid" value="${bestBookInfo[0]}" />
	                            <c:set var="mentionedCount" value="${bestBookInfo[1]}" />
	                            <c:set var="book" value="${bMgr.getBook(bookid)}" />
				          		<li>
					          		<a href="/shop/shop02?bookid=${bookid}">
					          			<p>
					          				<span>${book.title}</span> 
                                        	<span>(${book.genre})</span>
					          			</p>
					          			<span>${mentionedCount}회</span>
					          		</a>
				          		</li>
	      					</c:if> <%-- if(status.index < 10) --%>
	      				</c:forEach>
	      			</ul>
	      		</c:otherwise>
	      	</c:choose>
	      </article>
	  </div>
	  
    </section>

    <footer>
      푸터영역
    </footer>
    
    <form action="board01" method="get" name="pageFrm">
	    <c:if test="${not empty filter.keyWord}">
	        <input type="hidden" name="keyField" value="${filter.keyField}" />
	        <input type="hidden" name="keyWord" value="${filter.keyWord}" />
	    </c:if>
	    <c:if test="${not empty filter.category}">
	        <input type="hidden" name="category" value="${filter.category}" />
	    </c:if>
	    <c:if test="${not empty filter.tab}">
	        <input type="hidden" name="tab" value="${filter.tab}" />
	    </c:if>
	    
	    <input type="hidden" name="nowPage" />
	</form>
	
	<form action="board01" method="get" name="tabFrm">
	    <c:if test="${not empty filter.keyWord}">
	        <input type="hidden" name="keyField" value="${filter.keyField}" />
	        <input type="hidden" name="keyWord" value="${filter.keyWord}" />
	    </c:if>
	    
	    <c:if test="${not empty filter.category}">
	        <input type="hidden" name="category" value="${filter.category}" />
	    </c:if>
	    
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