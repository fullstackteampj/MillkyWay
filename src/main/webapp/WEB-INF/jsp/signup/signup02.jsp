<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>아이디 중복 확인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup024.css?after" />
</head>
<body>
  <div class="duplication">
    <!--if(사용가능할 경우)
    <h1><span>아이디</span>는<br />사용 가능한 <br />아이디 입니다.</h1>
    -->
    <h1><span>아이디</span>는<br />이미 존재합니다.</h1>
    <p>다시 입력해 주세요.</p>
    <button type="button" onclick=self.close()>닫기</button>
    <!--
        input.value = ''
        input.focus();
    -->
  </div>
</body>
</html>