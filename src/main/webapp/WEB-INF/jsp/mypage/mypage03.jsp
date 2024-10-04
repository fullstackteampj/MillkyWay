<%request.setCharacterEncoding("utf-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="beans.MemberBean"%>
<jsp:useBean id="myMgr" class="myPage.MyPageMgr"/>
<%
	if (session.getAttribute("idKeyS") == null) {
	    %>
	    <script>
	        alert("세션이 만료되었습니다. 로그인 페이지로 이동합니다.");
	        location.href="/login/login01";
	    </script>
	    <%
	    return;
	}
	String userId = (String) session.getAttribute("idKeyS");
	
	MemberBean mBean = myMgr.getMemberUpdate(Integer.parseInt(userId));
	if(mBean.getDetailAddress()==null){
		mBean.setDetailAddress("상세주소를 입력해주세요");
	}
%>
    
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>mypage03</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css?after" />
  <script defer src="https://kit.fontawesome.com/9ad59cd5cc.js" crossorigin="anonymous"></script>
  <script>
 	function check() {
 		if(userUpdateFrm.nickname.value==null||userUpdateFrm.nickname.value==""){
			alert("닉네임을 입력해주세요");
			userUpdateFrm.nickname.focus();
			return;
 		}
 		if(userUpdateFrm.phone.value==null||userUpdateFrm.phone.value==""){
			alert("전화번호를 입력해주세요");
			userUpdateFrm.phone.focus();
			return;
 		}
 		if(userUpdateFrm.email.value==null||userUpdateFrm.email.value==""){
			alert("이메일을 입력해주세요");
			userUpdateFrm.email.focus();
			return;
 		}
 		if(userUpdateFrm.address.value==null||userUpdateFrm.address.value==""){
			alert("주소를 입력해주세요");
			userUpdateFrm.address.focus();
			return;
 		}
 		
 		//네이버 회원일 경우 비밀번호 확인 없이 없데이트 실행
 		if(userUpdateFrm.inpwd.value==='sns') {
 	 		userUpdateFrm.submit();
 	 		return;
 		}
 		
 		// 기존회원일 경우 비밀번호 입력 유효성검사진행
 		if(userUpdateFrm.inpwd.value==null||userUpdateFrm.inpwd.value==""){
			alert("정보를 수정하기 위해 비밀번호를 입력해주세요.");
			userUpdateFrm.inpwd.focus();
			return;
 		}
 		
 		userUpdateFrm.submit();
	}//check()
	
	
	function checkSignOut() {
		if(confirm("한번 탈퇴한 아이디(이메일)로는 재가입이 불가능 합니다. \n 회원 탈퇴를 진행하시겠습니까?")) {
			location.href="/mypage/signout";
		}
	}//checkSignOut()
	
	
   </script>
</head>

<body>

  <div id="wrap">
    <jsp:include page="../components/header.jsp" />

    <section  class="myPage03">
      <h2 class="sr-only">회원페이지</h2>
      
       <jsp:include page="../components/myPageSectionHead.jsp" />

      <div class="mainContainer">
        <h3>회원정보수정</h3>

        <div class="updateContainer">
          <form name="userUpdateFrm" method="post" action="/procs/userUpdateProc">
            <label for="nickname">닉네임</label>
            <input type="text" name="nickname" id="nickname" value="<%= mBean.getNickname() %>" />
			
			<span class="genLabel">성별</span>
			<%
			if(mBean.getGender().equals("M")) {
				%>
	            <span>남</span>
	            <input type="radio" name="gender" value="M" checked />
	            <span>여</span>
	            <input type="radio" name="gender" value="F" />
				<%
			}else if(mBean.getGender().equals("F")) {
				%>
	            <span>남</span>
	            <input type="radio" name="gender" value="M"  />
	            <span>여</span>
	            <input type="radio" name="gender" value="F" checked/>
				<%
			}
			%>

            <label for="phone">전화번호</label>
            <input type="text" name="phone" id="phone" value="<%= mBean.getPhone() %>" />

            <label for="email">이메일</label>
            <input type="text" name="email" id="email" value="<%= mBean.getEmail() %>" />

            <label for="address">주소</label>
            <button type="button" onclick="searchAddAPI()">우편번호찾기</button>
            <input type="text" name="address" id="address" value="<%= mBean.getAddress() %>" />

            <label for="detailAddress">상세주소</label>
            <input type="text" name="detailAddress" id="detailAddress" value="<%= mBean.getDetailAddress() %>" />

			<%
			if(mBean.getStatus().equals("sns")){
				%>
	            <input type="hidden" name="inpwd" id="inpwd" value="sns" />
				<%
			}else{
				%>
	            <label for="inpwd">비밀번호 입력</label>
	            <input type="password" name="inpwd" id="inpwd" placeholder="비밀번호를 입력해주세요~" />
				<%
			}
			%>


            <button type="button" onClick="check()">수정하기</button>
            <button type="button" onClick="document.userUpdateFrm.reset()">다시쓰기</button>
            <button type="button" onClick="checkSignOut()">탈퇴하기</button>
          	<input type="hidden" name="userId" value="<%=userId%>" />
          </form>
        </div>
      </div>
    </section>


    <jsp:include page="../components/footer.jsp" />

    <jsp:include page="../components/aside.jsp" />

  </div>

</body>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function searchAddAPI() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let roadAddr = data.roadAddress; // 도로명 주소 변수
                let extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = roadAddr;
            }
        }).open();
    }
</script>

 

</html>