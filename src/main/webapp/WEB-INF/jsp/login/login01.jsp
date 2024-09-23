<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
// 아이디저장 쿠키반영
String saveId = "";
Cookie[] cookies = request.getCookies();
System.out.print(cookies);
if(cookies!=null){
	for(int i = 0; i < cookies.length; i++){
		if(cookies[i].getName().equals("saveId")){
			saveId = cookies[i].getValue();
			break; // 쿠키를 찾으면 반복 종료
		}//if
	}//for
}//if

String userId = (String) session.getAttribute("idKey");
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
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
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
          if(saveId==null||saveId.equals("")){
        	  %>
        	  <input type="text" name="id" id="id">
        	  <%
          }else{
        	  %>
        	  <input type="text" name="id" id="id" value="<%=saveId%>">
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
          if(saveId==null||saveId.equals("")){
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