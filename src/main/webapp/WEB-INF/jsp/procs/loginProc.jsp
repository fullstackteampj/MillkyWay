<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="SHA256.SHASalt"%>
<%@ page import="beans.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="lMgr" class="login.LoginMgr" />
<jsp:useBean id="sha" class="SHA256.SHASalt" />
<%
	String account = request.getParameter("id");
	String inpwd = request.getParameter("pwd");
	String saveId = request.getParameter("saveId");
	
	MemberBean mBean = lMgr.getLoginInfo(account);

	if(mBean.getUserid()==0) {
		%>
		<script>
			alert("일치하는 아이디가 없습니다.");
			location.href = "/login/login01";
		</script>
		<%
	}
	
	int userId = mBean.getUserid();
	String userIdS = Integer.toString(mBean.getUserid());
	
	
	// SHASALT를 이용하여 해시화된 비밀번호 생성 및 비교
	SHASalt SHASalt = new SHASalt();
	String salt = mBean.getSalt();
	
	String CrPwd = SHASalt.getEncrypt(inpwd, salt);
	String dbPwd = mBean.getPwd();
	
	//입력된 비밀번호 해쉬값과 DB에 저장된 해시갑을 비교
	if(!CrPwd.equals(dbPwd)){
		%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
		<%
	}else{
		
		// 관리자 아이디일 경우 관리자 페이지로 이동 및 관리자 인증 세션 생성
		if(mBean.getStatus().equals("admin")) {
			response.sendRedirect("/admin/insert");
			session.setAttribute("admin", "admin");
			lMgr.updateLastLogin(userId); // 마지막로그인 날짜 업데이트
			return;
		}
		
		session.setAttribute("idKey", userId);
		session.setAttribute("idKeyS", userIdS);
		lMgr.updateLastLogin(userId); // 마지막로그인 날짜 업데이트
		
		if(saveId!=null){
		    Cookie cookie = new Cookie("saveId", account);
		    cookie.setPath("/login/login01");
		    cookie.setMaxAge(60 * 60 * 24 * 7);//쿠키의 보관기간 7일
		    response.addCookie(cookie);
		    // System.out.println("Cookie Name: " + cookie.getName() + ", Value: " + cookie.getValue());
		}else{
			Cookie cookie = new Cookie("saveId", account);
		    cookie.setPath("/login/login01");
		    cookie.setMaxAge(0); // 만료 설정
		    response.addCookie(cookie);
		}
		%>
		<script>
			alert("로그인에 성공하였습니다.");
			location.href="/";
		</script>
		<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginProc</title>
</head>
<body>

</body>
</html>