<%@page import="beans.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="comMgr" class="components.ComponentsMthod" /> 
<%
	request.setCharacterEncoding("utf-8");
	String userId = (String) session.getAttribute("idKeyS");
	
	// 임시로 3번 지정을 위한 코드
	if (userId == null) {
		userId = "3";
	}
	MemberBean mbean = comMgr.getMypageMember(Integer.parseInt(userId));
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPageSectionHead</title>
</head>
<body>

	<div class="sectionHead">

        <ul class="myPageList">
	        <li><a href="/mypage/mypage01">구매목록</a></li>
	        <li><a href="/mypage/mypage02">취소/반품내역</a></li>
	        <li><a href="/mypage/mypage03">회원정보수정</a></li>
	        <li><a href="/mypage/mypage04">내가 쓴 글</a></li>
	        <li><a href="/mypage/mypage05">장바구니/관심목록</a></li>
        </ul>

        <div class="myInfoContainer">
          <h3><%= mbean.getName() %>님 안녕하세요!</h3>

          <div class="myGrade">
            <p class="grade">
              <span>멤버십 등급</span>
              <span class="userGrade"><%= mbean.getUsergrade() %></span>
            </p>
            <p class="point">
              <span class="curPoint">사용가능 포인트 : <%= mbean.getCurpoint() %>P</span>
              <span class="expectPoint">적립예정 포인트 : <%= mbean.getExpectpoint() %>P</span>
            </p>

          </div>

          <div class="myInfo">
	          <%
	       		if(userId!=null&&mbean.getStatus().equals("sns")){
					%>
					<p class="name">이름 : <%= mbean.getName() %></p>
		            <p class="account">아이디 : 네이버로그인 회원입니다</p>
		            <p class="gender">성별 : <%= mbean.getGender() %></p>
		            <p class="email">email : <%= mbean.getEmail() %></p>
		            <p class="address">기본배송지 : <%= mbean.getAddress() %></p>
					<%
	       		}else{
					%>
					<p class="name">이름 : <%= mbean.getName() %></p>
		            <p class="account">아이디 : <%= mbean.getAccount() %></p>
		            <p class="gender">성별 : <%= mbean.getGender() %></p>
		            <p class="email">email : <%= mbean.getEmail() %></p>
		            <p class="address">기본배송지 : <%= mbean.getAddress() %></p>
					<%
	       		}
	          %>

          </div>

        </div>

      </div>

</body>
</html>