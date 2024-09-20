<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
              <a href="/shop/shop01">중고매장</a>
              <div class="underNav">중고매장underNav</div>
            </li>
            <li>
              <a href="/board/board01">커뮤니티</a>
              <div class="underNav">커뮤니티underNav</div>
            </li>
          </ul>
          <ul class="userBar">
            <li><a href="/login/login01">로그인</a></li>
            <li><a href="/signup/signup01">회원가입</a></li>
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
            <li><a href="/login/login01">로그아웃</a></li>
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
          <span onclick="search()">검색</span>
          <ul class="searchedList"></ul>
        </div>

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
	    async function search() {
	        const subject = document.querySelector("input[name=bookSearch]").value;
	        const searchCat = document.querySelector(".searchId>.searchCat").textContent;
	        console.log(searchCat);
			
	        if (subject == null || subject.trim() === "") {
	            alert("검색하실 내용을 입력해주세요.");
	            document.bookSearchFrm.bookSearch.focus();
	            return;
	        }else{
		        try {
		            // fetch를 사용하여 GET 요청을 서블릿으로 전송
		            const response = await fetch('/searchDB?subject=' + encodeURIComponent(subject) + '&searchCat=' + encodeURIComponent(searchCat));
		            const data = await response.json();
		            console.log(data);
		            $bookSearchFrm.reset(); //검색어초기화
		        } catch (error) {
		            console.error('API 작동에 실패하였습니다.:', error);
		        }
	        }//if(subject==null || subject=="")~else
	    }// async function search()
	    
	    const $bookSearchFrm = document.querySelector("form[name=bookSearchFrm]");
	    $bookSearchFrm.addEventListener('submit', (evt) => {
	        evt.preventDefault(); // 기본 제출 방지
	        search(); // 검색 함수 호출
	    });

      const $searchItems = document.querySelectorAll(".searchList>li");
      const $searchCat = document.querySelector(".searchId>.searchCat");
      $searchItems.forEach(($searchItem)=>{
        $searchItem.addEventListener('click',()=>{
          $searchCat.textContent = $searchItem.textContent;
        });
      });
	    
	</script>

</body>
</html>






















