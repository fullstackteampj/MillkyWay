<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/buy01.css?after" />
<script defer src="${pageContext.request.contextPath}/js/buy01.js"></script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../components/header.jsp" />
        <section class="buy">
            <h2>회원 주문/결제</h2>
            <div class="check-member">
                <p>아직 회원이 아니시라면?</p>
                <a href="/signup/signup01">회원가입</a>
                <a href="/login/login01">로그인</a>
            </div>
            <form action="#" name="buyFrm">
                <ul class="payment-info">
                    <li>
                        <h3>주문자 정보 입력</h3>
                        <ol>
                            <li>
                                <input type="text" name="buyName" id="buyName" placeholder="주문자의 이름을 입력해 주세요." required/>
                            </li>
                            <li>
                                <input type="text" name="buyPhone" id="buyPhone" placeholder="주문자의 휴대폰 번호를 '-' 없이 입력해 주세요." required/>
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
                                <input type="text" name="receiveName" id="receiveName" placeholder="받는 분의 이름을 입력해 주세요." required/>
                            </li>
                            
                            <li>
                                <input type="text" name="receivePhone" id="receivePhone" placeholder="받는 분의 휴대폰 번호를 '-'없이 입력해 주세요." required/>
                            </li>
                            <li>
                                <input type="text" name="buyZipcode" id="buyZipcode" placeholder="우편번호를 검색해 주세요." required/>
                                <button type="button">우편번호 검색</button>
                            </li>
                            <li>
                                <input type="text" name="buyAddress" id="buyAddress" placeholder="상세 주소를 입력해 주세요." required />
                            </li>
                        </ol>
                    </li>
                    <li>
                        <h3>주문 상품 (<span>총 2개</span>)</h3>
                        <ol class="buy-products">
                            <li class="more-two">
                                <img src="${pageContext.request.contextPath}/images/basicofjava.jpg" alt="basicofjava" />
                                <h4>자바의 정석</h4>
                                <p>1개</p>
                                <p>27000원</p>
                            </li>
                            <li>
                                <img src="${pageContext.request.contextPath}/images/basicofjava.jpg" alt="basicofjava" />
                                <h4>자바의 정석</h4>
                                <p>1개</p>
                                <p>27000원</p>
                            </li>
                        </ol>
                    </li>
                    <li>
                        <h3>결제 수단</h3>
                        <div class="btns-pay">
                            <button type="button">신용카드</button>
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
                <ul class="buy-total sticky">
                    <li>
                        상품 금액 <span></span>원
                    </li>
                    <li>
                        배송비 <span></span>원
                    </li>
                    <li>
                        포인트사용 <span></span>원
                    </li>
                    <li>
                        적립 예정 포인트 <span></span>원
                    </li>
                    <li>
                        최종 결제 금액 <span></span>원
                    </li>
                    <li>
                        <button>결제하기</button>
                    </li>
                </ul>
            </form>
        </section>
        <jsp:include page="../components/footer.jsp" />
    </div>
</body>
</html>