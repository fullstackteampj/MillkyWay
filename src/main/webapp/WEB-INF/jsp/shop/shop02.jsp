<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.util.*" %>
<%@ page import="beans.BookBean" %>
<%@ page import="beans.ReviewBean" %>
<jsp:useBean id="bMgr" class="bookInfo.BookInfoMgr" />
<%
	request.setCharacterEncoding("UTF-8");
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
  <script defer src="${pageContext.request.contextPath}/js/shop02.js?ver100"></script>
</head>

<body>
	<div id="wrap">
	  <jsp:include page="../components/header.jsp" />
	  <section class="shop-product">
	    <form name="quickFrm" method="post">
	      <div>
	        <p><%=tit%></p>
	        <p>총 금액&nbsp;<span class="quick-total"></span></p>
	        <button formaction="/buy/buy01">바로구매</button>
	        <button formaction="/mypage/mypage05">장바구니</button>
	        <button formaction="/mypage/mypage05">관심목록</button>
	      </div>
	      <input type="hidden" name="bookid" value="<%=bookid%>" />
	    </form><!--form name="quick-order"-->
	
	    <h2>
	      <i class="fa-solid fa-chevron-left"></i>
	      <span><%=tit%></span>
	    </h2>
	    <p>지은이 : <span><%=author%></span></p>
	    <p><%=pdate%> 출판</p>
	    <div class="headbook">
	      <img src="<%=imgUrl%>" alt="<%=tit%>">
	      <form name="orderFrm" method="post">
	        <h3>가격 :&nbsp; <span><%=price%></span>원</h3>
	        <p>
	          포인트 : &nbsp;
	          <span class="point"></span>원 적립 (판매가의 10% 적립)
	        </p>
	        <p>배송료 : 2000원&nbsp;<span>(5만원 이상 무료배송)</span></p>
	        <p>
	          <%
	        		for(int c=0; c<score; c++){
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
	          <p>도서 가격&nbsp;
	            <span class="pretotal"></span>&nbsp;
	            <span></span>&nbsp;
	            <i class="fa-solid fa-arrow-right"></i>
	            &nbsp;&nbsp;총 금액&nbsp;
	            <span class="total-price"></span>
	          </p>
	        </div><!--order-qty-->
	        <button>매장 위치 확인</button>
	        <div class="btns-quickbuy">
	          <button formaction="/buy/buy01">바로구매</button>
	          <button formaction="/mypage/mypage05">장바구니</button>
	          <button formaction="/mypage/mypage05">관심목록</button>
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
	          <a href="#"><%=category%></a> > <a href="#"><%=genre%></a>
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
	        	//DB저장된 목차 문자열 -> 쉼표 and 띄어쓰기 별로 나누기
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
	          		for(int c=0; c<score; c++){
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
	      
	        	for(int i=0; i<rlist.size(); i++){
	        		ReviewBean rbean = rlist.get(i);
	        		int rScore = rbean.getScore();
	        		String rContent = rbean.getContent();
	        		String nickname = rbean.getNickname();
	        		%>
	        		<li>     
	        		<%
	        		for(int c=0; c<rScore; c++){
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
	const sidKey = '<%=session.getAttribute("idKey")%>';//문자열로 받음
	const frm = document.reviewFrm;

	console.log(sidKey);
	const checkReview = () => {
	  //const url = '/shop/shop03?inputScore='+ inputScore + ',idKey=' + sidKey; 로그인 상태 되면 다시 확인해보기
	  const url = '/shop/shop03?inputScore='+ inputScore + '&idKey=1'; //임의 아이디키 넣음
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
		
		checkReview();
		
		//세션 값에 따라 다르게 출력
		/*
		if(sidKey === 'null'){//비로그인 상태
			const loginAnswer = confirm('로그인해야 이용가능한 서비스입니다. 로그인 하시겠습니까?')
			if(loginAnswer){
				location.href = 'login/login01';
			}
		}else{
			checkReview();
			
		}*/
	}
</script>
</body>

</html>