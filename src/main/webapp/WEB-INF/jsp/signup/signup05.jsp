<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="sMgr" class="procs.SignupMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String nickname = request.getParameter("nickname");
	boolean result = sMgr.checkNickname(nickname);
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>별명 중복 확인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup045.css?after" />
</head>

<body>
   <div class="duplication">
	    <% if(result){
	    	%>
	    	 <h1>
	    	 	<span><%=nickname%></span>을<br />
	    	 	이미 다른 회원이 사용중입니다.
	    	 </h1>
	    	 <p>다시 입력해 주세요.</p>
	    	<%
	    }else{
	    	%>
	    	 <h1>
		    	 <span><%=nickname%></span>은<br />
		    	 사용 가능한<br />
		    	 별명 입니다.
	    	 </h1>
	    	<%
	    }%>
	   
	    <button type="button" onclick="sendDataClose()">닫기</button>
  	</div>
<script>
	const sendDataClose = () => {
		const sendData = '<%=result%>' === 'false';
		if(sendData){
			// 팝업창에서 부모 창으로 데이터 전송(postMessage API사용)
			const dataToSend = { nickname: "ok" };
			window.opener.postMessage(dataToSend, 'http://localhost:8080');
		}
		
		self.close();
	}
</script>
</body>
</html>