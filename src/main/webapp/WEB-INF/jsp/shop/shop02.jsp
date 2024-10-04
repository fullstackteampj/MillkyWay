<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.util.Vector" %>
<%@ page import="beans.BookBean" %>
<%@ page import="beans.ReviewBean" %>
<jsp:useBean id="bMgr" class="book.BookInfoMgr" />
<%
	request.setCharacterEncoding("UTF-8");

	//로그인 상태 확인
	int userid = 0; 
	
	if(session.getAttribute("idKeyS") !=null){
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
	
	

	int bookid = Integer.parseInt(request.getParameter("bookid"));
	Vector<BookBean> vlist = null;
	vlist = bMgr.getBook(bookid);
	BookBean bean = vlist.get(0);
	
	//책 정보 가져오기
	String imgUrl = "/image?bookid="+bookid;
	String tit = bean.getTitle();
	String author = bean.getAuthor();
	int price = bean.getPrice();
	int score = bean.getScore();
	String pdate = bean.getPublish_date();
	String category = bean.getCategory();
	String genre = bean.getGenre();
	String contents = bean.getContents();
	String ctable = bean.getContentsTables();
	String aIntro = bean.getAuthorIntro();
	String isbn = bean.getIsbn();
	int pages = bean.getPages();
	
	//한줄평 총 개수 
	int totalReview = bMgr.totalReview(bookid);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop02.css?after" />
  <title>상품 상세 페이지</title>
  <script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
  <script defer src="${pageContext.request.contextPath}/js/shop02.js"></script>
</head>

<body>
	<div id="wrap">
	  <jsp:include page="../components/header.jsp" />
	  <section class="shop-product">
	    <form name="quickFrm" method="post">
	      <div>
	        <p><%=tit%></p>
	        <p>총 금액<span class="quick-total"></span></p>
	        <button onclick="toBuy(event)">바로구매</button>
	        <button onclick="toCart(event)">장바구니</button>
	        <button onclick="toWish(event)">관심목록</button>
	      </div>
	      <input type="hidden" name="bookid" value="<%=bookid%>" />
	    </form><!--form name="quickFrm"-->
	
	    <h2>
	      <i class="fa-solid fa-chevron-left"></i>
	      <span><%=tit%></span>
	    </h2>
	    <p>지은이 : <span><%=author%></span></p>
	    <p><%=pdate%> 출판</p>
	    <div class="headbook">
	      <img src="<%=imgUrl%>" alt="<%=tit%>">
	      
	      <form name="orderFrm" method="post">
	        <h3>가격 : <span><%=price%></span>원</h3>
	        <p>
	          포인트 :
	          <span class="point"></span>원 적립 (판매가의 10% 적립)
	        </p>
	        <p>배송료 : 2000원<span>(5만원 이상 무료배송)</span></p>
	        <p>
	          <%
	        		for(int c=0; c<score; c++){//별생성
	        			%>
	        			<i class="fa-solid fa-star"></i>
	        			<%
	        		}//for - make colorstar
	        		for(int e=0; e<5-score; e++){
	        			%>
	        			<i class="fa-regular fa-star"></i>
	        			<% 
	        		}//for - make emptystar
	        	%>
	          <span><%=score%></span>
	          <a href="#" class="scroll-oneReview">한줄평(<span><%=totalReview%></span>)</a>
	        </p>
	
	        <div class="order-qty">
	          <div class="updown-qty">
	            <p>수량 : </p>
	            <input type="text" name="orderNum" value="1"/>
	            <div class="btn-updown">
	              <button type="button">+</button>
	              <button type="button">-</button>
	            </div><!--btn-updown-->
	          </div><!--updown-qty-->
	          <p>
	            <span class="pretotal"></span>
	            <span></span>
	            <i class="fa-solid fa-arrow-right"></i>
	          	총 금액
	            <span class="total-price"></span>
	          </p>
	        </div><!--order-qty-->
	        <input type="hidden" name="bookid" value="<%=bookid%>" />
	        <div class="btns-quickbuy">
	          <button onclick="toBuy(event)">바로구매</button>
	          <button onclick="toCart(event)">장바구니</button>
	          <button onclick="toWish(event)">관심목록</button>
	        </div><!--.btns-quickbuy-->
	        <input type="hidden" name="bookid" value="<%=bookid%>" />
	      </form>

	    </div><!--.headbook-->
	
	    <ul>
	      <li>
	        <h3>기본정보</h3>
	        <p>
	          전체 페이지 수 : <%=pages%>쪽<br />
	          1942gISBN : <%=isbn%><br />
	          주제 분류<br />
	          <a href="/shop/shop01?category=<%=category%>"><%=category%></a> > 
	          <a href="/shop/shop01?category=<%=category%>&genre=<%=genre%>"><%=genre%></a>
	        </p>
	      </li>
	      <li>
	        <h3>이벤트</h3>
	        <div class="container-events">
	          <div class="slide-events">
	            <article>
	              <a href="#">
	                <div class="img-event">
	                </div>
	                <h4>IT 신간.스테디셀러 대상도서 2만원 이상 구매시 위스키 글라스</h4>
	              </a>
	            </article>
	            <article>
	              <a href="#">
	                <div class="img-event">
	                </div>
	                <h4>함께 사면 무료배송. 1천원~4천원대 굿즈 총집합</h4>
	              </a>
	            </article>
	            <article>
	              <a href="#">
	                <div class="img-event">
	                </div>
	                <h4>한빛미디어 IT브랜드전. 다양한 사무용품도 함께 가져가기</h4>
	              </a>
	            </article>
	            <article>
	              <a href="#">
	                <div class="img-event">
	                </div>
	                <h4>8월 특별 선물. 1박2일 보스턴백 &sdot;피크닉 매트(이벤트 도서 포함 국내서&sdot;외서 5만원 이상)</h4>
	              </a>
	            </article>
	            <article>
	              <a href="#">
	                <div class="img-event">
	                </div>
	                <h4>이 달의 퀴즈 적립금</h4>
	              </a>
	            </article>
	            <article>
	              <a href="#">
	                <div class="img-event">
	                </div>
	                <h4>대학교재.토익.자격증.취업 교재 5만원 이상 구매 시</h4>
	              </a>
	            </article>
	
	          </div><!--.slide-events-->
	          <div class="page-dots">
	            <a href="#" class="on"></a>
	            <a href="#"></a>
	          </div><!--.page-dots-->
	        </div><!--.container-events-->
	      </li>
	      <li>
	        <h3>책소개</h3>
	        <p><%=contents%></p>
	      </li>
	      <li>
	        <h3>목차</h3>
	        <ol>
	        <%
	        	//DB저장된 목차: 문자열 -> 쉼표 and 띄어쓰기 별로 나누기
	        	String[] ctableArr = ctable.split(",|\\n");
	        	
	        
	        	for(int i=0; i<ctableArr.length; i++){
	        		
	        		%>
	        		<li><%=ctableArr[i]%></li>
	        		<%
	        	}
	        %>  
	        </ol>
	
	      </li>
	      <li>
	        <h3>저자 소개</h3>
	        <p><%=aIntro%></p>
	      </li>
	
	      <li class="one-review">
	        <h3>한줄평</h3>
	        <div class="star-avg">
	          <h4>평균<br />별점</h4>
	          <p>
	          	<%
	          		for(int c=0; c<score; c++){//별생성
	          			%>
	          			<i class="fa-solid fa-star"></i>
	          			<%
	          		}
	          		for(int e=0; e<5-score; e++){
	          			%>
	          			<i class="fa-regular fa-star"></i>
	          			<%
	          		}
	          	%>
	            <%=score%>.0 / 5.0
	            <i class="fa-solid fa-pencil"></i>
	          </p>
	        </div><!--star-avg-->
	        <form name="reviewFrm" method="post">
	          <div class="input-star">
	            <i class="fa-solid fa-star"></i>
	            <i class="fa-solid fa-star"></i>
	            <i class="fa-solid fa-star"></i>
	            <i class="fa-solid fa-star"></i>
	            <i class="fa-solid fa-star"></i>
	          </div>
	          <input name="content" id="content" type="text" max="70"/>
	          <button type="button" onclick="reviewFn()">입력</button>
	          <input type="hidden" name="bookid" value="<%=bookid%>" />
	        </form>
	        <ul>
	        <%
	        	//한줄평 출력
	        	Vector<ReviewBean> rlist = null;
	        	rlist = bMgr.getReview(bookid);
	        	
	        	if(rlist.size() == 0){
	        		%>
	        		<li>등록된 한줄평이 없습니다.</li>
	        		<%
	        	}else{
	        		
		        	for(int i=0; i<rlist.size(); i++){
		        		ReviewBean rbean = rlist.get(i);
		        		int rScore = rbean.getScore();
		        		String rContent = rbean.getContent();
		        		String nickname = rbean.getNickname();
		        		%>
		        		<li>     
		        		<%
		        		for(int c=0; c<rScore; c++){//별 생성
		        			%>
		        			<i class="fa-solid fa-star"></i>
		        			<%
		        		}//for - make colorstar
		        		for(int e=0; e<5-rScore; e++){
		        			%>
		        			<i class="fa-regular fa-star"></i>
		        			<% 
		        		}//for - make emptystar
		        		%>
			        		<p><%=rContent%></p>
			        		<span><%=nickname%></span>
		        		</li>
		        		<%
		        	}//for - li 
	        	}//else
	        %>
	         
	        </ul>
	      </li>
	    </ul>
	  </section>
	  <jsp:include page="../components/footer.jsp" />
	</div>
<script>
//한줄평 별 호버시 색변화
	const $stars = document.querySelectorAll('.shop-product .input-star>i');
	let inputScore = 0;
	
	$stars.forEach(($star, idx)=>{
	  $star.addEventListener('mouseenter', ()=>{
	      for(let i=0; i<=idx; i++){
	      $stars[i].classList.add('colorstar');
	      }
	  });
	  $star.addEventListener('mouseleave', ()=>{
	    for(let i=0; i<$stars.length; i++){
	      $stars[i].classList.remove('colorstar');
	    }
	  });
	
	  //해당 별점 - 클릭이벤트
	  $star.addEventListener('click', ()=>{
	    for(let i=0; i<=idx; i++){
	      $stars[i].style.color = 'rgb(100, 130, 173)';/******* 포인트 컬러에 따라 변경 필요********/
	    }
	    for(let k=$stars.length-1; k>idx; k--){
	      $stars[k].style.color = '#ddd';/******* 포인트 컬러에 따라 변경 필요********/
	    }
	    inputScore = idx+1;
	  });
	});
	
	//한줄평 등록 확인창
	const userid = '<%=userid%>';
	const frm = document.reviewFrm;

	const checkReview = () => {
		
	  //쿼리스트링으로 JS에서 클릭했던 별점 inputScore 값 보내줌
	  const url = '/shop/shop03?inputScore='+ inputScore + '&idKey=<%=userid%>';
	  window.open(url, "review", "width=400, height=300");
	  frm.action = url;
	  frm.target = "review";
	  frm.submit();
	};
	
	const reviewFn = () => {
		//유효성 검사
		if(frm.content.value == ''){
			alert('한줄평 내용을 입력해 주세요.');
			document.frm.content.focus();
			return;
		}
	
		if(userid === '0'){//비로그인 상태
			const loginAnswer = confirm('로그인해야 이용가능한 서비스입니다. 로그인 하시겠습니까?');

			if(loginAnswer){
				location.href = '/login/login01';
			}
		} else{
			checkReview();
		}
	}//reviewFn()
	
    
	//로그인 상태 확인 - 팝업창/shopProc이동
	makePopup = (save) => {
		
	    const popupWidth = 500;
	    const popupHeight = 350;
	    //팝업창 중앙 배치
	    let popupLeft = (window.screen.width / 2) - (popupWidth / 2);
	    let popupTop = (window.screen.height / 2) - (popupHeight / 2);
		
	    if (userid === '0') {
	        //비로그인 상태일 경우 팝업창 생성
	        const url = '/buy/buy02';
	        window.open(url, 'checkMember', 'width='+ popupHeight + ', height=' + popupHeight + ', left=' + popupLeft + ', top=' + popupTop);
	    }else{
	    	//장바구니/관심목록 구분
			if(save==='cart'){
				document.orderFrm.action = '/procs/shopProc?save=cart';
			}else if(save==='wish'){
				document.orderFrm.action = '/procs/shopProc?save=wish';
			}else{
				document.orderFrm.action = '/buy/buy01';
			}
		    document.orderFrm.submit();
		}
	}
	//바로 구매 클릭시
    const toBuy = (event) => {
	    event.preventDefault();
	    makePopup('buy');

	}
	
    //관심목록 클릭시
	const toWish = (event) => {
	    event.preventDefault();
	    makePopup('wish');

	}
	
	//장바구니 클릭시
	const toCart = (event) => {
		event.preventDefault();
		makePopup('cart');
	}

</script>
</body>

</html>