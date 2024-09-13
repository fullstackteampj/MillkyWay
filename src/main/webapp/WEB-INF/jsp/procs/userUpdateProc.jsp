<%request.setCharacterEncoding("utf-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="myMgr" class="myPage.MyPageMgr" />
<jsp:useBean id="inBean" class="beans.MemberBean"/>
<jsp:setProperty property="*" name="inBean" />

<%
	String userId = request.getParameter("userId");
	boolean flag = myMgr.executeMemberUpdate(Integer.parseInt(userId), inBean);
	
	if(flag){
		%>
		<script>
			alert("정보 수정에 성공하였습니다.");
			location.href="/mypage/mypage03";
		</script>
		<%
	}else{
		%>
		<script>
			alert("정보 수정에 실패하였습니다.");
			location.href="/mypage/mypage03";
		</script>
		<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userUpdateProc</title>
</head>
<body>

</body>
</html>