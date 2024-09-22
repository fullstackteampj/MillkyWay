<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aside</title>
</head>
<body>

	<aside>
       <div class="searchAPIFrame">
         <form name="bookSearchAPIFrm" autocomplete="off">
         	<input type="text" name="bookSearchAPI" />
         	<button type="submit" style="display:none;">검색</button>
         </form>
         <span onclick="searchAPI()">검색</span>
       </div>
	</aside>
	
	<script>
	    async function searchAPI() {
	        const subject = document.querySelector("input[name=bookSearchAPI]").value;
			
	        if (subject == null || subject.trim() === "") {
	            alert("검색하실 내용을 입력해주세요.");
	            document.bookSearchAPIFrm.bookSearch.focus();
	            return;
	        }else{
		        try {
		            // fetch를 사용하여 GET 요청을 서블릿으로 전송
		            const response = await fetch('/searchAPI?subject=' + encodeURIComponent(subject));
		            const data = await response.json();
		            console.log(data);
		        } catch (error) {
		            console.error('API 작동에 실패하였습니다.:', error);
		        }
	        }//if(subject==null || subject=="")~else
	    }// async function search()
	    
	    const $bookSearchAPIFrm = document.querySelector("form[name=bookSearchAPIFrm]");
	    $bookSearchAPIFrm.addEventListener('submit', (evt) => {
	        evt.preventDefault(); // 기본 제출 방지
	        searchAPI(); // 검색 함수 호출
	        $bookSearchAPIFrm.reset(); //검색어초기화
	    });

	    
	</script>

</body>
</html>






















