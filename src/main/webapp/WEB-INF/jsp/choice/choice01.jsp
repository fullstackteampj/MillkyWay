<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="beans.BookBean" %>
<jsp:useBean id="bMgr" class="bookInfo.BookInfoMgr" />
<% 
	request.setCharacterEncoding("UTF-8"); Vector<BookBean> vlist = null;


	//1~87 범위안의 무작위 수 4개 -> 추천할 bookid
	Random r = new Random();
	ArrayList<Integer> list = new ArrayList();
	for(int i=0; i<4; i++){ 
		int number=r.nextInt(87)+1; 
		if(!list.contains(number)){
			list.add(number); 
			}else{ 
				i--;
			} 	
		} 
	
	//무작위 수 4개 slist에 저장하고 id로 제목 끌어오기 
	ArrayList<String> slist = new ArrayList();

	for(int i=0; i<list.size(); i++){ 
		vlist=bMgr.getBook(list.get(i)); 
		BookBean bean = vlist.get(0); 
		String tit=bean.getTitle();
		slist.add(tit); 
	} 
%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?after" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/choice01.css?after" />
<title>추천 도서 페이지</title>
<script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
<script defer src="${pageContext.request.contextPath}/js/choice01.js"></script>
</head>

<body>
	<div id="wrap">
		<jsp:include page="../components/header.jsp" />
		<section class="choice">
			<h2>
				<i class="fa-solid fa-star-and-crescent"></i>
				추천 오로라
			</h2>
			<nav>
				<ul>
					<li class="on"><a href="#">
							<%=slist.get(0)%>
						</a></li>
					<li><a href="#">
							<%=slist.get(1)%>
						</a></li>
					<li><a href="#">
							<%=slist.get(2)%>
						</a></li>
					<li><a href="#">
							<%=slist.get(3)%>
						</a></li>
				</ul>
			</nav>
			<div class="container">
				<div class="frame">
					<a href="#"><i class="fa-solid fa-circle-chevron-left"></i></a>
					<a href="#"><i class="fa-solid fa-circle-chevron-right"></i></a>
					<div class="slide-recommend">
						<% 
							for(int i=0; i<list.size(); i++){ 
							int bookid=list.get(i); 
							String imgUrl="/image?bookid="+bookid; 
							vlist=bMgr.getBook(bookid); 
							BookBean bean=vlist.get(0); 
							String tit=bean.getTitle(); 
							String author=bean.getAuthor(); 
							String category=bean.getCategory();
							String genre=bean.getGenre(); 
							String mini=bean.getMiniIntro(); 
							String review=bean.getReview();
							String contents=bean.getContents(); 
						%>
						<article>
							<h3>
								<%=tit%>
							</h3>
							<p>지은이 - <%=author%> &dot; <%=category%> / <%=genre%>
							</p>
							<h4>"<%=mini%>"</h4>
							<img src="<%=imgUrl%>" alt="<%=tit%>">
							<div>
								<a href="/mypage/mypage05?bookid=<%=bookid%>"><i
										class="fa-solid fa-cart-shopping"></i></a>
								<a href="/shop/shop02?bookid=<%=bookid%>"><i
										class="fa-solid fa-magnifying-glass"></i></a>
								<a href="/mypage/mypage05?bookid=<%=bookid%>"><i
										class="fa-solid fa-heart-circle-plus"></i></a>
							</div>
							<h5>독자의 한 마디</h5>
							<p>
								<%=review%>!
							</p>
							<h5>책속에서</h5>
							<p>
								<%=contents%>
							</p>
						</article>
		
						<% }//for %>
								 
			       
					</div>
				</div><!--.frame-->
			</div><!--.container-->
		</section>

		<footer>
			<address>&copy;Designed by teamMillkyWay</address>
		</footer>
	</div>
</body>

</html>