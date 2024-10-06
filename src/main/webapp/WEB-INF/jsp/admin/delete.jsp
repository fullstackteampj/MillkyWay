<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css?after" />
<script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
<script defer src="${pageContext.request.contextPath}/js/admin.js"></script>
</head>
<body>
	<div id="wrap">
		<header>
			<nav>
				<ul>
					<li><a href="/admin/insert">등록</a></li>
					<li><a href="/admin/update">수정</a></li>
					<li class="on"><a href="#">삭제</a></li>
				</ul>
			</nav>
			<div class="headMiddle">

	       		<h1>은하수책방</h1>
	
		        <div class="searchFrame">
		          <p class="searchId">
		            <span class="searchCat">통합검색</span> <i class="fa-solid fa-chevron-down"></i>
		          </p>
		          <form name="bookSearchFrm" autocomplete="off">
		          	<input type="text" name="bookSearch" />
		          	<button type="submit" style="display:none;">검색</button>
		          </form>
		          <span onclick="search()" class="search visible">검색</span>
		          <span class="close">닫기</span>
		        </div>
		        
		        
		        <ul class="searchedList">
		        </ul>
		
		        <ul class="searchList">
		          <li>통합검색</li>
		          <li>국내도서</li>
		          <li>해외도서</li>
		          <li>eBook</li>
		        </ul>
		
	       </div><!-- .headMiddle -->
		</header>
		
		<section class="admin">
			<form action="deleteBook" method="post" name="deleteBookFrm" id="deleteBookFrm" enctype="multipart/form-data">
			<p>삭제할 도서를 선택하세요</p> <!-- 태그 추가 -->
			<!-- 
				<div id="bookInfoWrap">
					<div class="topContainer">
					
						<div class="inputPhoto">
							<label for="photo">도서 표지사진</label><br />
							<input type="file" name="photo" id="photo" required />
							<input type="text" name="photoText"  />
						</div>
						
						<ul class="shortInput">
							<li>
								<label for="title">도서 제목</label>
								<input type="text" name="title" id="title" value="${not empty book ? book.title : ''}" required />
							</li>
							
							<li>
								<label for="author">도서 작가</label>
								<input type="text" name="author" id="author" value="${not empty book ? book.author : ''}" required />
							</li>
							
							<li>
								<label for="category">도서 카테고리</label>
								<c:set var="target" value="${target}" />
								<select name="category" id="category" required >
									<c:forEach var="category" items="${categories}">
										<option value="${category}"
											<c:if test="${not empty target and (book.category == category)}">selected</c:if> >
											${category}
										</option>
									</c:forEach>
								</select>
							</li>
							
							<li>
								<label for="genre">도서 장르</label>
								<input type="text" name="genre" id="genre" value="${not empty book ? book.genre : ''}" required />
							</li>
							
							<li>
								<label for="review">도서 리뷰</label>
								<input type="text" name="review" id="review" value="${not empty book ? book.review : ''}" placeholder="한줄로 간단히 작성" required />
							</li>
							
							<li>
								<label for="publish_date">도서 출판일</label>
								<input type="text" name="publish_date" id="publish_date" placeholder="2000-01-01 형식으로 작성" value="${not empty book ? book.publish_date : ''}" required />
							</li>
								
							<li>
								<label for="isbn">도서 isbn</label>
								<input type="text" name="isbn" id="isbn" placeholder="숫자만 작성" value="${not empty book ? book.isbn : ''}" required />
							</li>
							
							<li>
								<label for="stock_Quantity">도서 재고</label>
								<input type="text" name="stock_Quantity" id="stock_Quantity" placeholder="숫자만 작성" value="${not empty book ? book.stock_Quantity : ''}" required />
							</li>
							
							<li>
								<label for="price">도서 가격</label>
								<input type="text" name="price" id="price" placeholder="숫자만 작성" value="${not empty book ? book.price : ''}" required />
							</li>
							
							<li>
								<label for="pages">도서 페이지수</label>
								<input type="text" name="pages" id="pages" placeholder="숫자만 작성" value="${not empty book ? book.pages : ''}" required/>
							</li>
						</ul><!-- .shortInputr --
	
					</div><!-- .topContainer --
					
					<ul>
						<li>
							<label for="contents">도서 내용 요약글</label><br />
							<input type="text" name="contents" id="contents" value="${not empty book ? book.contents : ''}" required />
						</li>
						
						<li>
							<label for="authorIntro">저자 소개</label><br />
							<input type="text" name="authorIntro" id="authorIntro" value="${not empty book ? book.authorIntro : ''}" required />
						</li>
						
						<li>
							<label for="contentsTables">목차</label><br />
							<input type="text" name="contentsTables" id="contentsTables" value="${not empty book ? book.contentsTables : ''}" required />
						</li>
						
						<li>
							<label for="miniIntro">간단 소개글</label><br />
							<input type="text" name="miniIntro" id="miniIntro" value="${not empty book ? book.miniIntro : ''}" required />
						</li>
					</ul>
				</div> <!-- #bookInfoWrap --
				
				<button>도서 정보 삭제</button>
				 -->
			</form>
		</section>
		
	</div>
