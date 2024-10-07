<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="oMgr" class="book.BookOrderMgr" />
<%
	request.setCharacterEncoding("UTF-8");

	int userid = 0; 
	//세션에서 아이디 값 int로 가져오기
	if(session.getAttribute("idKeyS") != null){
		//세션값 int로 저장 
		Object sessionValue = session.getAttribute("idKeyS");
		
		// 타입 확인 후 변환
		if (sessionValue instanceof String) {
		    String strValue = (String) sessionValue; // String으로 캐스팅
		    try {
		        userid = Integer.parseInt(strValue);
		    } catch (NumberFormatException e) {
		        e.printStackTrace(); // 변환 실패 시 예외 처리
		    }
		} else if (sessionValue instanceof Integer) {
		    // 만약 세션에 직접 Integer로 저장되어 있다면
		    userid = (Integer) sessionValue; 
		} 
	}

	String[] bookids = null;
	String[] eachNum = null;
	String payMethod = request.getParameter("payMethod");
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	int usePoint = Integer.parseInt(request.getParameter("usePoint"));
	int savePoint = Integer.parseInt(request.getParameter("point"));
	boolean result = false;
	boolean mResult = false;
	boolean sResult = false;
	boolean uResult = false;
	
	//ver.2 데이터 개수에 상관없이 배열로 받기(그래서 bean파일 사용 안함)
	bookids =  request.getParameterValues("bookids");
	eachNum =  request.getParameterValues("eachNum");
	
	result = oMgr.insertPurchase(userid, bookids, eachNum, payMethod, totalPrice);
	
	//회원 테이블에서 포인트 수정
	mResult = oMgr.updateMemberPoint(userid, usePoint, savePoint);
	if(mResult) System.out.println("회원 테이블의 포인트 수정 완료");
	
	//포인트관리 테이블에서 내역 추가
	sResult = oMgr.insertPointManage(userid, savePoint, "적립");
	if(sResult) System.out.println("포인트관리테이블의 포인트 적립 추가 완료");
	if(usePoint != 0){
		uResult = oMgr.insertPointManage(userid, usePoint, "사용");
		if(uResult) System.out.println("포인트관리테이블의 포인트 사용 추가 완료");
	}
	
	
	if(result){
		%>
		<script>
			alert('구매가 완료되었습니다. 메인 페이지로 이동합니다.');
			location.href = '/';
		</script>
		<%
	}else{
		%>
		<script>
			alert('구매가 실패했습니다. 다시 시도해주세요.');
			history.back();
		</script>
		<%
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>은하수 책방 - 구매 처리</title>
</head>
<body>

</body>
</html>