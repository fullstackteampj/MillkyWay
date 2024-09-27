<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="sMgr" class="procs.SignupMgr" />
<jsp:useBean id="bean" class="beans.MemberBean" />
<jsp:setProperty property="*" name="bean" />
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup0123.css?after" />
  <script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
  <script defer src="${pageContext.request.contextPath}/js/signup01.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<div id="wrap">
	
		<jsp:include page="../components/header.jsp" />
  		<section class="sign-up">
    		<h2>회원가입</h2>

		    <div class="progress"> <!-- .next-stage .complete-->
		      <span class="ball"></span>
		      <div class="back-line1"></div>
		      <div class="back-line2"></div>
		      <div class="text">
		        <span>약관 동의</span>
		        <span>정보 입력</span>
		        <span>회원가입<br />완료</span>
		      </div>
		    </div>
	    
		    <article class="agreement">
		      <h3>약관 동의</h3>
		      <form name="agreeFrm" method="post" action="/signup/signup02">
			      <ul>
			        <li>
			          (필수) 은하수 책방을 이용하고 싶은 마음을 약관동의 체크로 표현해주세요.
			          <input type="checkbox" name="agree" id="essential1" value="essential1" required />
			        </li>
			
			        <li>
			          (필수) 은하수 책방에 가입하시면 좋은 일들이 가득하실 겁니다.
			          <input type="checkbox" name="agree" id="essential2" value="essential2" required />
			        </li>
			
			        <li>
			          (선택) 은하수 책방은 회원의 개인정보를 이용할 줄 모르지만, 개인정보 이용 동의를 해주실 분은 체크해주세요. 
			            <input type="checkbox" name="agree" id="useInfo" value="useInfo">
			         </li>
			          
			         <li>
			            한번에 모두 동의하고 싶은 분은 체크해주세요.
			            <input type="checkbox" name="agree" id="allAgree">
			         </li>
			       </ul>
			       <div class="btns">
			          <button type="button" onclick="history.back()">뒤로가기</button>
			          <button class="agreementNext">다음으로</button>
			       </div>
		      </form>
		    </article>
	
	  </section>
	  
	<jsp:include page="../components/footer.jsp" />
	</div>	
</body>
</html>