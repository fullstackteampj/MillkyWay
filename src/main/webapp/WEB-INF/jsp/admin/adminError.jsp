<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String error = request.getParameter("error");
%>
<script>
	if("<%=error%>" === "insertFail") {
		alert("상품 등록에 실패하였습니다.");
		history.back();
	}
	if("<%=error%>" === "updateFail") {
		alert("상품정보 수정에 실패하였습니다.");
		history.back();
	}
	if("<%=error%>" === "deleteFail") {
		alert("상품 삭제에 실패하였습니다.");
		history.back();
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