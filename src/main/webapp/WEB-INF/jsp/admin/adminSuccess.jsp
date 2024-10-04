<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="aMgr" class="admin.AdminMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String success = request.getParameter("success");
	int lastBookid = aMgr.lastBookid();
	int requestid = (request.getParameter("requestid") != null) ? Integer.parseInt(request.getParameter("requestid")) : 0;
%>
<script>
	if("<%=success%>" === "insertsuccess") {
		alert("성공적으로 상품을 등록하였습니다.");
		location.href = "../shop/shop02?bookid=<%=lastBookid%>";
	}
	if("<%=success%>" === "updatesuccess") {
		alert("성공적으로 상품정보를 수정하였습니다.");
		location.href = "../shop/shop02?bookid=<%=requestid%>";
	}
	if("<%=success%>" === "deletesuccess") {
		alert("성공적으로 상품을 삭제하였습니다.");
		location.href = "./delete";
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