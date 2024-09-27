<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 확인</title>
<style>
	p{
		margin: 50px 0 80px;
		padding: 10px 0;
		font-size: 18px;
		text-align: center;
	}
	.btns{
		display: flex;
		flex-flow: row nowrap;
		justify-content: space-between;
		align-items: center;
		width: 230px;
		margin: 0 auto;
	}
	.btns>button{
		border: none;
		outline: none;
		width: 100px;
		height: 40px;
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
		self.close();
		window.opener.location.href = '/login/login01';
	}
	
	const signupFn = () => {
		self.close();
		window.opener.location.href = '/signup/signup01';
	}
	
</script>
</head>
<body>
	<p><strong>은하수 책방 회원만 <br />이용 가능한 서비스 입니다.</strong></p>
	<div class="btns">
		<button type="button" onclick="loginFn()">로그인</button>
		<button type="button" onclick="signupFn()">회원가입</button>
	</div>
</body>
</html>