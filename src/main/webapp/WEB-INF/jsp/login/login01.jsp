<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
// 아이디저장 쿠키반영
String saveId = "";
Cookie[] cookies = request.getCookies();
if(cookies!=null){
	for(int i = 0; i < cookies.length; i++){
		if(cookies[i].getName().equals("saveId")){
			saveId = cookies[i].getValue();
			break; // 쿠키를 찾으면 반복 종료
		}//if
	}//for
}//if

if (session.getAttribute("idKeyS") != null) {
    %>
    <script>
        alert("로그인 상태입니다. 메인화면으로 이동합니다.");
        location.href="/";
    </script>
    <%
    return;
}
%>
<!DOCTYPE html>
<html lang="en"> 
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login01.css?after" />
  <script defer src="${pageContext.request.contextPath}/js/header.js?after""></script>
</head>
<body>
  <div id="wrap">

	<jsp:include page="../components/header.jsp" />

    <section class="login">
      <h2>로그인</h2>
      <form name="loginFrm" method="post" action="/procs/loginProc">
        <div id="idInput">
          <label for="id">아이디</label>
          <%
          if(saveId.equals("")){
        	  %>
        	  <input type="text" name="id" id="id" placeholder = "abc@naver.com">
        	  <%
          }else{
        	  %>
        	  <input type="text" name="id" id="id" placeholder = "이메일형식" value="<%=saveId%>">
        	  <%
          }
          %>
        </div>
        <div id="pwdInput">
          <label for="pwd">비밀번호</label>
          <input type="password" name="pwd" id="pwd">
        </div>
        <div>
          <%
          if(saveId.equals("")){
        	  %>
        	  <input type="checkbox" name="saveId" id="saveId" value="saveId" />
        	  <%
          }else{
        	  %>
        	  <input type="checkbox" name="saveId" id="saveId" value="saveId" checked />
        	  <%
          }
          %>
          <label for="saveId">아이디 저장</label>
        </div>
        
        <button type="button" onclick="loginChk()">로그인</button>
        
     	<%
		String clientId = "cR6ZYmE3B8jjB8ERbb3U";//애플리케이션 클라이언트 아이디값";
		String redirectURI = URLEncoder.encode("http://localhost:8080/login/naverLogin", "UTF-8"); ///login/naverLogin으로 이동
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + state;
		session.setAttribute("state", state);
		%>
		<a class="naver" href="<%=apiURL%>">
			<img height="50" src="${pageContext.request.contextPath}/images/btnG_완성형.png"/>
		</a>
        
      </form>
      <div id="loginMng">
        <a href="/signup/signup01">회원가입</a>
        ㅣ
        <a href="/login/login02">비밀번호 찾기</a>
      </div>
      


    </section>
	<footer>
      <address>&copy;Designed by teamMillkyWay</address>
    </footer>
  </div>
  
  <script>
    // 유효성검사
    const $frm = document.loginFrm;
    $frm.id.focus();
    function loginChk() {
      if($frm.id.value == null || $frm.id.value == "") {
        alert("아이디를 입력해주세요.");
        $frm.id.focus();
        return;
      }
      if($frm.pwd.value == null || $frm.pwd.value == "") {
        alert("비밀번호를 입력해주세요.");
        $frm.pwd.focus();
        return;
      }

      $frm.submit();
    }
  </script>
</body>
</html>