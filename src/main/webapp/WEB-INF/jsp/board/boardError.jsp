<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String error = request.getParameter("error");
	String boardid = request.getParameter("num");
%>
<script>
	if('<%=error%>' == 'failPost') {
		alert('글 작성에 실패하였습니다.');
		location.href = "board01";
	}
	if('<%=error%>' == 'failDelete') {
		alert('비밀번호가 일치하지 않습니다.');
		location.href = "board02?num="+<%=boardid%>;
	}
	if('<%=error%>' == 'failEdit') {
		alert('글 수정에 실패하였습니다.');
		location.href = "board02?num="+<%=boardid%>;
	}
	if('<%=error%>' == 'failCommentEdit') {
		alert('권한이 없습니다.');
		location.href = "board02?num="+<%=boardid%>;
	}
	if('<%=error%>' == 'failCommentDel') {
		alert('권한이 없습니다.');
		location.href = "board02?num="+<%=boardid%>;
	}
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>