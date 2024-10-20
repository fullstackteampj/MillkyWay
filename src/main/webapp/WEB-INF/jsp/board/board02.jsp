<%@page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, beans.BoardBean, beans.CommentBean, beans.MemberBean, beans.BookBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<jsp:useBean id="dMgr" class="board.DateMgr" />
<%-- 글보기 페이지 --%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${post.title} | 은하수책방</title>
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
	    
		<%-- status가 0인 게시글만 내용출력, 9일경우 alert 후 목록으로 이동 --%>
		<c:choose>
			<c:when test="${empty post || post.status != 0}">
				<div id="postBox">
			    </div>
			    <script>
			    	alert("삭제된 게시글입니다.");
			    	location.href="board01";
			    </script>
			</c:when>
	    	<c:otherwise>
	    		<div id="postBox">
			    
			      <div id="readHead">
			        <div id="readHead-top">
			          <p id="readTit">${post.title}</p>
			        </div> <%--readHead-top--%>
			
			        <div id="readHead-bottom">
			          <div id="regInfo">
			            <span id="postAuthor">${post.nickname}</span>
			            <span id="postRegdate">${post.regdate}
			            <%-- 수정됐으면 덧붙임 --%>
			            <c:if test="${post.updateDate != null}">
			            	<span class="edited">(수정됨)</span>
			            </c:if>
			            </span>
			          </div>
			
			          <div id="feedback">
			            <p>조회 <span>${post.count}</span></p>
			            <p>추천 <span>${liked}</span></p>
			            <p onclick="scrollFn('button')">댓글 <span>${activeComCount}</span></p>
			          </div>
			        </div> <%--readHead-bottom--%>
			      </div> <%--readHead--%>
			
			      <div id="readContent">
			        <div id="contentDetail">
			          <%-- 이미지가 존재하면 출력 --%>
			          <c:if test="${post.photo != null}">
			          	<img src="data:image/jpeg;base64, ${post.encodedPhoto}" alt="${post.photoName}">
				        <br />
			          </c:if>
			          <p>
			          	<pre>${post.content}</pre>
			          </p>
			          <%-- 선택한 도서가 존재하면 출력 --%>
			          
			          <c:if test="${post.bookid > 0}">
			          	<div id="bookLink">
			          		<h4>🔍 이야기 중인 책을 알고싶다면?</h4>
				          	<a href="/shop/shop02?bookid=${post.bookid}">
				          		<%-- 첨부이미지가 있으면 출력 --%>
				          		<c:choose>
				          			<c:when test="${book.getPhoto() != null}">
				          				<img src="data:image/jpeg;base64, ${book.encodedPhoto}" alt="${book.title}">
				          			</c:when>
				          			<c:otherwise>
				          				<img src="https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg" alt="${book.title}">
				          			</c:otherwise>
				          		</c:choose>
				          		<p>
				          			<span>${book.title}</span>
				          			<span>${book.author}</span>
				          		</p>
				          	</a>
			          	</div>
			          </c:if>
			        </div>
			
					<%-- 로그인 시에만 글 추천 가능 --%>
					<c:choose>
						<c:when test="${loginId != null}">
							<p id="likeBtn" onclick="uplike(${num}, ${loginId}, this)">
						</c:when>
						<c:otherwise>
							<p id="likeBtn" onclick="alert('로그인이 필요한 서비스 입니다.')">
						</c:otherwise>
					</c:choose>
			        <span>${liked}</span>
			          <i class="fa-regular fa-thumbs-up"></i>
			        </p>
			      </div>
				 <%-- 임시: 개발자용 추천버튼 --%>
		       	 <button type="button" onclick="location.href='forDev/likebug?num=${num}'">개발자용:추천14개(인기글은15개부터)</button>
		      	
				<%-- // 내글일 때만 수정/삭제버튼 --%>
					<c:if test="${loginId != null}">
						<c:if test="${post.userid == loginId}">
							<div id="postMng">
						        <a href="board05?category=${category}&num=${num}" class="readBtn">삭제 <i class="fa-solid fa-trash-can"></i></a>
						        <a href="board03?category=${category}&num=${num}" class="readBtn">수정 <i class="fa-solid fa-pencil"></i></a>
					      	</div> <%--postMng--%>
						</c:if>
					</c:if>			      
			    </div> <%--postBox--%>
			    
				<div id="commentBox" class="commentBox-${num}">
			    
			      <div id="commentHead">
			        <div id="commentOpt">
			          <h3>댓글 [<span>${activeComCount}</span>]</h3>
				          <select name="commentSort" id="commentSort" onchange="commentSort(this, ${num})">
				            <option value="등록순"">등록순</option>
				            <option value="최신순">최신순</option>
				          </select>
			        </div> <%-- div#commentOpt --%>
			
			        <div id="commentMng">
			          <span onclick="scrollFn('post')">본문보기</span>
			        </div> <%-- div#commentMng --%>
			      </div> <%--commentHead--%>
					
				  <div id="commentCont">
					  <%-- 추출된 댓글이 있을경우 --%>
					  <c:if test="${not empty clist}">
					  
					  	<c:forEach var="comment" items="${clist}" varStatus="status">
					  	
					  		<%-- 페이지당 레코드수만큼 출력 --%>
					  		<c:if test="${status.index < paging.numPerPage}">
								<c:choose>
				  				
				  					<%-- status==0인건 정상출력/status=9면서 대댓이있는건 내용대체출력+버튼미출력 --%>
									<c:when test="${comment.status==0}">
										<%-- 만약 depth가 있으면 class에 depth-뎁스값 부여 --%>
										<c:choose>
											<c:when test="${comment.depth > 0}">
												<div class="comment comment-${num} comid-${comment.commentid} depth depth-${comment.depth}">
											</c:when>
											<c:otherwise>
												<div class="comment comment-${num} comid-${comment.commentid}">
											</c:otherwise>
										</c:choose>
											<div class="commentInfo">
									          	<div class="authorInfo">
										            <%-- 글작성자와 댓글작성자가 같을경우 작성자표시 --%>
										            <span class="commentAuthor ${(post.userid == comment.userid) ? 'same' : ''}">${comment.nickname}</span>
										            <%-- 업데이트일이 존재할 시 (수정됨) 출력 --%>
										            <c:if test="${comment.updateDate != null}">
										            	<span class="comUpdate">(수정됨)</span>
										            </c:if>
									          	</div> <%-- .authorInfo --%>
									            
												<div class="commentAdd">
									              <span class="commentDate">${comment.regdate}</span>
									              
									              <%-- 로그인 시에만 답글버튼 --%>
									              <c:if test="${loginId != null}">
									              	<div class="author-addOns">
													<span onclick="toggleReply(this);"><i class="fa-solid fa-reply" title="답글"></i></span>
												 	<%-- 내댓글일 때만 수정/삭제버튼 --%>
												 	<c:if test="${comment.userid == loginId }">
												 		<span onclick="toggleEdit(this);"><i class="fa-solid fa-pencil" title="댓글수정"></i></span>
									                	<span onclick="commentDelete(${comment.commentid}, ${loginId}, ${comment.pos}, ${num}, ${paging.end}, ${comment.userid}, ${paging.nowBlock}, ${paging.nowPage}, ${paging.pagePerBlock}, ${paging.totalPage})"><i class="fa-solid fa-trash-can" title="댓글삭제"></i></span>
												 	</c:if>
												 	</div> <%-- .author-addOns --%>
									              </c:if>
									              
												</div> <%-- commentAdd --%>
											</div> <%-- commentInfo --%>
									          
									        <div class="commentMsg">
									            <p class="text">${comment.content}</p>
											</div>
										</div> <%-- .comment --%>
								        
								        <%-- 댓글수정 폼 (숨김/수정버튼으로 토글) --%>
								        <form action="commentEdit" name="comEditFrm" id="comEditFrm" method="post" autocomplete="off" class="off">
									        <div id="writeComment">
									          <p class="commentAuthor">
									            <span>수정</span>${loginNickname}
									          </p>
									          <textarea name="inputComment" placeholder="댓글을 작성해보세요!">${comment.content}</textarea>
									          <button type="button" onclick="editSubmit(${comment.commentid}, ${loginId}, '${loginNickname}', ${num}, '${userip}', ${paging.end}, ${comment.userid}, ${paging.nowBlock}, ${paging.nowPage}, ${paging.pagePerBlock}, ${paging.totalPage})">수정</button>
									        </div>
										</form>
									        
								        <%-- 대댓글 폼 (숨김/답글버튼으로 토글) --%>
								        <form action="commentReply" name="replyFrm" id="replyFrm" method="post" autocomplete="off" class="off">
									        <div id="writeComment">
									          <p class="commentAuthor">
									            <span>답글</span>${loginNickname}
									          </p>
									          <textarea name="inputComment" placeholder="답글을 작성해보세요!"></textarea>
									          <button type="button" onclick="replySubmit(${comment.commentid}, ${loginId}, '${loginNickname}', ${num}, '${userip}', ${comment.commentid}, ${comment.depth}, ${comment.pos}, ${paging.end}, ${paging.nowBlock}, ${paging.nowPage}, ${paging.pagePerBlock}, ${paging.totalPage})">작성</button>
									        </div>
										</form>
									</c:when> <%-- comment.status==0 --%>
								
									<%-- status=9면서 대댓이있는건 내용대체출력+버튼미출력 --%>
									<c:otherwise>
										
										<%-- 만약 depth가 있으면 class에 depth-뎁스값 부여 --%>
										<c:choose>
											<c:when test="${comment.depth > 0}">
												<div class="comment comment-${num} comid-${comment.commentid} depth depth-${comment.depth}">
											</c:when>
											<c:otherwise>
												<div class="comment comment-${num} comid-${comment.commentid}">
											</c:otherwise>
										</c:choose>
										
								          <div class="commentMsg">
								            <p class="text">삭제된 댓글입니다.</p>
								          </div>
								        </div> <%-- .comment --%>
									</c:otherwise> <%--comment.status==0가 아닌것--%>
								</c:choose>
					  			
					  		</c:if> <%-- if(status.index > paging.numPerPage) --%>
					  	</c:forEach> <%-- clist --%>
					  </c:if> <%--not empty clist --%>
				  </div> <%-- div#commentCont --%>
				
				<%-- 페이지네이션 --%>
				<%-- 게시글이 존재한다면 (paging.totalPage 검사) 페이지네이션 생성(현재블럭의 첫페이지~끝페이지) --%>
				<c:if test="${paging.totalPage != 0}">
					<ul id="comPagination">
				        <%-- 현재 페이지블럭이 첫블럭이 아니라면 '이전블럭으로', '처음페이지로' 버튼 생성 --%>
				        <c:if test="${paging.nowBlock > 1}">
				        	<li class="pageBtn btnFirst" title="첫 페이지로" onclick="goComBlock(this, ${num}, ${paging.nowBlock}, ${paging.pagePerBlock}, ${paging.totalPage}, ${paging.end});"><i class="fa-solid fa-angles-left"></i></li>
					        <li class="pageBtn btnPrev" title="이전 페이지로" onclick="goComBlock(this, ${num}, ${paging.nowBlock}, ${paging.pagePerBlock}, ${paging.totalPage}, ${paging.end});"><i class="fa-solid fa-angle-left"></i></li>
				        </c:if>
				        
				        <c:forEach var="nPage" begin="${paging.pageStart}" end="${paging.pageEnd - 1}">
						    <li onclick="goComPage(${num}, ${paging.nowBlock}, ${paging.pagePerBlock}, ${paging.totalPage}, ${nPage}, ${paging.end})"
						    	<%-- 클릭한 페이지네이션nPage과 클릭시 전송받은 paging.nowPage와 같다면 스타일 적용(li에 class="on") --%>
						        <c:if test="${paging.nowPage == nPage}">
						            class="on"
						        </c:if>
						    >
						        ${nPage}
						    </li>
						</c:forEach>
		        	
		        		<%-- 현재 페이지블럭이 마지막블럭이 아니라면 '다음블럭으로', '마지막페이지로' 버튼생성 --%>
		        		<c:if test="${paging.totalBlock > paging.nowBlock}">
		        			<li class="pageBtn btnNext" title="다음 페이지로" onclick="goComBlock(this, ${num}, ${paging.nowBlock}, ${paging.pagePerBlock}, ${paging.totalPage}, ${paging.end});"><i class="fa-solid fa-angle-right"></i></li>
			          		<li class="pageBtn btnLast" title="마지막 페이지로" onclick="goComBlock(this, ${num}, ${paging.nowBlock}, ${paging.pagePerBlock}, ${paging.totalPage}, ${paging.end});"><i class="fa-solid fa-angles-right"></i></li>
		        		</c:if>
					</ul> <%--#pagination--%>
				</c:if>	<%-- if(paging.totalPage != 0) --%>	        
			   
			   <c:choose>
			   		<%-- 로그인 되어있을 때만 댓글폼 노출 --%>
					<c:when test="${loginId != null}">
						<form name="commentFrm" id="commentFrm" method="post" autocomplete="off">
					        <div id="writeComment">
					          <p class="commentAuthor">
					            ${loginNickname}
					          </p>
					          <textarea name="inputComment" placeholder="댓글을 작성해보세요!"></textarea>
					          <button type="button" onclick="comSubmit(${loginId}, '${loginNickname}', ${num}, '${userip}')">작성</button>
					        </div>
						</form>
					</c:when>
					<c:otherwise>
						<div id="loginNotice">
							<p>로그인 이후에 댓글을 작성할 수 있습니다.</p>
							<a href="/login/login01">로그인 하러가기 👉</a>
						</div>
					</c:otherwise>
			   </c:choose>
			</div> <%--commentBox--%>
			    
			
		    <div id="btns">
		      <a href="./board01?category=${category}">목록</a>
		      <%-- 로그인 검사(session) 결과에 따른 글쓰기버튼 --%>
		      <c:choose>
		      	<c:when test="${loginId != null}">
		      		<a href="./board04?category=${category}">글쓰기</a>
		      	</c:when>
		      	<c:otherwise>
		      		<a href="#" onclick="goLogin()">글쓰기</a>
		      	</c:otherwise>
		      </c:choose>
		    </div>
	    	</c:otherwise> <%-- when(post == null || status != 0)의 otherwise --%>
		</c:choose>
			
		<form action="board02" method="get" name="pageFrm">
	    	<c:if test="${not (category == null || category == '')}">
			    <input type="hidden" name="category" value="${category}" />
			</c:if>
			<input type="hidden" name="num" value="${num}" />
			<c:if test="${paging.nowPage > 0}">
			    <input type="hidden" name="tab" value="${paging.nowPage}" />
			</c:if>
    		<input type="hidden" name="paging.nowPage" />
    	</form>
	  </section>
	  
	  <footer>
	    푸터영역
	  </footer>
  </div>
</body>
</html>