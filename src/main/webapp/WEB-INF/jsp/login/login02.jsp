<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"> 
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

    <section >
      <h2>비밀번호찾기</h2>

      <div id="findPwd">
        <h3>비밀번호를 찾고자하는 아이디를 입력해주세요.</h3>
        
        <form name="findPwdFrm" method="get" action='/login/login03'> <!-- 임시로 다음페이지로 가게햇습니다 ! -->
          <input type="text" name="id" placeholder="아이디">
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
    const $frm = document.findPwdFrm;
    $frm.id.focus();
    function inputChk() {
      if($frm.id.value == null || $frm.id.value == "") {
        alert("아이디를 입력해주세요.");
        $frm.id.focus();
        return;
      }
      $frm.submit();
    }
  </script>
</body>
</html>