<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="beans.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="lMgr" class="login.LoginMgr" />
<%
	String account = request.getParameter("id");
	MemberBean mBean = lMgr.getQuestionInfo(account);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 찾기 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login0234.css?after" />
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
</head>
<body>
  <div id="wrap">
    <jsp:include page="../components/header.jsp" />

    <section>
      <h2>비밀번호찾기</h2>

      <div id="findPwdQuest">
        <h3>회원가입 시 입력한 '비밀번호 확인 질문'에 대한 답변을 입력해주세요</h3>
        
        <form name="findPwdQuestFrm" method="post" action="/login/login04"> <!-- 본인페이지로 받아서 DB와 비교후 일치하는 아이디가 없으면 alert, 있으면 location.href ? -->
          <label for="question">질문</label>
          <input type="text" name="question" id="question" value="<%=mBean.getQuestion()%>" disabled> <!--value는 DB에서 가져와서 할당-->
          <label for="answer">답변</label>
          <input type="text" name="answer" id="answer">
          <input type="hidden" name="id" id="id" value="<%=account%>">
          <button type="button" onclick="inputChk()">다음</button>
        </form>
        <a href="/login/login01">로그인</a>
      </div>
    </section>
    <footer>
      <address>&copy;Designed by teamMillkyWay</address>
    </footer>
  </div>

  <script>
    const $frm = document.findPwdQuestFrm;
    $frm.answer.focus();
    function inputChk() {
      if($frm.answer.value === null || $frm.answer.value === "") {
        alert("답변을 입력해주세요.");
        $frm.answer.focus();
        return;
      }
      $frm.submit();
    }
  </script>
</body>
</html>