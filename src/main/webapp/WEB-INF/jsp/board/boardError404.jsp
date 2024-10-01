<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 에러 페이지 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제 | 은하수책방</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset copy 2.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<script defer src="${pageContext.request.contextPath}/js/header.js"></script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../components/header.jsp" />
		
		<section>
			<h2><a href="./board01">은하수 광장✨</a></h2>
	
			<div id="postBox">
				<div id="errorNotice">
					<p><i class="fa-solid fa-circle-exclamation"></i> 존재하지 않는 게시물입니다.</p>
					<p>잠시 후 글 목록 페이지로 이동합니다.</p>
				</div>
			</div>
		</section>
		
		<footer>
			푸터영역
		</footer>
	</div>
</body>
</html>