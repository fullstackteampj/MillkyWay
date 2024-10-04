<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.MemberBean, beans.BoardBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<!-- 글삭제 페이지 -->
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String category = request.getParameter("category");
	
	Integer loginId = null;
	
	BoardBean post = bMgr.getPost(num);
	int userid = post.getUserid();
		
	// 해당번호 글의 userid와 로그인한 userid가 일치하지 않으면 접근제한
	boolean identify = false;

	// 로그인 상태면 필요한 데이터 추출(id, nickname)
	if(session != null && session.getAttribute("idKey") != null) {
		loginId = (Integer)session.getAttribute("idKey");
	
		identify = (userid == loginId);
	}
	
	// 로그인유무로 접근제한
	boolean loginOk = (session != null && loginId != null);
	
%>
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
				<div id="deleteArea">
					<p><i class="fa-solid fa-circle-exclamation"></i> 삭제된 게시물은 복구할 수 없습니다.</p>
					<form action="boardDelete" method="post" name="delFrm" id="delFrm" autocomplete="off">
						<input type="hidden" name="userid" value="<%=userid%>" />
						<input type="hidden" name="boardid" value="<%=num%>" />
						<input type="hidden" name="category" value="<%=category%>" />
						<p>회원 비밀번호를 입력해주세요.</p>
						<input type="password" id="pwd" name="pwd" />
					</form>
				</div>
			</div>
			
			<div id="btns">
				<button type="button" onclick="history.back();" >취소</button>
				<button type="button" onclick="delChk()" >삭제</button>
			</div>
		</section>
		
		<footer>
			푸터영역
		</footer>
	</div>
	
	<script>
	
	const $frm = document.delFrm;
	
	// 페이지 로드 시, 로그인이 안되어있거나 글작성자와 로그인유저가 다를시 접근제한 (직접 주소창으로 접근 시 제한)
	window.onload = function() {
		if(!<%=loginOk%> || !<%=identify%>) {
			alert("권한이 없습니다.");
			location.href = "board02?num=" + <%=num%>;
      	}
		
		// 입력창에 포커스
		$frm.pwd.focus();
    }
 	
 	// 유효성 검사 후 submit
 	function delChk() {
 	      if($frm.pwd.value == "") {
 	        alert("비밀번호를 입력해주세요.");
 	        $frm.pwd.focus();
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