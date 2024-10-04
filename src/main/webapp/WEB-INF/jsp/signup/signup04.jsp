<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<jsp:useBean id="sMgr" class="procs.SignupMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String account = request.getParameter("account");
	boolean result = sMgr.checkId(account);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>아이디 중복 확인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup045.css?after" />
</head>
<body>
  <div class="duplication">
    <% 
    	if(result){
    		%>
    		 <h1><span><%=account%></span>는<br />이미 존재합니다.</h1>
    		 <p>다시 입력해 주세요.</p>
    		<%
    	}else{
    		%>
    		 <h1><span><%=account%></span>는<br />사용 가능한 <br />아이디 입니다.</h1>
    		<%
    	}
    %>
    <button type="button" onclick="sendDataClose()">닫기</button>
  </div>
<script>
	const sendDataClose = () => {
		const sendData = '<%=result%>' === 'false';
		if(sendData){
			// 팝업창에서 부모 창으로 데이터 전송(postMessage API사용)
			const dataToSend = { id: "ok" };
			window.opener.postMessage(dataToSend, 'http://localhost:8080');

		}
		
		self.close();
	}
</script>
</body>
</html>