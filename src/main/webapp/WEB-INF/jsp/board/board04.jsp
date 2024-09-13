<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글쓰기 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
  <script defer src="${pageContext.request.contextPath}/js/board04.js"></script>
</head>
<body>
  <div id="wrap">
   
    <jsp:include page="../components/header.jsp" />

    <section>
      <h2><a href="board01.html">은하수 광장✨</a></h2>
      <form name="FrmPost" id="FrmPost" method="post" enctype="multipart/form-data">

        <div id="writeArea">
          <select name="selectCategory" id="selectCategory" required>
            <option value="" selected disabled hidden>카테고리 선택</option>
            <option value="소설/시/희곡">소설/시/희곡</option>
            <option value="인문학">인문학</option>
            <option value="에세이">에세이</option>
            <option value="자기계발">자기계발</option>
            <option value="경제경영">경제경영</option>
            <option value="과학">과학</option>
            <option value="사회과학">사회과학</option>
            <option value="역사">역사</option>
            <option value="종교/역학">종교/역학</option>
            <option value="만화">만화</option>
            <option value="기타">기타</option>
          </select>
          
          <div id="writeHead">
            <select name="selectTab" id="selectTab">
              <option value="일반" selected>일반</option>
              <option value="질문">질문</option>
              <option value="감상">감상</option>
              <option value="추천">추천</option>
            </select>
  
            <input type="text" name="postTit" placeholder="제목을 입력해 주세요.">
          </div>
  
          <div id="postEditor">
            
            <!-- <div id="writeSet">
              <button type="button" class="boldBtn">가</button>
              <button type="button" class="italicBtn">가</button>
              <button type="button" class="underLineBtn">가</button>
              <button type="button" class="throughBtn">가</button>
            </div> -->
           
            <textarea name="postCont"></textarea>
          </div>

        </div>
        
        <div id="uploadArea">
          <p>첨부파일</p>

          <div id="upload">
            <ul id="uploadName">
              <li>선택된 파일이 없습니다.</li>
            </ul>
            <label for="uploadFile">파일찾기</label>
            <input type="file" name="uploadFile" id="uploadFile" accept="image/*" multiple>
          </div>
        </div>

        <div id="postBtn">
          <button type="button" onclick="location.href='board01.html'">목록</button>
          <button type="button" onclick="writeChk()">작성</button>
        </div>
      </form>
    </section>

    <footer>
      푸터영역
    </footer>
  </div>

  <script>
    function writeChk() {
      const $frm = document.FrmPost;

      if($frm.selectCategory.value == "") {
        alert("카테고리를 선택해주세요.");
        $frm.selectCategory.focus();
        return;
      }

      if($frm.postTit.value == null || $frm.postTit.value == "") {
        alert("제목을 입력해주세요.");
        $frm.postTit.focus();
        return;
      }

      if($frm.postCont.value == null || $frm.postCont.value == "") {
        alert("내용을 입력해주세요.");
        $frm.postTit.focus();
        return;
      }
      // $frm.action = "#";
    }
  </script>
</body>
</html>