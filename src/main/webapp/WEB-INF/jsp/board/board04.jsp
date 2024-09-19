<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="beans.MemberBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean loginBean = (MemberBean)session.getAttribute("mBean");
	boolean loginOk = (session != null && loginBean != null);
	int loginId = loginBean.getUserid();
	String loginNickname = loginBean.getNickname();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글쓰기 | 은하수책방</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset copy 2.css?after">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css?after">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <script defer src="${pageContext.request.contextPath}/js/header.js"></script>
  <script defer src="${pageContext.request.contextPath}/js/board04.js"></script>
  <script>
  
  	// 페이지 로드 시, 로그인이 안되어있으면 confirm (직접 주소창으로 접근 시 제한)
  	window.onload = function() {
        if(<%=!loginOk%>) {
           const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?")
           if(result) {
              location.href = "../login/login01";
           } else {
              location.href = "board01";
           }
        }
   };
  </script>
</head>
<body>
  <div id="wrap">
   
    <jsp:include page="../components/header.jsp" />

    <section>
      <h2><a href="board01">은하수 광장✨</a></h2>
      <form action="boardPost" method="post" name="FrmPost" id="FrmPost" enctype="multipart/form-data">
      	<input type="hidden" name="userid" value="<%=loginId%>">
      	<input type="hidden" name="nickname" value="<%=loginNickname%>">
		<input type="hidden" name="userip" value="<%=request.getRemoteAddr()%>">
        <div id="writeArea">
          <select name="postGenre" id="postGenre" required>
	          <option value="" selected disabled hidden>카테고리 선택</option>
	          
	        <!-- 카테고리목록 출력 -->
	        <%  ArrayList<String> cList = bMgr.getCategoryList();
	        	for(int i=1; i<cList.size(); i++) {%>
	           	<option value="<%=cList.get(i)%>"><%=cList.get(i)%></option>
	        <% } %>
          </select>
          
          <div id="writeHead">
            <select name="postTab" id="postTab">
            <!-- 탭테이블의 0,1,2 항목은 전체,인기,일반 고정 -->
              <option value="일반" selected>일반</option>
            <!-- 카테고리목록 출력 -->
	        <%  ArrayList<String> tList = bMgr.getTabList();
	        	for(int i=3; i<tList.size(); i++) {%>
	           	<option value="<%=tList.get(i)%>"><%=tList.get(i)%></option>
	        <% } %>
            </select>
  
            <input type="text" name="postTit" placeholder="제목을 입력해 주세요.">
          </div>
  
          <div id="postEditor">
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
            <input type="file" name="uploadFile" id="uploadFile" accept="image/*">
          </div>
        </div>

        <div id="postBtn">
          <button type="button" onclick="cancelChk()">목록</button>
          <button type="button" onclick="writeChk()">작성</button>
        </div>
      </form>
    </section>

    <footer>
      푸터영역
    </footer>
  </div>

  <script>
  
  	// 목록보기 버튼
  	function cancelChk() {
  		const result = confirm("작성 중인 내용은 삭제됩니다.\n글 작성을 취소하고 목록으로 돌아가시겠습니까?");
  		if(result) {
  			location.href = "board01";
  		}
  	}
  
  	// 글작성 버튼 - 유효성검사 후 submit
    function writeChk() {
      const $frm = document.FrmPost;

      if($frm.postGenre.value == "") {
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
      
      $frm.submit();
      
    }
  </script>
</body>
</html>