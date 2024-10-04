<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%-- 수정/삭제 폼 데이터 비동기 출력을 위한 페이지 --%>
	<%-- 수정/삭제 요청에 따른 action 경로 구분 --%>
	<c:choose>
		<c:when test="${event == 'update'}">
			<form action="updateBook" method="post" name="updateBookFrm" id="updateBookFrm" enctype="multipart/form-data">
		</c:when>
		<c:otherwise>
			<form action="deleteBook" method="post" name="updateBookFrm" id="updateBookFrm" enctype="multipart/form-data">
		</c:otherwise>
	</c:choose>
		
		<input type="hidden" name="requestid" value="${bookid}" />
		
		<div id="bookInfoWrap">
			<div class="topContainer">
				<c:if test="${not empty book}">
					<img src="data:image/jpeg;base64, ${book.encodedPhoto}" alt="${book.title}" />
				</c:if>
				
				<%-- 수정일때만 파일업로드(수정) 가능 --%>
				<c:if test="${event == 'update'}">
					<div class="inputPhoto">
						<label for="photo">도서 표지사진</label><br />
						<input type="file" name="photo" id="photo" onchange="previewImage(event)" />
						<%-- <input type="text" name="photoText" /> 수정 : 태그 삭제 --%>
					</div>
				</c:if>
				
				<%-- 수정 / 삭제 요청에 따른 input 속성 구분 (수정-required / 삭제-readonly) --%>
				<ul class="shortInput">
					<li>
						<label for="title">도서 제목</label>
						<input type="text" name="title" id="title" value="${not empty book ? book.title : ''}" 
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
					
					<li>
						<label for="author">도서 작가</label>
						<input type="text" name="author" id="author" value="${not empty book ? book.author : ''}"
						${event == 'update' ? 'required' : 'readonly'}   />
					</li>
					
					<li>
						<label for="category">도서 카테고리</label>
						<select name="category" id="category"
						${event == 'update' ? 'required' : 'readonly'} >
							<c:forEach var="category" items="${categories}">
								<option value="${category}"
									<c:if test="${book.category == category}">selected</c:if> >
									${category}
								</option>
							</c:forEach>
						</select>
					</li>
					
					<li>
						<label for="genre">도서 장르</label>
						<input type="text" name="genre" id="genre" value="${not empty book ? book.genre : ''}" 
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
					
					<li>
						<label for="review">도서 리뷰</label>
						<input type="text" name="review" id="review" value="${not empty book ? book.review : ''}" placeholder="한줄로 간단히 작성" 
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
					
					<li>
						<label for="publish_date">도서 출판일</label>
						<input type="text" name="publish_date" id="publish_date" placeholder="2000-01-01 형식으로 작성" value="${not empty book ? book.publish_date : ''}"
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
						
					<li>
						<label for="isbn">도서 isbn</label>
						<input type="text" name="isbn" id="isbn" placeholder="숫자만 작성" value="${not empty book ? book.isbn : ''}" 
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
					
					<li>
						<label for="stock_Quantity">도서 재고</label>
						<input type="text" name="stock_Quantity" id="stock_Quantity" placeholder="숫자만 작성" value="${not empty book ? book.stock_Quantity : ''}" 
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
					
					<li>
						<label for="price">도서 가격</label>
						<input type="text" name="price" id="price" placeholder="숫자만 작성" value="${not empty book ? book.price : ''}" 
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
					
					<li>
						<label for="pages">도서 페이지수</label>
						<input type="text" name="pages" id="pages" placeholder="숫자만 작성" value="${not empty book ? book.pages : ''}" 
						${event == 'update' ? 'required' : 'readonly'} />
					</li>
				</ul><!-- .shortInputr -->

			</div><!-- .topContainer -->
		
			<ul>
				<li>
					<label for="contents">도서 내용 요약글</label><br />
					<input type="text" name="contents" id="contents" value="${not empty book ? book.contents : ''}" 
					${event == 'update' ? 'required' : 'readonly'} />
				</li>
				
				<li>
					<label for="authorIntro">저자 소개</label><br />
					<input type="text" name="authorIntro" id="authorIntro" value="${not empty book ? book.authorIntro : ''}" 
					${event == 'update' ? 'required' : 'readonly'} />
				</li>
				
				<li>
					<label for="contentsTables">목차</label><br />
					<input type="text" name="contentsTables" id="contentsTables" value="${not empty book ? book.contentsTables : ''}" 
					${event == 'update' ? 'required' : 'readonly'} />
				</li>
				
				<li>
					<label for="miniIntro">간단 소개글</label><br />
					<input type="text" name="miniIntro" id="miniIntro" value="${not empty book ? book.miniIntro : ''}" 
					${event == 'update' ? 'required' : 'readonly'} />
				</li>
			</ul>
		</div> <!-- bookInfoWrap -->
		
		<c:choose>
			<c:when test="${event == 'update'}">
				<button>도서 정보 수정</button>
			</c:when>
			<c:otherwise>
				<button type="button" onclick="deleteWarning()">도서 정보 삭제</button>
			</c:otherwise>
		</c:choose>
		
	</form>
</body>"
</html>