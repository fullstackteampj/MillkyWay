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
	String account = null;
	String name = null;
	String phone = null;
	String zipcode = null;
	String address = null;
	String detailAddress = null;
	int point = 0;
	String imgUrl = null;
	String tit = null;
	int price = 0;
	int bookid = 0;
	int orderNum = 0;
	String[] bookids = null;
	String[] orderNums = null;

	//ver1. 데이터 개수에 따라 if문으로 나누어서 다른 변수 타입에 저장
	if(request.getParameterValues("bookids") == null && request.getParameterValues("orderNums") == null){
		//배열 데이터가 없는 경우 단일데이터(바로 구매 버튼 통해서 들어오는 경우)
		bookid = Integer.parseInt(request.getParameter("bookid")); 
		orderNum = Integer.parseInt(request.getParameter("orderNum")); 
		
	}else{
		//배열 데이터가 있는 경우 (장바구니를 통해서 들어오는 경우)
		bookids =  request.getParameterValues("bookids");
		orderNums =  request.getParameterValues("orderNums");
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
	}
	
	//회원 정보 가져오기
	Vector<MemberBean> mlist = null;
	mlist = oMgr.getMember(userid);
	MemberBean mBean = mlist.get(0);
	
	account = mBean.getAccount();
	name = mBean.getName();
	phone = mBean.getPhoneNum().substring(0, 11);
	zipcode = mBean.getZipcode();
	address = mBean.getAddress();
	detailAddress = mBean.getDetailAddress();
	point = mBean.getCurpoint();
	
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
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
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
                        <h3>주문 상품 (총<span class="totNum">1</span>권)</h3>
                        <ol class="buy-products">
                        	<%
                        		if(bookids == null && orderNums == null){//단일데이터
                        			//책 정보 가져오기
                        			Vector<BookBean> vlist = null;
                        			vlist = iMgr.getBook(bookid);
                        			BookBean bean = vlist.get(0);
                        			imgUrl = "/image?bookid="+bookid;
                        			tit = bean.getTitle();
                        			price = bean.getPrice();
                        			%>
                        			<li>
		                                <img src="<%=imgUrl%>"
		                                    alt="<%=tit%>" />
		                                <h4><%=tit%>(<span class="regularPrice"><%=price%></span>원)</h4>
	                                    <div class="updown-qty">
								            <input type="text" name="eachNum" value="<%=orderNum%>"/>
								            <div class="btn-updown">
								              <button type="button">+</button>
								              <button type="button">-</button>
								            </div><!--btn-updown-->
							          	</div><!--updown-qty-->
		                                <p><span class="price"></span>원</p>
		                                <input type="hidden" name="bookids" value="<%=bookid%>" />
                            		</li>
                        			<%
                        		}else{//배열데이터
                        			for(int i=0; i<bookids.length; i++){
                        				//책 정보 가져오기
                        				Vector<BookBean> vlist = null;
                        				vlist = iMgr.getBook(Integer.parseInt(bookids[i]));
                        				BookBean bean = vlist.get(0);
                        				
                        				imgUrl = "/image?bookid="+bookids[i];
                        				tit = bean.getTitle();
                        				price = bean.getPrice();
                        				orderNum = Integer.parseInt(orderNums[i]);
                        				%>
                        				<li>
                        					<img src="<%=imgUrl%>"
		                                    alt="<%=tit%>" />
			                                <h4><%=tit%>(<span class="regularPrice"><%=price%></span>원)</h4>
			                           
			                                <div class="updown-qty">
									            <input type="text" name="eachNum" value="<%=orderNums[i]%>"/>
									            <div class="btn-updown">
									              <button type="button">+</button>
									              <button type="button">-</button>
									            </div><!--btn-updown-->
								          	</div><!--updown-qty-->
			                                <p><span class="price"></span>원</p>
                        				</li>
                        				<input type="hidden" name="bookids" value="<%=bookids[i]%>" />
                        				<%
                        				
                        			}//for
                        		}//if-else
                        	%>
                        </ol>
                    </li>
                    <li>
                        <h3>결제 수단</h3>
                        <div class="btns-pay">
                            <button type="button" >신용카드</button>
                            <button type="button">온라인입금</button>
                            <button type="button">휴대폰결제</button>
                            <button type="button">네이버페이</button>
                            <button type="button" class="on">카카오페이</button>
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
                        <input type="text" name="usePoint" value="0"/>
                        원
                        <button type=button class="usePointBtn">사용</button>
                        (보유 <span class="havePoint"><%=point%></span>p)
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
	
	//주문자와 동일 체크박스
	frm.checkSame.addEventListener('click', ()=>{
		if(frm.checkSame.checked){
			frm.receiveName.value = '<%=name%>';
			frm.receivePhone.value = '<%=phone%>';
			frm.zipcode.value = '<%=zipcode%>';
			frm.address.value = '<%=address%>';
			frm.detailAddress.value = '<%=detailAddress%>';
			if(frm.detailAddress.value === 'null'){
				frm.detailAddress.value = '';
			}
		}else{
			frm.receiveName.value = '';
			frm.receivePhone.value = '';
			frm.zipcode.value = '';
			frm.address.value = '';
			frm.detailAddress.value = '';
		}
	});
	
	//결제 API - 카카오페이
	const now = new Date();
	const randomNum = Math.floor(Math.random() * 101);//0-100 난수 
	const $totPrice = document.querySelector('.totalPrice');

	function reqKakaoPay(){
	  IMP.init("imp11026118"); //mykey
	  IMP.request_pay(
	      {
	        pg: "kakaopay.TC0ONETIME", //테스터용 코드 TC0ONETIME
	        pay_method: "card", // 생략가능
	        merchant_uid: "randomNum_" + randomNum + "order_time_" + now, 
	        //매번 다르게 설정되어야 다른 결제로 인식, 난수 + 현재 시간 붙여줌(동시 결제 고려)
	        name: "은하수 책방 도서구매",
	        amount: $totPrice.textContent,
	        buyer_email: "<%=account%>",
	        buyer_name: "<%=name%>",
	        buyer_tel: "<%=phone%>",
	        buyer_addr: "<%=address%> <%=detailAddress%>",
	        buyer_postcode: "<%=zipcode%>"
	      },
	      function (res) {
	        console.log(res);
	      // 결제 성공 시 처리
	                if (res.success) {
	                    console.log("res 성공~");
	                    // 백엔드로 주문 생성 요청
	                    axios.post("http://localhost:8080/orders/kakaoPay?impUid="+res.imp_uid).then((response) => {
	                        console.log('response.data = ' + response.data);
	                        frm.action = '/procs/buyProc?totalPrice=' +  $totPrice.textContent + '&point=' + $point.textContent;
	                        frm.submit();
	                        
	                    }).catch((error) => {
	                        console.error(error);
	                        alert("에러가 발생했습니다. 잠시후 다시 실행해 주세요.")
	                    });
	                }else{
	                    alert("에러메세지: " + rsp.error_msg);
	                }//else
	      }//function (res)
	  );//IMP.request_pay
	}//reqKakaoPay()
	
	//결제 API - 네이버페이
	 const oPay = Naver.Pay.create({
          "mode" : "development", // development or production
          "clientId": "HN3GGCMDdTgGUfl0kFCo", // clientId
          "chainId": "ZzhaL2phNm5GMmp", // chainId
          "openType": "popup",
          "onAuthorize": function(oData){
        	  if(oData.resultCode === "Success"){
        		  frm.action = '/procs/buyProc?totalPrice=' +  $totPrice.textContent + '&point=' + $point.textContent;
                  frm.submit();
        	  }else{
        		 console.log(oData.resultCode);
        		 console.log(oData.resultMessage);
        	  }
          }
    });

    function reqNaverPay() {
        oPay.open({
          "merchantPayKey": "12321323",
          "productName": "은하수책방 도서 구매",
          "totalPayAmount": $totPrice.textContent,
          "taxScopeAmount": $totPrice.textContent,
          "taxExScopeAmount": "0",
          "returnUrl": 'http://localhost:8080/procs/buyProc?totalPrice=' +  $totPrice.textContent + '&point=' + $point.textContent
        });
	 };

</script>
</body>
</html>
