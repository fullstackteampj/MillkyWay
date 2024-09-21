<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	int num = Integer.parseInt(request.getParameter("num"));
	for(int i=5; i<19; i++) {
		bMgr.upLike(num, i);
	}
%>
<script>
	alert('머해');
	location.href="../board02?num=" + <%=num%>;
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