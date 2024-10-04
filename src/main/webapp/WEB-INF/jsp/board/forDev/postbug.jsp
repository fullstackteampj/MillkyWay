<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	String category = request.getParameter("category");
	
%>
<script>
	alert('아직안만들엇지롱');
	location.href="../board01?category=<%=category%>";
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