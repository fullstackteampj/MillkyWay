<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String event = request.getParameter("event");
	String category = request.getParameter("category");
	String boardid = request.getParameter("num");
%>
<script>
	if('<%=event%>' == 'delPost') {
		alert('글을 성공적으로 삭제하였습니다.');
		let url = ("<%=category%>" == "null") ? "board01" : ("board01?category=<%=category%>");
		location.href = url;
	}
	if('<%=event%>' == 'editPost') {
		alert('글을 성공적으로 수정하였습니다.');
		let url = ("<%=category%>" == "null") ? "board01" : ("board02?category=<%=category%>&num=<%=boardid%>");
		location.href = url;
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