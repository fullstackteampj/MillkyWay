<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cMgr" class="components.ComponentsMthod" />
<%
	String userId = (String) session.getAttribute("idKeyS");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>

<body>

 <header>
      <div class="headTop">
        <div class="frame">
          <ul class="topGnb">
            <li class="on"><a href="/">HOME</a></li>
            <li>
              <a href="/shop/shop01?category=국내도서">국내도서</a>
              <div class="underNav">국내도서underNav</div>
            </li>
            <li>
              <a href="/shop/shop01?category=해외도서">해외도서</a>
              <div class="underNav">해외도서underNav</div>
            </li>
            <li>
              <a href="/shop/shop01?category=eBook">eBook</a>
              <div class="underNav">eBookunderNav</div>
            </li>
            <li>
              <a href="/choice/choice01">추천도서</a>
              <div class="underNav">중고매장underNav</div>
            </li>
            <li>
              <a href="/board/board01">커뮤니티</a>
              <div class="underNav">커뮤니티underNav</div>
            </li>
          </ul>
          <ul class="userBar">
          	<%
          	if(userId==null){
          		%>
	            <li><a href="/login/login01">로그인</a></li>
	            <li><a href="/signup/signup01">회원가입</a></li>
	            <li>
	              <a href="/login/login01">
	                마이페이지
	                <span class="arrow"></span>
	              </a>
	              <ul class="myPageList">
	                <li><a href="/login/login01">구매목록</a></li>
	                <li><a href="/login/login01">취소/반품내역</a></li>
	                <li><a href="/login/login01">회원정보수정</a></li>
	                <li><a href="/login/login01">내가 쓴 글</a></li>
	                <li><a href="/login/login01">장바구니/관심목록</a></li>
	              </ul>
	            </li>
	            <li><a href="/shop/shop01">둘러보기</a></li>
          		<%
          	}else{
          		%>
	            <li style="width:200px;"><a href="/mypage/mypage01"><%=cMgr.getNickName(userId)%>님<br /> 환영합니다.</a></li>
	            <li><a href="/login/logout">회원가입</a></li>
	            <li>
	              <a href="/mypage/mypage01">
	                마이페이지
	                <span class="arrow"></span>
	              </a>
	              <ul class="myPageList">
	                <li><a href="/mypage/mypage01">구매목록</a></li>
	                <li><a href="/mypage/mypage02">취소/반품내역</a></li>
	                <li><a href="/mypage/mypage03">회원정보수정</a></li>
	                <li><a href="/mypage/mypage04">내가 쓴 글</a></li>
	                <li><a href="/mypage/mypage05">장바구니/관심목록</a></li>
	              </ul>
	            </li>
	            <li><a href="/login/logout">로그아웃</a></li>
          		<%
          	}
          	%>
          </ul>
        </div>
      </div>

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

        <img class="logo" src="${pageContext.request.contextPath}/images/Logo.jpg" alt="로고이미지" />
      </div>
    </header>
	
	
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

          $a.setAttribute('href','/shop/shop02?bookid=' + bookid);
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
	
	<script>
		// 스크롤 감지 헤더 노출
		const $header = document.querySelector('header');
		
		let lastScroll = document.documentElement.scrollTop || 0;
		
		window.addEventListener('scroll', ()=>{
		  let nowScroll = document.documentElement.scrollTop;
		  const scrollTop = Math.ceil(window.scrollY);
		
		  // 헤더 - 스크롤 시 세로스크롤만 상단 fixed
		  $header.style.top = scrollTop + 'px';
		
		  // 스크롤감지헤더
		  if(nowScroll > lastScroll) { // 스크롤 다운
		    // 헤더탑 숨김
		    $header.classList.add('scrolled');
		  } else { // 스크롤 업
		    // 헤더탑 보임
		    $header.classList.remove('scrolled');
		  }
		  
		  lastScroll = nowScroll;
		});
	</script>
	
</body>
</html>






















