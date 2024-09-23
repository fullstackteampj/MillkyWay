<% request.setCharacterEncoding("UTF-8"); %>	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="procsMgr" class="procs.ProcsMgr" />
<%
	int boardId = Integer.parseInt(request.getParameter("boardId"));
	
	boolean flag = procsMgr.delMyBoard(boardId);
	String msg = null;
	String url = "/mypage/mypage04";
	
	if(flag) {
		msg = "게시글 삭제에 성공하였습니다.";
	}else{
		msg = "게시글 삭제에 실패하였습니다.";
	}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardDel</title>
</head>
<body>

</body>
</html>