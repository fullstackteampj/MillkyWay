<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<jsp:useBean id="sMgr" class="procs.SignupMgr" />
<jsp:useBean id="bean" class="beans.MemberBean" />
<jsp:setProperty property="*" name="bean" />
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String[] agrees = request.getParameterValues("agree");
	
	
	 String agree = "F";
	
	for(int i=0; i<agrees.length; i++){
		if(agrees[i].contains("useInfo")) agree = "T"; 
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
  <script defer src="${pageContext.request.contextPath}/js/signup02.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<div id="wrap">
	
		<jsp:include page="../components/header.jsp" />
  		<section class="sign-up">
    		<h2>회원가입</h2>

		    <div class="progress next-stage">
		      <span class="ball"></span>
		      <div class="back-line1"></div>
		      <div class="back-line2"></div>
		      <div class="text">
		        <span>약관 동의</span>
		        <span>정보 입력</span>
		        <span>회원가입<br />완료</span>
		      </div>
		    </div>
	
	    <article class="enterInfo">
	      <h3>회원 정보 입력</h3>
	      <form name="signupFrm" method="post" autocomplete="on" action="/signup/signup03">
	        <h4>필수 입력 정보</h4>
	        <ul>
	          <li>
	            <label for="account">아이디</label>
	            <input type="text" name="account" id="account" placeholder="이메일 형식으로 입력해주세요. (ex. abc1234@naver.com)" required /> 
	            <button type="button">중복체크</button>
	          </li>
	
	          <li>
	            <label for="pwd">비밀번호</label>
	            <input type="password" name="pwd" id="pwd" required />
	          </li>
	          
	          <li>
	            <label for="repwd">비밀번호 확인</label>
	            <input type="password" name="repwd" id="repwd" required/>
	          </li>
	          
	          <li>
	            <label for="name">이름</label>
	            <input type="text" name="name" required />
	          </li>
	          
	          <li>
	            <label for="phone">전화번호</label>
	            <select name="phone" id="phone">
	              <option value="SKT" selected>SKT</option>
	              <option value="KT">KT</option>
	              <option value="LG U+">LG U+</option>
	              <option value="SKT2">SKT알뜰폰</option>
	              <option value="KT2">KT알뜰폰</option>
	              <option value="LG U+2">LG U+알뜰폰</option>
	            </select>
	            <input type="text" name="phoneNum" id="phoneNum" placeholder=" - 없이 숫자만 입력해주세요." required />
	          </li>
	          
	          <li>
	            <label for="zipcode">우편번호</label>
	            <input type="text" name="zipcode" id="zipcode" required /> 
	            <input type="text" name="address" id="address" required/>
	            <button type="button" onclick="zipSearch()" >검색</button>
	          </li>
	
	          <li>
	            <label for="detailAddress">상세주소</label>
	            <input type="text" name="detailAddress" id="detailAddress" required>
	          </li>
	
	          <li>
	            <label for="address">별명</label>
	            <input type="text" name="nickname" id="nickname"  placeholder="은하수 책방에서 사용할 별명을 입력해 주세요." required>
	            <button type="button" onclick="nicknameCheck()">중복체크</button>
	          </li>
	
	          <li>
	            <label for="question">비밀번호 질문</label>
	            <select name="question" id="question"  required >
	              <option value="" hidden selected disabled>비밀번호 찾기시 사용할 질문입니다.</option>
	              <option value="가장 좋아하는 색은 무엇인가요?">가장 좋아하는 색은 무엇인가요?</option>
	              <option value="가장 좋아하는 취미는 무엇인가요?">가장 좋아하는 취미는 무엇인가요?</option>
	              <option value="가장 좋아하는 영화는 무엇인가요?">가장 좋아하는 영화는 무엇인가요?</option>
	              <option value="가장 가고 싶은 여행지는 어디인가요?">가장 가고 싶은 여행지는 어디인가요?</option>
	              <option value="가장 좋아하는 책은 무엇인가요?">가장 좋아하는 책은 무엇인가요?</option>
	            </select>
	          </li>
	          <li>
	            <label for="answer">질문의 답</label>
	            <input type="text" name="answer">
	          </li>
	        </ul>
	        <h4>추가 입력 정보</h4>
	        <ul>
	          <li>
	            <label for="gender">성별</label>
	            <input type="radio" name="gender" id="male" value="M" checked>
	            <input type="radio" name="gender" id="female" value="F">
	          </li>
	          <li>
	            <label for="birth">생년월일</label>
	            <select name="year" id="year">
	              <%
	              	LocalDate now = LocalDate.now();
	            		
	            	for(int y=now.getYear(); y>(now.getYear() - 100); y--){
	            	%>
	            	 <option value="<%=y%>" ><%=y%></option>
	            	<%
	            	}
	            %>
	            </select>
	            <select name="month" id="month">
	             <%
	            	for(int m=1; m<=12; m++){
	            		if(m<10){
	            		%>
	            		<option value="0<%=m%>" >0<%=m%></option>
	            		<%	
	            		}else{
	            	%>
	            	 <option value="<%=m%>" ><%=m%></option>
	            	<%
	            		}
	            	}
	            %>
	            </select>
	            <select name="date" id="date">
	            <%
	            	for(int d=1; d<=31; d++){
	            		if(d<10){
	            		%>
	            		<option value="0<%=d%>" >0<%=d%></option>
	            		<%
	            		}else{
	            	%>
	            	 <option value="<%=d%>" ><%=d%></option>
	            	<%
	            		}
	            	}
	            %>
	            </select>
	          </li>
	
	          <li>
	            <label for="email">이메일</label>
	            <input type="text" name="email" id="email">
	            <button type="button">아이디동일</button>
	          </li>
	
	          <li>
	            <label for="favorite">도서 취향</label>
	            로맨스
	            <input type="checkbox" name="favorite" id="romance" value="로맨스" />
	            여행
	            <input type="checkbox" name="favorite" id="trip" value="여행" />
	            스릴러
	            <input type="checkbox" name="favorite" id="thriller" value="스릴러">
	            과학
	            <input type="checkbox" name="favorite" id="science" value="과학" />
	            만화
	            <input type="checkbox" name="favorite" id="comic" value="만화" />
	            판타지
	            <input type="checkbox" name="favorite" id="fantasy" value="판타지" />
	          </li>
	        </ul>
	        
	        <div class="btns">
	          <button type="button" class="enterInfoPrev">뒤로가기</button>
	          <button>회원가입</button>
	        </div>
	        <input type="hidden" name="agree" value="<%=agree%>" />
	      </form>
	    </article>
	  </section>
	  
	<jsp:include page="../components/footer.jsp" />
	</div>
	
 <script>
 	const frm = document.signupFrm;
 	
 	const validText = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
 	
 	//회원가입 submit 이벤트
	frm.addEventListener('submit', (evt)=>{
		
	  	//잘못된 형식인 경우
	    if(frm.account.value!=='' && !validText.test(frm.account.value)){
	      alert('아이디를 이메일 형식으로 입력해 주세요.\n ex) abdc77@naver.com');
	      frm.account.value = '';
	      frm.account.focus();
	      evt.preventDefault();
	    }

	    //값이 비어있을 경우
	    if(frm.account.value === '' || frm.account.value === null){
	      alert('아이디를 입력해 주세요.');
	      frm.account.focus();
	      evt.preventDefault();
	    }
	
	  	if(frm.email.value!=='' && !validText.test(frm.email.value)){
		    alert('입력하신 이메일의 형식이 올바르지 않습니다.\n다시 확인해주세요.');
		    frm.email.value='';
		    frm.email.focus();
		    evt.preventDefault();
	  	}
		  //비밀번호
		 if(frm.pwd.value !== frm.repwd.value){
		    alert('비밀번호와 비밀번호 재확인 값이 다릅니다. 다시 확인해주세요.');
		    frm.pwd.value = '';
		    frm.repwd.value = '';
		    frm.pwd.focus();
		    evt.preventDefault();
		 }
		  
 	});
 	
  </script>
</body>
</html>