<%request.setCharacterEncoding("utf-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="procsMgr" class="procs.ProcsMgr" />
<%

	if(request.getParameter("cartid")!=null){
		int cartid = Integer.parseInt(request.getParameter("cartid"));
		procsMgr.moveToWish(cartid);	
	}
	
	if(request.getParameterValues("cart")!=null){
	String[] cartIdList = request.getParameterValues("cart");
		for(int i=0;i<cartIdList.length;i++) {
			procsMgr.moveToWish(Integer.parseInt(cartIdList[i]));
		}
	}
	
	int nowPageCart = Integer.parseInt(request.getParameter("nowPageCart"));
	int nowPageWish = Integer.parseInt(request.getParameter("nowPageWish"));

	String url = "/mypage/mypage05?nowPageCart="+ nowPageCart +"&nowPageWish=" + nowPageWish + "&pageVisible=cart";
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