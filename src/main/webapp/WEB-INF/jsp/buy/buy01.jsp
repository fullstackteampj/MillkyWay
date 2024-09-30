<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="beans.BookBean" %>
<%@ page import="beans.MemberBean" %>
<jsp:useBean id="iMgr" class="book.BookInfoMgr" />
<jsp:useBean id="oMgr" class="book.BookOrderMgr" />
<% 
	request.setCharacterEncoding("UTF-8");

	//id 기본으로 0  설정
	int userid = 0; 
	String name = null;
	String phone = null;
	String zipcode = null;
	String address = null;
	String detailAdress = null;
	int point = 0;
	String imgUrl = null;
	String tit = null;
	int price = 0;
	int bookid = 0;
	int orderNum = 0;
	

	if(request.getParameterValues("bookids") == null){
		//배열 데이터가 없는 경우 단일데이터(바로 구매 버튼 통해서 들어오는 경우)
		bookid = Integer.parseInt(request.getParameter("bookid")); 
		orderNum = Integer.parseInt(request.getParameter("orderNum")); 
	}else{
		//배열 데이터가 있는 경우 (장바구니를 통해서 들어오는 경우)
		String[] bookids = request.getParameterValues("bookids");
		String[] orderNums = request.getParameterValues("orderNums");
	}

	
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

		
		//책 정보 가져오기
		Vector<BookBean> vlist = null;
		vlist = iMgr.getBook(bookid);
		BookBean bean = vlist.get(0);
		
		imgUrl = "/image?bookid="+bookid;
		tit = bean.getTitle();
		price = bean.getPrice();
		
		//회원 정보 가져오기
		Vector<MemberBean> mlist = null;
		mlist = oMgr.getMember(userid);
		MemberBean mBean = mlist.get(0);
		
		name = mBean.getName();
		phone = mBean.getPhoneNum();
		zipcode = mBean.getZipcode();
		address = mBean.getAddress();
		detailAdress = mBean.getDetailAddress();
		point = mBean.getCurpoint();
	}
%>
	

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>구매 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buy01.css?after" />
    <script defer src="${pageContext.request.contextPath}/js/buy01.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
    <div id="wrap">
        <jsp:include page="../components/header.jsp" />
        <section class="buy">
            <h2>회원 주문/결제</h2>
            <form name="buyFrm" method="post"> <!-- 결제수단 쿼리스트링으로 JS에서 action 설정 -->
                <ul class="payment-info">
                    <li>
                        <h3>주문자 정보 입력</h3>
                        <ol>
                            <li>
                                <input type="text" name="buyName" id="buyName"
                                    placeholder="주문자의 이름을 입력해 주세요." value="<%=name%>" required />
                            </li>
                            <li>
                                <input type="text" name="buyPhone" id="buyPhone"
                                    placeholder="주문자의 휴대폰 번호를 '-' 없이 입력해 주세요." value="<%=phone%>" required />
                            </li>
                        </ol>
                    </li>

                    <li>
                        <div class="check-same">
                            <h3>배송지 정보</h3>
                            <p>
                                <input type="checkbox" name="checkSame" id="checkSame" />
                                <label for="checkSame">주문자와 동일</label>
                            </p>
                        </div>
                        <ol>
                            <li>
                                <input type="text" name="receiveName" id="receiveName"
                                    placeholder="받는 분의 이름을 입력해 주세요." required />
                            </li>

                            <li>
                                <input type="text" name="receivePhone" id="receivePhone"
                                    placeholder="받는 분의 휴대폰 번호를 '-'없이 입력해 주세요." required />
                            </li>
                            <li>
                                <input type="text" name="zipcode" id="zipcode"
                                    required />
                                <input type="text" name="address" id="address" placeholder="우편번호를 검색해 주세요." required />
                                <button type="button" onclick="zipSearch()">검색</button>
                            </li>
                            <li>
                                <input type="text" name="detailAddress" id="detailAddress"
                                    placeholder="상세 주소를 입력해 주세요." required />
                            </li>
                        </ol>
                    </li>
                    <li>
                        <h3>주문 상품</h3>
                        <ol class="buy-products">
                            <li>
                                <img src="<%=imgUrl%>"
                                    alt="<%=tit%>" />
                                <h4><%=tit%>(<span class="regularPrice"><%=price%></span>원)</h4>
                                <p><span class="orderNum"><%=orderNum%></span>권</p>
                                <p><span class="price"></span>원</p>
                            </li>
                        </ol>
                    </li>
                    <li>
                        <h3>결제 수단</h3>
                        <div class="btns-pay">
                            <button type="button" class="on">신용카드</button>
                            <button type="button">온라인입금</button>
                            <button type="button">휴대폰결제</button>
                            <button type="button">네이버페이</button>
                            <button type="button">카카오페이</button>
                            <button type="button">토스페이</button>
                            <button type="button">삼성페이</button>
                            <button type="button">실시간 계좌이체</button>
                        </div>
                    </li>
                </ul>
                <ul class="buy-total">
                    <li>
                        상품 금액 <span class="prodPrice"></span>원
                    </li>
                    <li>
                        배송비 2000원
                    </li>
                    <li>
                        포인트
                        <input type="text" name="usePoint">
                        원
                        <button>사용</button>
                        (보유 <span><%=point%></span>p)
                    </li>
                    <li>
                        적립 예정 포인트 <span class="point"></span>p (10%)
                    </li>
                    <li>
                        최종 결제 금액 <span class="totalPrice"></span>원
                    </li>
                    <li>
                        <button>결제하기</button>
                    </li>
                </ul>
            </form>
        </section>
        <jsp:include page="../components/footer.jsp" />
    </div>
<script>
	const frm = document.buyFrm;
	
	frm.checkSame.addEventListener('click', ()=>{
		if(frm.checkSame.checked){
			frm.receiveName.value = '<%=name%>';
			frm.receivePhone.value = '<%=phone%>';
			frm.zipcode.value = '<%=zipcode%>';
			frm.address.value = '<%=address%>';
			frm.detailAddress.value = '<%=detailAdress%>';
		}else{
			frm.receiveName.value = '';
			frm.receivePhone.value = '';
			frm.zipcode.value = '';
			frm.address.value = '';
			frm.detailAddress.value = '';
		}
	});
	
</script>
</body>
</html>
