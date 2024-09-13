<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup01.css?after" />
  <script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
  <script defer src="${pageContext.request.contextPath}/js/signup01.js"></script>
</head>
<body>
	<div id="wrap">
		<%@ include file="../components/header.jsp" %>
		
  		<section class="sign-up">
    		<h2>회원가입</h2>

		    <div class="progress"> <!--next-stage complete-->
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
		      <form name="agreeFrm" method="post">
			      <ul>
			        <li>
			          (필수) 은하수 책방을 이용하고 싶은 마음을 약관동의 체크로 표현해주세요.
			          <input type="checkbox" name="agree" id="signupWant" value="essential1" required />
			        </li>
			
			        <li>
			          (필수) 은하수 책방에 가입하시면 좋은 일들이 가득하실 겁니다.
			          <input type="checkbox" name="agree" id="signupLucky" value="essential2" required />
			        </li>
			
			        <li>
			          (선택) 은하수 책방은 회원의 개인정보를 이용할 줄 모르지만, 개인정보 이용 동의를 해주실 분은 체크해주세요. 
			            <input type="checkbox" name="agree" id="signupFree" value="useInfo">
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
	      <form name="signupFrm" method="post" autocomplete="off">
	        <h4>필수 입력 정보</h4>
	        <ul>
	          <li>
	            <label for="userId">아이디</label>
	            <input type="text" name="userId" id="userId" placeholder="이메일 형식으로 입력해주세요. (ex. abc1234@naver.com)" required /> <button type="button" onclick="idCheck()">중복체크</button>
	          </li>
	
	          <li>
	            <label for="userPwd">비밀번호</label>
	            <input type="password" name="userPwd" id="userPwd" required />
	          </li>
	          
	          <li>
	            <label for="userRepwd">비밀번호 확인</label>
	            <input type="password" name="userRepwd" required/>
	          </li>
	          
	          <li>
	            <label for="userName">이름</label>
	            <input type="text" name="userName" required />
	          </li>
	          
	          <li>
	            <label for="userPhone">전화번호</label>
	            <select name="mobileCarrier" id="mobileCarrier">
	              <option value="SKT">SKT</option>
	              <option value="KT">KT</option>
	              <option value="LG U+">LG U+</option>
	              <option value="SKT2">SKT알뜰폰</option>
	              <option value="KT2">KT알뜰폰</option>
	              <option value="LG U+2">LG U+알뜰폰</option>
	            </select>
	            <input type="text" name="userPhone" id="userPhone" placeholder=" - 없이 숫자만 입력해주세요." required />
	          </li>
	          
	          <li>
	            <label for="zipcode">우편번호</label>
	            <input type="text" name="zipcode" id="zipcode" required /> <button type="button" onclick="zipSearch()" >검색</button>
	          </li>
	
	          <li>
	            <label for="address">주소</label>
	            <input type="text" name="address" id="address" required>
	          </li>
	
	          <li>
	            <label for="address">별명</label>
	            <input type="text" name="nickname" id="nickname"  placeholder="은하수 책방에서 사용할 별명을 입력해 주세요." required>
	            <button type="button" onclick="nicknameCheck()">중복체크</button>
	          </li>
	
	          <li>
	            <label for="pwdquestion">비밀번호 질문</label>
	            <select name="pwdquestion" id="pwdquestion"  required >
	              <option value="" hidden selected disabled>비밀번호 찾기시 사용할 질문입니다.</option>
	              <option value="가장 좋아하는 색은 무엇인가요?">가장 좋아하는 색은 무엇인가요?</option>
	              <option value="가장 좋아하는 취미는 무엇인가요?">가장 좋아하는 취미는 무엇인가요?</option>
	              <option value="가장 좋아하는 영화는 무엇인가요?">가장 좋아하는 영화는 무엇인가요?</option>
	              <option value="가장 가고 싶은 여행지는 어디인가요?">가장 가고 싶은 여행지는 어디인가요?</option>
	              <option value="가장 좋아하는 책은 무엇인가요?">가장 좋아하는 책은 무엇인가요?</option>
	            </select>
	          </li>
	          <li>
	            <label for="pwdanswer">질문의 답</label>
	            <input type="text" name="pwdanswer">
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
	            <label for="userBirth">생년월일</label>
	            <select name="year" id="year">
	              <option value="2024">2024</option>
	              <option value="2023">2023</option>
	              <option value="2022">2022</option>
	              <option value="2021">2021</option>
	              <option value="2020">2020</option>
	              <option value="2019">2019</option>
	              <option value="2018">2018</option>
	              <option value="2017">2017</option>
	              <option value="2016">2016</option>
	              <option value="2015">2015</option>
	              <option value="2014">2014</option>
	              <option value="2013">2013</option>
	              <option value="2012">2012</option>
	              <option value="2011">2011</option>
	              <option value="2010">2010</option>
	              <option value="2009">2009</option>
	              <option value="2008">2008</option>
	              <option value="2007">2007</option>
	              <option value="2006">2006</option>
	              <option value="2005">2005</option>
	              <option value="2004">2004</option>
	              <option value="2003">2003</option>
	              <option value="2002">2002</option>
	              <option value="2001">2001</option>
	              <option value="2000">2000</option>
	              <option value="1999">1999</option>
	              <option value="1998">1998</option>
	              <option value="1997">1997</option>
	              <option value="1996">1996</option>
	              <option value="1995">1995</option>
	              <option value="1994">1994</option>
	              <option value="1993">1993</option>
	              <option value="1992">1992</option>
	              <option value="1991">1991</option>
	              <option value="1990">1990</option>
	              <option value="1989">1989</option>
	              <option value="1988">1988</option>
	              <option value="1987">1987</option>
	              <option value="1986">1986</option>
	              <option value="1985">1985</option>
	              <option value="1984">1984</option>
	              <option value="1983">1983</option>
	              <option value="1982">1982</option>
	              <option value="1981">1981</option>
	              <option value="1980">1980</option>
	              <option value="1979">1979</option>
	              <option value="1978">1978</option>
	              <option value="1977">1977</option>
	              <option value="1976">1976</option>
	              <option value="1975">1975</option>
	              <option value="1974">1974</option>
	              <option value="1973">1973</option>
	              <option value="1972">1972</option>
	              <option value="1971">1971</option>
	              <option value="1970">1970</option>
	              <option value="1969">1969</option>
	              <option value="1968">1968</option>
	              <option value="1967">1967</option>
	              <option value="1966">1966</option>
	              <option value="1965">1965</option>
	              <option value="1964">1964</option>
	              <option value="1963">1963</option>
	              <option value="1962">1962</option>
	              <option value="1961">1961</option>
	              <option value="1960">1960</option>
	              <option value="1959">1959</option>
	              <option value="1958">1958</option>
	              <option value="1957">1957</option>
	              <option value="1956">1956</option>
	              <option value="1955">1955</option>
	              <option value="1954">1954</option>
	              <option value="1953">1953</option>
	              <option value="1952">1952</option>
	              <option value="1951">1951</option>
	              <option value="1950">1950</option>
	              <option value="1949">1949</option>
	              <option value="1948">1948</option>
	              <option value="1947">1947</option>
	              <option value="1946">1946</option>
	              <option value="1945">1945</option>
	              <option value="1944">1944</option>
	              <option value="1943">1943</option>
	              <option value="1942">1942</option>
	              <option value="1941">1941</option>
	              <option value="1940">1940</option>
	              <option value="1939">1939</option>
	              <option value="1938">1938</option>
	              <option value="1937">1937</option>
	              <option value="1936">1936</option>
	              <option value="1935">1935</option>
	              <option value="1934">1934</option>
	              <option value="1933">1933</option>
	              <option value="1932">1932</option>
	              <option value="1931">1931</option>
	              <option value="1930">1930</option>
	              <option value="1929">1929</option>
	              <option value="1928">1928</option>
	              <option value="1927">1927</option>
	              <option value="1926">1926</option>
	              <option value="1925">1925</option>
	              <option value="1924">1924</option>
	              <option value="1923">1923</option>
	              <option value="1922">1922</option>
	              <option value="1921">1921</option>
	              <option value="1920">1920</option>
	              <option value="1919">1919</option>
	              <option value="1918">1918</option>
	              <option value="1917">1917</option>
	              <option value="1916">1916</option>
	              <option value="1915">1915</option>
	              <option value="1914">1914</option>
	              <option value="1913">1913</option>
	              <option value="1912">1912</option>
	              <option value="1911">1911</option>
	              <option value="1910">1910</option>
	              <option value="1909">1909</option>
	              <option value="1908">1908</option>
	              <option value="1907">1907</option>
	              <option value="1906">1906</option>
	              <option value="1905">1905</option>
	              <option value="1904">1904</option>
	              <option value="1903">1903</option>
	              <option value="1902">1902</option>
	              <option value="1901">1901</option>
	            </select>
	            <select name="month" id="month">
	              <option value="01">01</option>
	              <option value="02">02</option>
	              <option value="03">03</option>
	              <option value="04">04</option>
	              <option value="05">05</option>
	              <option value="06">06</option>
	              <option value="07">07</option>
	              <option value="08">08</option>
	              <option value="09">09</option>
	              <option value="10">10</option>
	              <option value="11">11</option>
	              <option value="12">12</option>
	            </select>
	            <select name="date" id="date">
	              <option value="01">01</option>
	              <option value="02">02</option>
	              <option value="03">03</option>
	              <option value="04">04</option>
	              <option value="05">05</option>
	              <option value="06">06</option>
	              <option value="07">07</option>
	              <option value="08">08</option>
	              <option value="09">09</option>
	              <option value="10">10</option>
	              <option value="11">11</option>
	              <option value="12">12</option>
	              <option value="13">13</option>
	              <option value="14">14</option>
	              <option value="15">15</option>
	              <option value="16">16</option>
	              <option value="17">17</option>
	              <option value="18">18</option>
	              <option value="19">19</option>
	              <option value="20">20</option>
	              <option value="21">21</option>
	              <option value="22">22</option>
	              <option value="23">23</option>
	              <option value="24">24</option>
	              <option value="25">25</option>
	              <option value="26">26</option>
	              <option value="27">27</option>
	              <option value="28">28</option>
	              <option value="29">29</option>
	              <option value="30">30</option>
	              <option value="31">31</option>
	            </select>
	          </li>
	
	          <li>
	            <label for="userEmail">이메일</label>
	            <input type="text" name="userEmail" id="userEmail">
	            <button type="button">아이디동일</button>
	          </li>
	
	          <li>
	            <label for="userEmail">도서 취향</label>
	            소설
	            <input type="checkbox" name="favorite" id="novel">
	            로맨스
	            <input type="checkbox" name="favorite" id="improve">
	            여행
	            <input type="checkbox" name="favorite" id="poem">
	            미스터리&sdot;스릴러
	            <input type="checkbox" name="favorite" id="economy">
	            과학
	            <input type="checkbox" name="favorite" id="comic">
	            만화
	            <input type="checkbox" name="favorite" id="trip">
	          </li>
	        </ul>
	        
	        <div class="btns">
	          <button type="button" class="enterInfoPrev">뒤로가기</button>
	          <button>회원가입</button>
	        </div>
	      </form>
	    </article>
	   
	    <article class="finish">
	      <h2>은하수 책방의 회원이 되신 걸 환영합니다.</h2>
	      <p>다양한 책들과 커뮤니티를 즐겨보세요!</p>
	      <p>메인화면으로 ... <span></span></p>
	    </article>
	  </section>
	  <footer>
      	<address>&copy;Designed by teamMillkyWay</address>
      </footer>
	</div>
</body>
</html>