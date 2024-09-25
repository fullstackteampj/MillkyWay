<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 확인</title>
<style>
	p{
		padding: 70px;
		font-size: 18px;
		text-align: center;
	}
	.btns{
		display: flex;
		flex-flow: row nowrap;
		justify-content: space-between;
		align-items: center;
		width: 300px;
		margin: 0 auto;
	}
	.btns>button{
		border: none;
		outline: none;
		width: 120px;
		height: 50px;
		color: #fdfdfd;
		font-size: 16px;
		text-align: center;
		background-color: #ddd; /*포인트 컬러로 변경 필요*/
		border-radius: 5px;
		cursor: pointer;
	}
	.btns>button:hover{
		background-color: #ccc; /*포인트 컬러로 변경 필요*/
	}
</style>
<script>
	const loginFn = () => {
		window.opener.location.href = '/login/login01';
		self.close();
	}
	
	const signupFn = () => {
		window.opener.location.href = '/sign/signup01';
		self.close();
	}
	
</script>
</head>
<body>
	<p><strong>은하수 책방 회원만 이용 가능한 서비스 입니다.</strong></p>
	<div class="btns">
		<button type="button" onclick="loginFn()">로그인</button>
		<button type="button" onclick="signupFn()">회원가입</button>
	</div>
</body>
</html>