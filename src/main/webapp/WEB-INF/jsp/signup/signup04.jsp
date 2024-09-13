<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>별명 중복 확인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup024.css?after" />
</head>

<body>
   <div class="duplication">
	    <!--if(사용가능할 경우)
	    <h1><span>별명</span>은<br />사용 가능한 <br />별명 입니다.</h1>
	    -->
	    <h1><span>별명</span>을<br />이미 다른 회원이 사용중입니다.</h1>
	    <p>다시 입력해 주세요.</p>
	    <button type="button" onclick=self.close()>닫기</button>
	    <!--
	        input.value = ''
	        input.focus();
	    -->
  	</div>

</html>