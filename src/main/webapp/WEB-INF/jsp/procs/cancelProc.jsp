<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="myMgr" class="myPage.MyPageMgr" />
<%
	String status = request.getParameter("status");
	String purchaseid = request.getParameter("purchaseid");
	String cancellation_reason = request.getParameter("cancellation_reason");
	String price = request.getParameter("price");
	String quantity = request.getParameter("quantity");
	
	boolean flag = myMgr.movePurToCan(purchaseid, cancellation_reason, status, price, quantity);
	
	if(flag){
		%>
		<script>
			alert("<%=status%>요청이 정상적으로 접수되었습니다");
			window.opener.location.reload(); //기존 부모창 새로고침
			window.close();
		</script>
		<%
	}else{
		%>
		<script>
			alert("<%=status%>처리에 실패하였습니다.");
			window.opener.location.reload(); //기존 부모창 새로고침
			window.close();
		</script>
		<%
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>