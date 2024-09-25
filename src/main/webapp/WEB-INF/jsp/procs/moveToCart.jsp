<%request.setCharacterEncoding("utf-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="procsMgr" class="procs.ProcsMgr" />
<%
	
	if(request.getParameter("wishid")!=null){
		int wishid = Integer.parseInt(request.getParameter("wishid"));
		procsMgr.moveToCart(wishid);	
	}

	if(request.getParameterValues("wish")!=null){
	String[] wishIdList = request.getParameterValues("wish");
		for(int i=0;i<wishIdList.length;i++) {
			procsMgr.moveToCart(Integer.parseInt(wishIdList[i]));
		}
	}
	
	int nowPageCart = Integer.parseInt(request.getParameter("nowPageCart"));
	int nowPageWish = Integer.parseInt(request.getParameter("nowPageWish"));
	
	String url = "/mypage/mypage05?nowPageCart="+ nowPageCart +"&nowPageWish=" + nowPageWish + "&pageVisible=wish";
%>
<script>
	location.href="<%=url%>";
</script>
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>