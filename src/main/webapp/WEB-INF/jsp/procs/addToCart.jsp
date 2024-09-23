<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMrg" class="procs.ProcsMgr" />
<%
	int userId = Integer.parseInt(request.getParameter("userId"));
	int bookId = Integer.parseInt(request.getParameter("bookId"));
	
	boolean flag = pMrg.addToCart(userId, bookId);
	
	String msg = "장바구니 추가에 실패하였습니다.";
	
	if(flag){
		msg = "장바구니 추가에 성공하였습니다.";
	}
%>
<script>
	alert("<%=msg%>");
	history.back();
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addToCart</title>
</head>
<body>

</body>
</html>