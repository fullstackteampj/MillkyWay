<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="beans.BookBean"%>
<%@ page import="beans.PurchaseBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="myMgr" class="myPage.MyPageMgr" />
<%
	String purchaseid = request.getParameter("purchaseid");
	String bookid = request.getParameter("bookid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소/환불하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
<style>
	body{
		overflow: hidden;
		padding: 20px;
		background-color: #b6e2f7;
		box-sizing: border-box;
	}
	
	.cancelContainer{
		width: 560px;
		height: 510px;
		margin: 0 auto;
		padding: 5px;
		background-color: #fff;
		border-radius: 10px;
		box-sizing: border-box;
	}
	
	h1{
		height: 50px;
		text-align: center;
		line-height: 50px;
	}
	
	.bookContainer{
		display: flex;
		justify-content:space-between;
		height: 150px;
	}
	
	.bookContainer > img {
	  height: 100%;
	  margin-left: 50px;
	}
	.bookContainer > .bookInfo {
	  display: flex;
	  flex-flow: column nowrap;
	  justify-content: space-evenly;
	  align-items: center;
	  flex: 1 1 0;
	  height: 100%;
	  padding-left: 50px;
	  box-sizing: border-box;
	}
	.bookContainer > .bookInfo > .buydate {
	  color: #aaa;
	}
	.bookContainer > .bookInfo > .title {
	  font-size: 20px;
	}
	.bookContainer > .bookInfo > .author {
	  font-size: 14px;
	}
	.bookContainer > .bookInfo > .price {
	  font-weight: 800;
	}
	
	form[name=canFrm]{
		display: flex;
		flex-flow: column nowrap;
		width: 450px;
		margin: 0 auto;
		padding: 20px 0;
		box-sizing: border-box;
	}
	
	form[name=canFrm]>label,
	form[name=canFrm]>input,
	form[name=canFrm]>textarea{
		margin: 5px 0;
	}
	
	form[name=canFrm]>textarea{
		height: 200px;
	}
	
	form[name=canFrm]>button{
		border: none;
		outline: none;
		background: none;
		
		height: 30px;
		margin-top: 5px;
		color: #fff;
		font-weight: 500;
		background-color: #b6e2f7;
		border-radius: 10px;
	}
	
</style>

<script>
	function chkCancel() {
		if(confirm("상품이 배송중일 경우 왕복 수수료가 발생할 수 있습니다. 취소를 진행합니다.")){
			document.canFrm.submit();
		}
	}//chkCancel()
	
	function chkRefund() {
		if(confirm("고객님께서 남겨주신 환불 사유를 확인하여 환불처리를 진행할 예정입니다.")){
			document.canFrm.submit();
		}
	}//chkCancel()
</script>

</head>
<body>

	<%
	// status quantity purchase_date
	PurchaseBean pBean = myMgr.getCanPurInfo(purchaseid);
	// author title price
	BookBean bBean = myMgr.getCanBookInfo(bookid);
	%>
	<div class="cancelContainer">
		<%
		if(pBean.getStatus().equals("대기중")||
		pBean.getStatus().equals("대기 중")||
		pBean.getStatus().equals("배송중")||
		pBean.getStatus().equals("배송 중")){
			%>
			<h1>주문 취소(<%=pBean.getStatus()%>)</h1>
			<div class="bookContainer">
	            <img src="/image?bookid=<%= bookid %>" alt="<%= bBean.getTitle() %>" />
	            <div class="bookInfo">
	              <p class="buydate"><%= pBean.getPurchase_date() %> 결제</p>
	              <p class="title"><%= bBean.getTitle() %></p>
	              <p class="author"><%= bBean.getAuthor() %></p>
	              <p class="price"><%= bBean.getPrice() %>원(<%= pBean.getQuantity() %>권)</p>
	              <p class="price">총 금액 <%=bBean.getPrice()*pBean.getQuantity()%>원</p>
	            </div>
			</div>
			<form name="canFrm" method="post" action="/procs/cancelProc">
				<label for="cancellation_reason">취소사유</label>
				<textarea name="cancellation_reason" id="cancellation_reason" rows="4" cols="50" placeholder="취소 사유를 작성해주세요"></textarea>
				<input type="hidden" name="status" value="취소" />
				<input type="hidden" name="purchaseid" value="<%=pBean.getPurchaseid()%>" />
				<input type="hidden" name="price" value="<%=bBean.getPrice()%>" />
				<input type="hidden" name="quantity" value="<%=pBean.getQuantity()%>" />
				<button type="button" onClick="chkCancel()">취소 신청</button>
			</form>
			<%
		}else if(pBean.getStatus().equals("배송완료")||
				pBean.getStatus().equals("배송 완료")||
				pBean.getStatus().equals("구매완료")||
				pBean.getStatus().equals("구매 완료")){
			%>
			<h1>환불 요청(<%=pBean.getStatus()%>)</h1>
			<div class="bookContainer">
	            <img src="/image?bookid=<%= bookid %>" alt="<%= bBean.getTitle() %>" />
	            <div class="bookInfo">
	              <p class="buydate"><%= pBean.getPurchase_date() %> 결제</p>
	              <p class="title"><%= bBean.getTitle() %></p>
	              <p class="author"><%= bBean.getAuthor() %></p>
	              <p class="price"><%= bBean.getPrice() %>원(<%= pBean.getQuantity() %>권)</p>
	            </div>
			</div>
			<form name="canFrm" method="post" action="/procs/cancelProc">
				<label for="cancellation_reason">환불사유</label>
				<textarea name="cancellation_reason" id="cancellation_reason" rows="4" cols="50" placeholder="환불 사유를 작성해주세요"></textarea>
				<input type="hidden" name="status" value="환불" />				
				<input type="hidden" name="purchaseid" value="<%=pBean.getPurchaseid()%>" />
				<input type="hidden" name="price" value="<%=bBean.getPrice()%>" />
				<input type="hidden" name="quantity" value="<%=pBean.getQuantity()%>" />
				<button type="button" onClick="chkRefund()">환불 신청</button>
			</form>
			<%
		}
		%>
	</div>
	

</body>
</html>
