<script>
      const $search = document.querySelector('.searchFrame>.search');
      const $close = document.querySelector('.searchFrame>.close');
      const $searchedList = document.querySelector('.headMiddle>.searchedList');
      const $searchFrame = document.querySelector('.headMiddle>.searchFrame');

      // 출력된 데이터를 닫는 함수
      const close = ()=>{
        const $searchedListItems = document.querySelectorAll('.searchedList>li');
          for(let i=0;i<$searchedListItems.length;i++) {
            $searchedList.removeChild($searchedListItems[i]);
          }
          $searchFrame.classList.remove('searched');
          $close.classList.remove('visible');
          $search.classList.add('visible');
      };

      //전송받은 데이터를 기반으로 화면에 검색결과를 표시하는 엘리먼트를 생성 추가
      const addSearchedListItem = (data)=>{

        // 새로운 검색결과를 반영하기 전 초기화
        const $searchedListItems = document.querySelectorAll('.searchedList>li');
        for(let i=0;i<$searchedListItems.length;i++) {
          $searchedList.removeChild($searchedListItems[i]);
        }

        // 검색결과가 없을때
        if(data.length===0) {
          // alert('검색결과가 없습니다');
          $searchFrame.classList.remove('searched');

          const $li = document.createElement('li');
          const $p  = document.createElement('p');
          $p.textContent = "검색결과가 없습니다";
          $li.appendChild($p);
          $searchedList.appendChild($li);
          $close.classList.add('visible');
          $search.classList.remove('visible');

          // 검색결과 출력 후 검색결과를 닫는 이벤트리스너 추가
          $close.addEventListener('click',()=>{
            close();
          });
        }

        //새로운 검색결과를 화면에 출력(요소 생성 및 추가)
        for(let i=0;i<data.length;i++) {
          const bookid = data[i].bookid;
          const title = data[i].title;
          const author = data[i].author;
          const genre = data[i].genre;

          const $li = document.createElement('li');
          const $a  = document.createElement('a');
          const $image = document.createElement('img');
          const $title = document.createElement('p');
          const $author = document.createElement('p');
          const $genre = document.createElement('p');

          $a.setAttribute('href','javascript:bookInfoFn('+bookid+', "delete")');
          $image.setAttribute('src','/image?bookid=' + bookid);
          $image.setAttribute('alt', title);
          $title.textContent = title;
          $title.classList.add('title');
          $author.textContent = author;
          $author.classList.add('author');
          $genre.textContent = genre;
          $genre.classList.add('genre');

          $a.append($image,$title,$author,$genre);
          $li.appendChild($a);
          $searchedList.appendChild($li);

          $close.classList.add('visible');
          $search.classList.remove('visible');
        }

        // 새롭게 추가된 검색결과링크에 이벤트리스너 추가(클릭시 스타일 초기화)
        // 페이지 이동 후 뒤로가기 시에도 초기화된 화면 출력
        const $addedAs = document.querySelectorAll('.searchedList>li>a');
        $addedAs.forEach(($addedA)=>{
          $addedA.addEventListener('click',()=>{
            const $searchedListItems = document.querySelectorAll('.searchedList>li');
            for(let i=0;i<$searchedListItems.length;i++) {
              $searchedList.removeChild($searchedListItems[i]);
            }
            $searchFrame.classList.remove('searched');
            $close.classList.remove('visible');
            $search.classList.add('visible');
          });
        });

        // 검색결과 출력 후 검색결과를 닫는 이벤트리스너 추가
        $close.addEventListener('click',()=>{
          close();
        });

        // 검색결과 출력에 맞는 스타일 적용
        $searchFrame.classList.add('searched');
      };//addSearchedListItem = (data)=>{}


      //DB 웹서블릿 검색 API fetch요청을 통한 검색 정보 수신
	    async function search() {
	        const subject = document.querySelector("input[name=bookSearch]").value;
	        const searchCat = document.querySelector(".searchId>.searchCat").textContent;

	        if (subject == null || subject.trim() === "") {
	            alert("검색하실 내용을 입력해주세요.");
	            document.bookSearchFrm.bookSearch.focus();
	            return;
	        }else{
		        try {
		            // fetch를 사용하여 GET 요청을 서블릿으로 전송
		            const response = await fetch('/searchDB?subject=' + encodeURIComponent(subject) + '&searchCat=' + encodeURIComponent(searchCat));
		            
                // 작가이름, 책제목 기준으로 반환 된 검색결과 JSON형식으로 역직렬화
                const data = await response.json();
                /* 반환데이터 예시
                [
                    {
                        "bookid": 16,
                        "author": "어니스트 헤밍웨이",
                        "genre": "모험",
                        "title": "노인과 바다",
                        "score": 0,
                        "stock_Quantity": 0,
                        "price": 0,
                        "pages": 0
                    },
                    {
                        "bookid": 20,
                        "author": "제인 오스틴",
                        "genre": "로맨스",
                        "title": "오만과 편견",
                        "score": 0,
                        "stock_Quantity": 0,
                        "price": 0,
                        "pages": 0
                    },
                    {
                        "bookid": 26,
                        "author": "정미경",
                        "genre": "성장소설",
                        "title": "내 인생의 스프링캠프",
                        "score": 0,
                        "stock_Quantity": 0,
                        "price": 0,
                        "pages": 0
                    },
                    {
                        "bookid": 31,
                        "author": "김애란",
                        "genre": "가족소설",
                        "title": "두근두근 내 인생",
                        "score": 0,
                        "stock_Quantity": 0,
                        "price": 0,
                        "pages": 0
                    },
                    {
                        "bookid": 39,
                        "author": "오에 겐자부로",
                        "genre": "철학소설",
                        "title": "개인적인 체험",
                        "score": 0,
                        "stock_Quantity": 0,
                        "price": 0,
                        "pages": 0
                    }
                ]
                */

                addSearchedListItem(data);

		            $bookSearchFrm.reset(); //검색어초기화
		        } catch (error) {
		            console.error('API 작동에 실패하였습니다.:', error);
		        }
	        }//if(subject==null || subject=="")~else
	    }// async function search()

	    // form태그의 submit이벤트(엔터,서브밋버튼 클릭) 발생시 서브밋이벤트 발생방지
      // DB검색 API 함수 실행
	    const $bookSearchFrm = document.querySelector("form[name=bookSearchFrm]");
	    $bookSearchFrm.addEventListener('submit', (evt) => {
	        evt.preventDefault(); // 기본 제출 방지
	        search(); // 검색 함수 호출
	    });//$bookSearchFrm.addEventListener


      // 검색 카테고리 선택시 선택한 카테고리네임 반영
      const $searchItems = document.querySelectorAll(".searchList>li");
      const $searchCat = document.querySelector(".searchId>.searchCat");
      $searchItems.forEach(($searchItem)=>{
        $searchItem.addEventListener('click',()=>{
          $searchCat.textContent = $searchItem.textContent;
        });
      });//$searchItems.forEach(($searchItem)

</script>
</body>
</html>