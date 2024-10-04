<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	if(confirm("회원 탈퇴를 시작합니다. \n한번 진행된 회원 탈퇴는 원상복구가 되지 않습니다. \n회원 탈퇴를 진행하시겠습니까?")){
		location.href = "/mypage/signoutOk";
	}else{
		alert("회원 탈퇴를 취소하셨습니다.");
		history.back();
	}
</script>
<body>

</body>
</html>