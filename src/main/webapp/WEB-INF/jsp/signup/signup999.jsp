<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>우편번호 검색</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup999.css?after" />
 
</head>
<body>
	<div class="zipcode">
    <h1>우편번호 검색</h1>
    <form name="searchZipcodeFrm" method="post" autocomplete="off">
      <input type="text" name="searchZipcode" onclick="zipSearch()"/>
      <button>검색</button>
    </form>
    <ul>
      <!--주소 데이터 li로 출력하기-->
    </ul>
    <button type="button" onclick=self.close()>닫기</button>
  </div>

</body>
</html>