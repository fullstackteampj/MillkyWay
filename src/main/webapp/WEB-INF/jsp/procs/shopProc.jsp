<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="oMgr" class="book.BookOrderMgr" />
<%
	request.setCharacterEncoding("UTF-8"); 
	int quantity = Integer.parseInt(request.getParameter("orderNum"));
	int bookid = Integer.parseInt(request.getParameter("bookid"));
	String save = request.getParameter("save");
	int userid = 0;
	
	if(session.getAttribute("idKeyS") !=null){
		//세션값 int로 저장 
		Object sessionValue = session.getAttribute("idKey");
		
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
	

	if(save.equals("cart")){//장바구니 추가시
		boolean checkResult = oMgr.checkCart(userid, bookid );
		if(checkResult){
			//carttbl에 이미 등록된 도서인 경우 레코드에 수량+1
			oMgr.plusQCart(userid,bookid); 
			%>
			<script>
			alert('이미 장바구니에 들어있던 도서의 수량을 +1 했습니다.');
			location.href = '/mypage/mypage05';
			</script>
			<%
		}else{
			//carttbl에 새로 추가하는 경우
			boolean plusResult = oMgr.insertCart(userid, bookid, quantity);
			if(plusResult){
				%>
				<script>
				if(confirm('장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?')){
					location.href = '/mypage/mypage05';
				}else{
					history.back();
				}
				</script>
				<%
			}else{
				%>
				<script>
					alert('장바구니에 담지 못했습니다. 다시 시도해주세요.');
					history.back();
				</script>
				<%
			}
		}
		
		
	}else{//관심목록 추가시
		boolean checkResult = oMgr.checkWish(userid, bookid);
		if(checkResult){
			//wishtbl에 이미 등록된 도서인 경우
			%>
			<script>
				alert('이미 관심목록에 들어있는 도서입니다. 이전 페이지로 돌아갑니다.');
				history.back();
			</script>
			<%
		}else{
			//wishtbl에 새로 추가해야하는 경우
			boolean plusResult = oMgr.insertWish(userid, bookid);
			if(plusResult){
				%>
				<script>
				if(confirm('관심목록에 담겼습니다. 관심목록으로 이동하시겠습니까?')){
					location.href = '/mypage/mypage05';
				}else{
					history.back();
				}
				</script>
				<%
			}else{
				%>
				<script>
					alert('관심목록에 담지 못했습니다. 다시 시도해주세요.');
					history.back();
				</script>
				<%
			}
		}//새로 추가 else
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>