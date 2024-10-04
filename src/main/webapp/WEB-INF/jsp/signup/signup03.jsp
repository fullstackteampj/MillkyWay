<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="SHA256.SHASalt"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="sMgr" class="procs.SignupMgr" />
<jsp:useBean id="bean" class="beans.MemberBean" />
<jsp:setProperty property="*" name="bean" />
<%@ page import="java.util.*" %>
<%


	//해시화된 비밀번호 생성 ->  bean(폼에서 전달받은 데이터)에 저장
	SHASalt SHASalt = new SHASalt();
	String salt = SHASalt.genSalt(); //난수로 만들어낸 salt 값
	String inputPwd = bean.getPwd(); //사용자가 input 입력한 pwd값
	String CrPwd = SHASalt.getEncrypt(inputPwd, salt);
	bean.setPwd(CrPwd);//pwd 컬럼에 재입력
	bean.setSalt(salt);
	System.out.println("CrPwd = " + CrPwd);
	System.out.println("salt = " + salt);

  	boolean result = sMgr.insertMember(bean);

	String msg = "회원가입에 실패하였습니다. 다시 시도해 주세요.";
	String location = "/signup/signup01";
	String changePage = "회원가입";
	
	System.out.println(result);
	
	if(result){
		msg = "은하수 책방의 회원이 되신 걸 환영합니다.";
		location = "/login/login01";
		changePage = "로그인";
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup0123.css?after" />
  <script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
 
</head>
<body>
	<div id="wrap">
		<jsp:include page="../components/header.jsp" />
  		<section class="sign-up">
    		<h2>회원가입</h2>

		    <div class="progress complete"> 
		      <span class="ball"></span>
		      <div class="back-line1"></div>
		      <div class="back-line2"></div>
		      <div class="text">
		        <span>약관 동의</span>
		        <span>정보 입력</span>
		        <span>회원가입<br />완료</span>
		      </div>
		    </div>
	   
		    <article class="finish">
		      <h2><%=msg%></h2>
		      <p>다양한 책들과 커뮤니티를 즐겨보세요!</p>
		      <p><%=changePage%>화면으로 ... <span></span></p>
		    </article>
	  </section>
	  
	<jsp:include page="../components/footer.jsp" />
	</div>
<script>

  //5초 뒤 메인 페이지 이동
  const $remainSec = document.querySelector('.sign-up .finish>p>span');
  let sec = 5;
  const move = () => {
	  $remainSec.textContent = sec;
	  const intervalKey = setInterval(()=>{
	    sec--;
	    $remainSec.textContent = sec;
	    if(sec===0) {
	      clearInterval(intervalKey);
	     
	      location.href = "<%= location %>";
	    }//if
	  }, 1000);//setInterval 
  }
  window.onload = move();
	  
</script>	
</body>
</html>