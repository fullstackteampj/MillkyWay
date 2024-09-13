<%request.setCharacterEncoding("utf-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="procsMgr" class="procs.ProcsMgr" />
<%
	int cartId = Integer.parseInt(request.getParameter("cartid"));
	int nowPageCart = Integer.parseInt(request.getParameter("nowPageCart"));
	int nowPageWish = Integer.parseInt(request.getParameter("nowPageWish"));

	
	boolean flag = procsMgr.delMyCart(cartId);
	String msg = null;
	String url = "/mypage/mypage05?nowPageCart="+ nowPageCart +"&nowPageWish=" + nowPageWish + "&pageVisible=cart";
	
	if(flag) {
		msg = "장바구니 삭제에 성공하였습니다.";
	}else{
		msg = "장바구니 삭제에 실패하였습니다.";
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
<title>delMyCart</title>
</head>
<body>

</body>
</html>