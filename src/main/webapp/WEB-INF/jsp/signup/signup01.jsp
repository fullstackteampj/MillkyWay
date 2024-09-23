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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup01.css?after" />
  <script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
  <script defer src="${pageContext.request.contextPath}/js/signup01.js?ver01"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
  		$signupFrm.addEventListener('submit', (evt)=>{

	  	evt.preventDefault();

	  	idValidation();

	  	if($userEmail.value!=='' && !validText.test($userEmail.value)){
		    alert('입력하신 이메일의 형식이 올바르지 않습니다.\n다시 확인해주세요.');
		    $userEmail.value='';
		    $userEmail.focus();
		    return;
	  	}
		  //비밀번호
		  if($pwd.value !== $repwd.value){
		    alert('비밀번호와 비밀번호 재확인 값이 다릅니다. 다시 확인해주세요.');
		    $pwd.value = '';
		    $repwd.value = '';
		    $pwd.focus();
		    return;
		  }
  </script>
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
		      <form name="agreeFrm" method="post" action="/signup/signup05">
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
	
	    <article class="enterInfo">
	      <h3>회원 정보 입력</h3>
	      <form name="signupFrm" method="post" action="/signup/signup05" autocomplete="off">
	        <h4>필수 입력 정보</h4>
	        <ul>
	          <li>
	            <label for="account">아이디</label>
	            <input type="text" name="account" id="account" placeholder="이메일 형식으로 입력해주세요. (ex. abc1234@naver.com)" required /> 
	            <button type="button" onclick="">중복체크</button>
	          </li>
	
	          <li>
	            <label for="pwd">비밀번호</label>
	            <input type="password" name="pwd" id="pwd" required />
	          </li>
	          
	          <li>
	            <label for="repwd">비밀번호 확인</label>
	            <input type="password" name="repwd" required/>
	          </li>
	          
	          <li>
	            <label for="name">이름</label>
	            <input type="text" name="name" required />
	          </li>
	          
	          <li>
	            <label for="phone">전화번호</label>
	            <select name="phone" id="mobileCarrier">
	              <option value="SKT">SKT</option>
	              <option value="KT">KT</option>
	              <option value="LG U+">LG U+</option>
	              <option value="SKT2">SKT알뜰폰</option>
	              <option value="KT2">KT알뜰폰</option>
	              <option value="LG U+2">LG U+알뜰폰</option>
	            </select>
	            <input type="text" name="phoneNum" id="phone" placeholder=" - 없이 숫자만 입력해주세요." required />
	          </li>
	          
	          <li>
	            <label for="zipcode">우편번호</label>
	            <input type="text" name="zipcode" id="zipcode" required /> 
	            <input type="text" name="address" id="basicAddress" required/>
	            <button type="button" onclick="zipSearch()" >검색</button>
	          </li>
	
	          <li>
	            <label for="address">상세주소</label>
	            <input type="text" name="address" id="address" required>
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
	            	%>
	            	 <option value="<%=m%>" ><%=m%></option>
	            	<%
	            	}
	            %>
	            </select>
	            <select name="date" id="date">
	            <%
	            	for(int d=1; d<=31; d++){
	            	%>
	            	 <option value="<%=d%>" ><%=d%></option>
	            	<%
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
	      </form>
	    </article>
	  </section>
	  
	  <jsp:include page="../components/footer.jsp" />
	</div>
</body>
</html>