<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="beans.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="lMgr" class="login.LoginMgr" />
<%
	String account = request.getParameter("id");
	String answer = request.getParameter("answer");
	MemberBean mBean = lMgr.getQuestionInfo(account);
	
	if(!answer.equals(mBean.getAnswer())){
		%>
		<script>
		alert("입력하신 답과 기존의 답이 일치하지 않습니다.");
		history.back();
		</script>
		<%
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 재설정 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login0234.css?after" />
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
</head>
<body>
  <div id="wrap">
    <jsp:include page="../components/header.jsp" />

    <section>
      <h2>비밀번호 재설정</h2>
      
      <div id="pwdResetting">
        <h3>
          비밀번호를 재설정 합니다.<br/>
          다른 사이트에서 사용한 적 없는 안전한 비밀번호로 <br/>
          변경해 주세요.
        </h3>
        <form action="/procs/pwdUpdate" name="pwdResetFrm" method="post">
          <div id="newInput">
            <label for="newPwd">새 비밀번호</label>
            <input type="password" name="newPwd" id="newPwd">
          </div>

          <div id="reInput">
            <label for="rePwd">새 비밀번호 확인</label>
            <input type="password" name="rePwd" id="rePwd">
          </div>
		  <input type="hidden" name="account" value="<%=account%>" />
          <button type="reset">다시쓰기</button>
          <button type="button" onclick="inputChk()">재설정</button>
        </form>
      </div>
    </section>
    <footer>
      <address>&copy;Designed by teamMillkyWay</address>
    </footer>
  </div>

  <script>
    // 폼 입력 유효성검사
    function inputChk() {
      const $frm = document.pwdResetFrm;

      if($frm.newPwd.value == null || $frm.newPwd.value == "") {
        alert("재설정할 비밀번호를 입력해주세요.");
        $frm.newPwd.focus();
        return;
      }
      
      if($frm.rePwd.value == null || $frm.rePwd.value == "") {
        alert("비밀번호 확인란을 입력해주세요.");
        $frm.rePwd.focus();
        return;
      }
      
      // 비밀번호 확인 불일치
      if($frm.newPwd.value !== $frm.rePwd.value) {
        alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        $frm.rePwd.value = "";
        $frm.rePwd.focus();
        return;
      }
      
      $frm.submit();
    }
  </script>
</body>
</html>