<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css?after" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop01.css?after" />
  <script src="https://kit.fontawesome.com/9698826605.js" crossorigin="anonymous"></script>
  <script defer src="${pageContext.request.contextPath}/js/shop01.js"></script>
  <title>상품 목록</title>
</head>

<body>
	<div id="wrap">
	  <jsp:include page="../components/header.jsp" />

	  <section class="shop-list">
	    <h2>도서 목록</h2>
	    <nav>
	      <ul class="book-broadCategory">
	        <li>
	          <a href="#">
	            <i class="fa-solid fa-plus"></i>
	            국내도서
	          </a>
	          <ul class="book-genreCategory">
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                건강/취미
	              </a>
	              <ol>
	                <li><a href="#">건강운동</a></li>
	                <li><a href="#">건강정보</a></li>
	                <li><a href="#">걷기/육상스포츠</a></li>
	                <li><a href="#">골프</a></li>
	                <li><a href="#">공예</a></li>
	                <li><a href="#">글씨 쓰기</a></li>
	                <li><a href="#">스티커북</a></li>
	                <li><a href="#">컬러링북</a></li>
	                <li><a href="#">구기</a></li>
	                <li><a href="#">낚시</a></li>
	                <li><a href="#">다이어트</a></li>
	                <li><a href="#">대체의학</a></li>
	                <li><a href="#">등산/캠핑</a></li>
	                <li><a href="#">무예/무술</a></li>
	                <li><a href="#">바둑/장기</a></li>
	                <li><a href="#">반려동물</a></li>
	                <li><a href="#">수영/수상스포츠</a></li>
	                <li><a href="#">스포츠/레저 기타</a></li>
	                <li><a href="#">원예</a></li>
	                <li><a href="#">재난/생존/서바이벌</a></li>
	                <li><a href="#">정신건강</a></li>
	                <li><a href="#">질병치료와 예방</a></li>
	                <li><a href="#">취미기타</a></li>
	                <li><a href="#">퍼즐/스도쿠/퀴즈</a></li>
	                <li><a href="#">한의학</a></li>
	                <li><a href="#">헬스/피트니스</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                경제경영
	              </a>
	              <ol>
	                <li><a href="#">경제학/경제일반</a></li>
	                <li><a href="#">기업 경영</a></li>
	                <li><a href="#">기업/경영자 스토리</a></li>
	                <li><a href="#">마케팅/세일즈</a></li>
	                <li><a href="#">트렌드/미래전망</a></li>
	                <li><a href="#">재테크/투자</a></li>
	                <li><a href="#">창업/취업/은퇴</a></li>
	                <li><a href="#">CEO/비즈니스맨을 위한 능력 계발</a></li>
	              </ol>
	            </li>
	            
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                공무원 수험서
	              </a>
	              <ol>
	                <li><a href="#">역량평가</a></li>
	                <li><a href="#">7/9급 공무원</a></li>
	                <li><a href="#">8급 공무원</a></li>
	                <li><a href="#">경찰공무원(승진)</a></li>
	                <li><a href="#">소방공무원(승진)</a></li>
	                <li><a href="#">군무원/부사관</a></li>
	                <li><a href="#">기술직</a></li>
	                <li><a href="#">기능직</a></li>
	                <li><a href="#">기능직 일반직 전환</a></li>
	                <li><a href="#">공무원 면접/수기</a></li>
	                <li><a href="#">교원임용시험</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                과학
	              </a>
	              <ol>
	                <li><a href="#">기초과학/교양과학</a></li>
	                <li><a href="#">과학의 이해</a></li>
	                <li><a href="#">과학사회학(STS)</a></li>
	                <li><a href="#">과학자의 생애</a></li>
	                <li><a href="#">뇌과학</a></li>
	                <li><a href="#">생명과학</a></li>
	                <li><a href="#">인체의 이해</a></li>
	                <li><a href="#">의학</a></li>
	                <li><a href="#">법의학</a></li>
	                <li><a href="#">동물과 식물</a></li>
	                <li><a href="#">물리학</a></li>
	                <li><a href="#">천문학</a></li>
	                <li><a href="#">지구과학</a></li>
	                <li><a href="#">수학</a></li>
	                <li><a href="#">화학</a></li>
	                <li><a href="#">공학</a></li>
	                <li><a href="#">세계의 불가사의</a></li>
	                <li><a href="#">발명/발견</a></li>
	                <li><a href="#">농업</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                달력/기타
	              </a>
	              <ol>
	                <li><a href="#">2025년 가계부</a></li>
	                <li><a href="#">2025년 다이어리</a></li>
	                <li><a href="#">2025년 달력</a></li>
	                <li><a href="#">2024년 가계부</a></li><!--jsp 현재 연도 표현식-->
	                <li><a href="#">2024년 다이어리</a></li>
	                <li><a href="#">2024년 달력</a></li>
	                <li><a href="#">만년 가계부</a></li>
	                <li><a href="#">만년 다이어리</a></li>
	                <li><a href="#">만년 달력</a></li>
	                <li><a href="#">영어로 쓰인 한국서적</a></li>
	                <li><a href="#">오디오북</a></li>
	                <li><a href="#">출판사 제작 상품</a></li>
	                <li><a href="#">큰글자책</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                대학교재
	            </a>
	              <ol>
	                <li><a href="#">경상계열</a></li>
	                <li><a href="#">공학계열</a></li>
	                <li><a href="#">농축산계열</a></li>
	                <li><a href="#">법학계열</a></li>
	                <li><a href="#">사범계열</a></li>
	                <li><a href="#">사회과학계열</a></li>
	                <li><a href="#">생활환경계열</a></li>
	                <li><a href="#">어문학계열</a></li>
	                <li><a href="#">연감</a></li>
	                <li><a href="#">예체능계열</a></li>
	                <li><a href="#">의약학간호계열</a></li>
	                <li><a href="#">인문계열</a></li>
	                <li><a href="#">자연과학계열</a></li>
	                <li><a href="#">전문사전</a></li>
	                <li><a href="#">한국방송통신대학교</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                만화
	              </a>
	              <ol>
	                <li><a href="#">캐릭터상품</a></li>
	                <li><a href="#">교양만화</a></li>
	                <li><a href="#">그래픽노블</a></li>
	                <li><a href="#">대하/서사만화</a></li>
	                <li><a href="#">만화그리기와 읽기</a></li>
	                <li><a href="#">본격장르만화</a></li>
	                <li><a href="#">성인/성애만화</a></li>
	                <li><a href="#">소년만화</a></li>
	                <li><a href="#">순정만화</a></li>
	                <li><a href="#">스포츠만화</a></li>
	                <li><a href="#">동물만화</a></li>
	                <li><a href="#">유럽/서구만화</a></li>
	                <li><a href="#">요리만화</a></li>
	                <li><a href="#">직장인만화</a></li>
	                <li><a href="#">가족만화</a></li>
	                <li><a href="#">논픽션/휴먼만화</a></li>
	                <li><a href="#">인디만화</a></li>
	                <li><a href="#">인터넷 연재 만화</a></li>
	                <li><a href="#">코믹/명랑만화</a></li>
	                <li><a href="#">19금</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                사회과학
	              </a>
	              <ol>
	                <li><a href="#">비평/칼럼</a></li>
	                <li><a href="#">사회문제</a></li>
	                <li><a href="#">환경/생태문제</a></li>
	                <li><a href="#">교육학</a></li>
	                <li><a href="#">사회운동</a></li>
	                <li><a href="#">사회사상/사회사상사</a></li>
	                <li><a href="#">미래학</a></li>
	                <li><a href="#">지리학/지정학</a></li>
	                <li><a href="#">정치학/외교학/행정학</a></li>
	                <li><a href="#">한국정치사정/정치사</a></li>
	                <li><a href="#">사회학</a></li>
	                <li><a href="#">여성학/젠더</a></li>
	                <li><a href="#">언론/미디어</a></li>
	                <li><a href="#">법과 생활</a></li>
	                <li><a href="#">통일/북한관계</a></li>
	                <li><a href="#">국방/군사학</a></li>
	                <li><a href="#">계간지/무크</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                소설/시/희곡
	              </a>
	              <ol>
	                <li><a href="#">한국소설</a></li>
	                <li><a href="#">일본소설</a></li>
	                <li><a href="#">영미소설</a></li>
	                <li><a href="#">스페인/중남미소설</a></li>
	                <li><a href="#">프랑스소설</a></li>
	                <li><a href="#">독일소설</a></li>
	                <li><a href="#">중국소설</a></li>
	                <li><a href="#">러시아소설</a></li>
	                <li><a href="#">세계의 소설</a></li>
	                <li><a href="#">추리/미스터리소설</a></li>
	                <li><a href="#">라이트 노벨</a></li>
	                <li><a href="#">판타지/환상문학</a></li>
	                <li><a href="#">역사소설</a></li>
	                <li><a href="#">과학소설(SF)</a></li>
	                <li><a href="#">호러.공포소설</a></li>
	                <li><a href="#">무협소설</a></li>
	                <li><a href="#">액션/스릴러소설</a></li>
	                <li><a href="#">로맨스소설</a></li>
	                <li><a href="#">시</a></li>
	                <li><a href="#">신춘문예작품집</a></li>
	                <li><a href="#">우리나라 옛글</a></li>
	                <li><a href="#">문학의 이해</a></li>
	                <li><a href="#">희곡</a></li>
	                <li><a href="#">문학 잡지</a></li>
	                <li><a href="#">여성문학</a></li>
	                <li><a href="#">테마문학</a></li>
	                <li><a href="#">세계의 문학</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                수험서/자격증
	              </a>
	              <ol>
	                <li><a href="#">국가기술자격</a></li>
	                <li><a href="#">국가전문자격</a></li>
	                <li><a href="#">귀화시험</a></li>
	                <li><a href="#">민간자격</a></li>
	                <li><a href="#">공무원 수험서</a></li>
	                <li><a href="#">한국사능력검정시험</a></li>
	                <li><a href="#">취업/상식/적성</a></li>
	                <li><a href="#">공인중개사/주택관리사</a></li>
	                <li><a href="#">운전면허</a></li>
	                <li><a href="#">한자시험</a></li>
	                <li><a href="#">한국어능력시험</a></li>
	                <li><a href="#">컴퓨터 활용능력</a></li>
	                <li><a href="#">편입/검정고시/독학사</a></li>
	                <li><a href="#">매경 TEST</a></li>
	                <li><a href="#">TESAT</a></li>
	                <li><a href="#">LEET:법학적성시험</a></li>
	                <li><a href="#">MEET&DEEP&PEET</a></li>
	                <li><a href="#">인문/사회/법(고등고시)</a></li>
	                <li><a href="#">PSAT(행정고시)</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                어린이
	              </a>
	              <ol>
	                <li><a href="#">초등 한국사</a></li>
	                <li><a href="#">초등1~2학년</a></li>
	                <li><a href="#">초등3~4학년</a></li>
	                <li><a href="#">초등5~6학년</a></li>
	                <li><a href="#">초등 전학년</a></li>
	                <li><a href="#">교과서 수록도서</a></li>
	                <li><a href="#">동화/명작/고전</a></li>
	                <li><a href="#">아동 문학론</a></li>
	                <li><a href="#">과학/수학/컴퓨터</a></li>
	                <li><a href="#">사회/역사/철학</a></li>
	                <li><a href="#">문화/예술/인물</a></li>
	                <li><a href="#">어린이 영어</a></li>
	                <li><a href="#">어린이 한자</a></li>
	                <li><a href="#">어린이 중국어</a></li>
	                <li><a href="#">책읽기/글쓰기</a></li>
	                <li><a href="#">어린이 사전/도감</a></li>
	                <li><a href="#">TV/만화/영화</a></li>
	                <li><a href="#">게임 만화/캐릭터도감</a></li>
	                <li><a href="#">학습만화</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                에세이
	              </a>
	              <ol>
	                <li><a href="#">한국에세이</a></li>
	                <li><a href="#">외국에세이</a></li>
	                <li><a href="#">동물에세이</a></li>
	                <li><a href="#">명상에세이</a></li>
	                <li><a href="#">심리치유 에세이</a></li>
	                <li><a href="#">사진/그림 에세이</a></li>
	                <li><a href="#">음식에세이</a></li>
	                <li><a href="#">여행에세이</a></li>
	                <li><a href="#">독서에세이</a></li>
	                <li><a href="#">예술에세이</a></li>
	                <li><a href="#">종교에세이</a></li>
	                <li><a href="#">사랑/연애 에세이</a></li>
	                <li><a href="#">노년을 위한 에세이</a></li>
	                <li><a href="#">자연에세이</a></li>
	                <li><a href="#">명언/잠언록</a></li>
	                <li><a href="#">일기/편지</a></li>
	                <li><a href="#">유머/풍자/우화</a></li>
	                <li><a href="#">포켓에세이</a></li>
	                <li><a href="#">작은 이야기 모음</a></li>
	                <li><a href="#">명사에세이</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                여행
	              </a>
	              <ol>
	                <li><a href="#">국내 여행에세이</a></li>
	                <li><a href="#">서울/수도권 여행가이드</a></li>
	                <li><a href="#">제주도 여행가이드</a></li>
	                <li><a href="#">국내 여행가이드</a></li>
	                <li><a href="#">캠핑여행</a></li>
	                <li><a href="#">미국여행</a></li>
	                <li><a href="#">캐나다여행</a></li>
	                <li><a href="#">중남미여행</a></li>
	                <li><a href="#">유럽여행</a></li>
	                <li><a href="#">북유럽여행</a></li>
	                <li><a href="#">동유럽여행</a></li>
	                <li><a href="#">프랑스여행</a></li>
	                <li><a href="#">영국여행</a></li>
	                <li><a href="#">스페인여행</a></li>
	                <li><a href="#">독일여행</a></li>
	                <li><a href="#">이탈리아여행</a></li>
	                <li><a href="#">터키여행</a></li>
	                <li><a href="#">중동여행</a></li>
	                <li><a href="#">아프리카여행</a></li>
	                <li><a href="#">일본여행</a></li>
	                <li><a href="#">중국여행</a></li>
	                <li><a href="#">홍콩/대만/마카오여행</a></li>
	                <li><a href="#">동남아시아여행</a></li>
	                <li><a href="#">호주/뉴질랜드여행</a></li>
	                <li><a href="#">인도/티베트/네팔여행</a></li>
	                <li><a href="#">괌/사이판/하와이여행</a></li>
	                <li><a href="#">발리/몰디브여행</a></li>
	                <li><a href="#">세계일주여행</a></li>
	                <li><a href="#">테마여행</a></li>
	                <li><a href="#">기타지역여행</a></li>
	                <li><a href="#">유학/해외연수/이민</a></li>
	                <li><a href="#">워킹홀리데이</a></li>
	                <li><a href="#">지도</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                역사
	              </a>
	              <ol>
	                <li><a href="#">동양사일반</a></li>
	                <li><a href="#">북한사</a></li>
	                <li><a href="#">역사학</a></li>
	                <li><a href="#">한국사 일반</a></li>
	                <li><a href="#">한국고대~고려시대</a></li>
	                <li><a href="#">조선사</a></li>
	                <li><a href="#">한국근현대사</a></li>
	                <li><a href="#">중국사</a></li>
	                <li><a href="#">일본사</a></li>
	                <li><a href="#">아시아사</a></li>
	                <li><a href="#">서양사</a></li>
	                <li><a href="#">유럽사</a></li>
	                <li><a href="#">아메리카사</a></li>
	                <li><a href="#">아프리카/오세아니아사</a></li>
	                <li><a href="#">이슬람/중동/이스라엘</a></li>
	                <li><a href="#">세계사 일반</a></li>
	                <li><a href="#">전쟁/분쟁사</a></li>
	                <li><a href="#">테마로 보는 역사</a></li>
	                <li><a href="#">고고학</a></li>
	                <li><a href="#">문화/역사기행</a></li>
	                <li><a href="#">학회/무크/계간지</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                예술/대중문화
	              </a>
	              <ol>
	                <li><a href="#">컬러링북</a></li>
	                <li><a href="#">예술/대중문화의 이해</a></li>
	                <li><a href="#">미술</a></li>
	                <li><a href="#">음악</a></li>
	                <li><a href="#">영화/드라마</a></li>
	                <li><a href="#">사진</a></li>
	                <li><a href="#">건축</a></li>
	                <li><a href="#">뮤지컬/오페라</a></li>
	                <li><a href="#">예술경영/공연기획</a></li>
	                <li><a href="#">디자인/공예</a></li>
	                <li><a href="#">무용</a></li>
	                <li><a href="#">연극</a></li>
	                <li><a href="#">TV/라디오</a></li>
	                <li><a href="#">미술/음악/예술치료</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                외국어
	              </a>
	              <ol>
	                <li><a href="#">어학사전</a></li>
	                <li><a href="#">토익</a></li>
	                <li><a href="#">텝스</a></li>
	                <li><a href="#">토플</a></li>
	                <li><a href="#">영어회화</a></li>
	                <li><a href="#">영어시험대비</a></li>
	                <li><a href="#">영문법</a></li>
	                <li><a href="#">영어독해</a></li>
	                <li><a href="#">영어학습법</a></li>
	                <li><a href="#">영어어휘</a></li>
	                <li><a href="#">영작문</a></li>
	                <li><a href="#">영어듣기/말하기</a></li>
	                <li><a href="#">OPlc/인터뷰영어</a></li>
	                <li><a href="#">영어사전</a></li>
	                <li><a href="#">일본어</a></li>
	                <li><a href="#">중국어</a></li>
	                <li><a href="#">한자</a></li>
	                <li><a href="#">독일어</a></li>
	                <li><a href="#">러시아어</a></li>
	                <li><a href="#">스페인어</a></li>
	                <li><a href="#">이탈리아어</a></li>
	                <li><a href="#">프랑스어</a></li>
	                <li><a href="#">기타 서양어</a></li>
	                <li><a href="#">기타 동양어</a></li>
	                <li><a href="#">외국인을 위한 한국어</a></li>
	                <li><a href="#">통역/번역</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                요리/살림
	              </a>
	              <ol>
	                <li><a href="#">가계부</a></li>
	                <li><a href="#">건강요리</a></li>
	                <li><a href="#">결혼/가족</a></li>
	                <li><a href="#">나라별 요리</a></li>
	                <li><a href="#">다이어트 요리</a></li>
	                <li><a href="#">도시락</a></li>
	                <li><a href="#">디저트</a></li>
	                <li><a href="#">뜨개질/바느질/DIY</a></li>
	                <li><a href="#">사찰요리</a></li>
	                <li><a href="#">살림/정리수납</a></li>
	                <li><a href="#">샐러드/샌드위치</a></li>
	                <li><a href="#">생활요리</a></li>
	                <li><a href="#">술/음료/차</a></li>
	                <li><a href="#">원예/조경/텃밭</a></li>
	                <li><a href="#">음식 이야기</a></li>
	                <li><a href="#">이유식</a></li>
	                <li><a href="#">전문가/연예인/블로거 요리</a></li>
	                <li><a href="#">제과제빵</a></li>
	                <li><a href="#">집/인테리어</a></li>
	                <li><a href="#">패션/뷰티</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                유아
	              </a>
	              <ol>
	                <li><a href="#">주제별 책읽기</a></li>
	                <li><a href="#">0~3세</a></li>
	                <li><a href="#">4~7세</a></li>
	                <li><a href="#">100세 그림책</a></li>
	                <li><a href="#">그림책</a></li>
	                <li><a href="#">놀이책</a></li>
	                <li><a href="#">유아 교양/학습</a></li>
	                <li><a href="#">애니메이션/캐릭터</a></li>
	                <li><a href="#">유아 워크북</a></li>
	                <li><a href="#">유아 세트</a></li>
	                <li><a href="#">예비초등</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                인문학
	              </a>
	              <ol>
	                <li><a href="#">사상가/인문학자</a></li>
	                <li><a href="#">교양 인문학</a></li>
	                <li><a href="#">인문 에세이</a></li>
	                <li><a href="#">인문 비평</a></li>
	                <li><a href="#">인문학 전문사전</a></li>
	                <li><a href="#">철학 일반</a></li>
	                <li><a href="#">서양철학</a></li>
	                <li><a href="#">동양철학</a></li>
	                <li><a href="#">심리학/정신분석학</a></li>
	                <li><a href="#">신화/종교학</a></li>
	                <li><a href="#">책읽기/글쓰기</a></li>
	                <li><a href="#">서지/출판</a></li>
	                <li><a href="#">기호학/언어학</a></li>
	                <li><a href="#">논리와 비판적 사고</a></li>
	                <li><a href="#">인류학/고고학</a></li>
	                <li><a href="#">문화/문화이론</a></li>
	                <li><a href="#">학회/무크/계간지</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                자기계발
	              </a>
	              <ol>
	                <li><a href="#">성공</a></li>
	                <li><a href="#">리더십</a></li>
	                <li><a href="#">행복론</a></li>
	                <li><a href="#">인간관계</a></li>
	                <li><a href="#">힐링</a></li>
	                <li><a href="#">정리/심플라이프</a></li>
	                <li><a href="#">협상/설득/화술</a></li>
	                <li><a href="#">프레젠테이션/회의</a></li>
	                <li><a href="#">기획/보고</a></li>
	                <li><a href="#">시간관리/정보관리</a></li>
	                <li><a href="#">창의적사고/두뇌계발</a></li>
	                <li><a href="#">취업/진로/유망직업</a></li>
	                <li><a href="#">20대의 자기계발</a></li>
	                <li><a href="#">여성의 자기계발</a></li>
	                <li><a href="#">중년의 자기계발</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                잡지
	              </a>
	              <ol>
	                <li><a href="#">건강/의학</a></li>
	                <li><a href="#">경제/경영</a></li>
	                <li><a href="#">과학/기술</a></li>
	                <li><a href="#">교양/문예/인문</a></li>
	                <li><a href="#">교육/취업</a></li>
	                <li><a href="#">대중문화/예술</a></li>
	                <li><a href="#">독립/인디잡지</a></li>
	                <li><a href="#">리빙/가정/주택</a></li>
	                <li><a href="#">만화/애니메이션</a></li>
	                <li><a href="#">수험/어학교재</a></li>
	                <li><a href="#">시사지</a></li>
	                <li><a href="#">어린이/청소년</a></li>
	                <li><a href="#">여성/남성/패션</a></li>
	                <li><a href="#">여행/스포츠/취미</a></li>
	                <li><a href="#">요리/제과제빵</a></li>
	                <li><a href="#">육아</a></li>
	                <li><a href="#">정기구독</a></li>
	                <li><a href="#">종교</a></li>
	                <li><a href="#">주간지</a></li>
	                <li><a href="#">컴퓨터/인터넷/게임</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                장르소설
	              </a>
	              <ol>
	                <li><a href="#">추리/미스터리소설</a></li>
	                <li><a href="#">라이트 노벨</a></li>
	                <li><a href="#">판타지/환상문학</a></li>
	                <li><a href="#">과학소설(SF)</a></li>
	                <li><a href="#">호러.공포소설</a></li>
	                <li><a href="#">무협소설</a></li>
	                <li><a href="#">액션/스릴러소설</a></li>
	                <li><a href="#">로맨스소설</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                전집/중고전집
	              </a>
	              <ol>
	                <li><a href="#">_0-3세</a></li>
	                <li><a href="#">_4-7세</a></li>
	                <li><a href="#">_단행본 전집</a></li>
	                <li><a href="#">_초등(1-3)저학년</a></li>
	                <li><a href="#">_초등(4-6)고학년</a></li>
	                <li><a href="#">_출판사별보기</a></li>
	                <li><a href="#">_토이북/교구</a></li>
	                <li><a href="#">문학/논술/고전</a></li>
	                <li><a href="#">영어/학습</a></li>
	                <li><a href="#">인물/역사/사회</a></li>
	                <li><a href="#">자연/과학/수학</a></li>
	                <li><a href="#">전래/명작동화</a></li>
	                <li><a href="#">창작동화</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                종교/역학
	              </a>
	              <ol>
	                <li><a href="#">기독교(개신교)</a></li>
	                <li><a href="#">가톨릭</a></li>
	                <li><a href="#">불교</a></li>
	                <li><a href="#">세계의 종교</a></li>
	                <li><a href="#">역학</a></li>
	                <li><a href="#">명상/선</a></li>
	                <li><a href="#">종교일반</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                좋은부모
	              </a>
	              <ol>
	                <li><a href="#">부모교육</a></li>
	                <li><a href="#">임신/출산</a></li>
	                <li><a href="#">태교</a></li>
	                <li><a href="#">영유아 육아</a></li>
	                <li><a href="#">초등 자녀</a></li>
	                <li><a href="#">육아</a></li>
	                <li><a href="#">건강/환경</a></li>
	                <li><a href="#">교육/학습</a></li>
	                <li><a href="#">특수교육</a></li>
	                <li><a href="#">청소년/사춘기/성교육</a></li>
	                <li><a href="#">육아/교육 에세이</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                청소년
	              </a>
	              <ol>
	                <li><a href="#">청소년 경제</a></li>
	                <li><a href="#">중등교육과정</a></li>
	                <li><a href="#">고등교육과정</a></li>
	                <li><a href="#">학습법</a></li>
	                <li><a href="#">논술참고도서</a></li>
	                <li><a href="#">수능시험성공수기</a></li>
	                <li><a href="#">청소년 문학</a></li>
	                <li><a href="#">청소년 역사</a></li>
	                <li><a href="#">청소년의 진로선택</a></li>
	                <li><a href="#">청소년과 성(性)</a></li>
	                <li><a href="#">청소년 고전</a></li>
	                <li><a href="#">청소년 수학/과학</a></li>
	                <li><a href="#">청소년 영어</a></li>
	                <li><a href="#">청소년 문화/예술</a></li>
	                <li><a href="#">청소년 자기계발</a></li>
	                <li><a href="#">청소년 철학</a></li>
	                <li><a href="#">청소년 인문/사회</a></li>
	                <li><a href="#">청소년 인물</a></li>
	                <li><a href="#">청소년의 사회생활</a></li>
	                <li><a href="#">청소년이 쓴 책</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                컴퓨터/모바일
	              </a>
	              <ol>
	                <li><a href="#">그래픽/멀티미디어</a></li>
	                <li><a href="#">모바일 프로그래밍</a></li>
	                <li><a href="#">스마트폰/태블릿/SNS</a></li>
	                <li><a href="#">오피스(엑셀/파워포인트)</a></li>
	                <li><a href="#">웹디자인/홈페이지</a></li>
	                <li><a href="#">인공지능</a></li>
	                <li><a href="#">초중고 소프트웨어 교육/코딩</a></li>
	                <li><a href="#">컴퓨터 공학</a></li>
	                <li><a href="#">프로그래밍 개발/방법론</a></li>
	                <li><a href="#">프로그래밍 언어</a></li>
	                <li><a href="#">활용능력</a></li>
	                <li><a href="#">e비즈니스/창업</a></li>
	                <li><a href="#">OS/Networking</a></li>
	                <li><a href="#">PC/게임/디지털 카메라</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                참고서
	              </a>
	              <ol>
	                <li><a href="#">초등학교참고서</a>
	                  <ul>
	                    <li><a href="#">미취학 학습</a></li>
	                    <li><a href="#">EBS 초등</a></li>
	                    <li><a href="#">1학년</a></li>
	                    <li><a href="#">2학년</a></li>
	                    <li><a href="#">3학년</a></li>
	                    <li><a href="#">4학년</a></li>
	                    <li><a href="#">5학년</a></li>
	                    <li><a href="#">6학년</a></li>
	                    <li><a href="#">예비중학</a></li>
	                    <li><a href="#">전과/자습서</a></li>
	                    <li><a href="#">학습월간지(초등)</a></li>
	                    <li><a href="#">영재교육원대비</a></li>
	                    <li><a href="#">경시/올림피아드</a></li>
	                    <li><a href="#">서술형.논술형</a></li>
	                    <li><a href="#">단계별 연산/계산</a></li>
	                    <li><a href="#">국어독해/어휘/논술</a></li>
	                    <li><a href="#">초등한국사</a></li>
	                    <li><a href="#">초등한자/중국어</a></li>
	                    <li><a href="#">초등영어전문교재</a></li>
	                    <li><a href="#">학습교구</a></li>
	                    <li><a href="#">초등학교 출판사별</a></li>
	                  </ul>
	                
	                </li>
	                <li>
	                  <a href="#">
	                    <i class="fa-solid fa-plus"></i>
	                    중학교참고서
	                  </a>
	                    <ul>
	                      <li><a href="#">EBS 중등</a></li>
	                      <li><a href="#">중1-문제집</a></li>
	                      <li><a href="#">중2-문제집</a></li>
	                      <li><a href="#">중3-문제집</a></li>
	                      <li><a href="#">중1-자습서</a></li>
	                      <li><a href="#">중2-자습서</a></li>
	                      <li><a href="#">중3-자습서</a></li>
	                      <li><a href="#">중학국어독해</a></li>
	                      <li><a href="#">중학연산/도형</a></li>
	                      <li><a href="#">예비고등</a></li>
	                      <li><a href="#">특목고대비</a></li>
	                      <li><a href="#">중학경시대회</a></li>
	                      <li><a href="#">논술/글쓰기(중등)</a></li>
	                      <li><a href="#">중학영어전문교재</a></li>
	                      <li><a href="#">학습/기타</a></li>
	                      <li><a href="#">중학교 출판사별</a></li>
	                    </ul>
	                </li>
	                <li>
	                  <a href="#">
	                    <i class="fa-solid fa-plus"></i>
	                    고등학교참고서
	                  </a>
	                    <ul>
	                      <li><a href="#">EBS 고등</a></li>
	                      <li><a href="#">고등-문제집</a></li>
	                      <li><a href="#">고등-자습서</a></li>
	                      <li><a href="#">수능대비</a></li>
	                      <li><a href="#">수능모의고사/기출</a></li>
	                      <li><a href="#">논술/면접/수시</a></li>
	                      <li><a href="#">고등영어전문교재</a></li>
	                      <li><a href="#">학습자료</a></li>
	                      <li><a href="#">고등학교 출판사별</a></li>
	                    </ul>
	                </li>
	              </ol>
	            </li>
	
	          </ul><!-- 국내도서 분야 ul-->
	        </li><!--국내도서 li-->
	
	        <li>
	          <a href="#">
	            <i class="fa-solid fa-plus"></i>
	            외국도서
	          </a>
	
	          <ul class="book-genreCategory">
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                영미도서
	              </a>
	              <ol>
	                <li><a href="#">ELT/어학/사전</a></li>
	                <li><a href="#">가정/원예/인테리어</a></li>
	                <li><a href="#">건강/스포츠</a></li>
	                <li><a href="#">경제경영</a></li>
	                <li><a href="#">공예/취미/수집</a></li>
	                <li><a href="#">만화</a></li>
	                <li><a href="#">소설/시/희곡</a></li>
	                <li><a href="#">여행</a></li>
	                <li><a href="#">역사</a></li>
	                <li><a href="#">요리</a></li>
	                <li><a href="#">인문/사회</a></li>
	                <li><a href="#">종교/명상/점술</a></li>
	                <li><a href="#">청소년</a></li>
	                <li><a href="#">해외잡지</a></li>
	              </ol>
	            </li>
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                일본도서
	              </a>
	              <ol>
	                <li><a href="#">경제/경영</a></li>
	                <li><a href="#">라이트노벨</a></li>
	                <li><a href="#">애니메이션 굿즈</a></li>
	                <li><a href="#">어린이</a></li>
	                <li><a href="#">예술/건축/디자인</a></li>
	                <li><a href="#">외국어학습/교육</a></li>
	                <li><a href="#">이학/공학/컴퓨터</a></li>
	                <li><a href="#">인문/사회/논픽션</a></li>
	                <li><a href="#">지브리 작품전</a></li>
	                <li><a href="#">캘린더</a></li>
	                <li><a href="#">문학</a></li>
	                <li><a href="#">잡지</a></li>
	                <li><a href="#">코믹/게임</a></li>
	                <li><a href="#">실용/취미/생활</a></li>
	                <li><a href="#">엔터테인먼트</a></li>
	                <li><a href="#">문고/신서</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                어린이
	              </a>
	              <ol>
	                <li><a href="#">그림책</a></li>
	                <li><a href="#">동화책</a></li>
	                <li><a href="#">리더스</a></li>
	                <li><a href="#">영어학습</a></li>
	                <li><a href="#">챕터북</a></li>
	                <li><a href="#">코스북</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                중국도서
	              </a>
	              <ol>
	                <li><a href="#">소설</a></li>
	                <li><a href="#">중국어 교재</a></li>
	              </ol>
	            </li>
	
	            <li>
	              <a href="#">
	                <i class="fa-solid fa-plus"></i>
	                기타언어권
	              </a>
	              <ol>
	                <li><a href="#">독일 도서</a></li>
	                <li><a href="#">베트남 도서</a></li>
	                <li><a href="#">스페인 도서</a></li>
	                <li><a href="#">프랑스 도서</a></li>
	                <li><a href="#">기타 도서</a></li>
	                <li><a href="#">잡지</a></li>
	                <li><a href="#">코믹</a></li>
	              </ol>
	            </li>
	          </ul>
	        </li><!--외국도서 li-->
	
	        <li>
	          <a href="#">
	            <i class="fa-solid fa-plus"></i>
	            eBook
	          </a>
	          <ul>
	            <li><a href="#">경제경영</a></li>
	            <li><a href="#">과학</a></li>
	            <li><a href="#">라이트노벨</a></li>
	            <li><a href="#">로맨스</a></li>
	            <li><a href="#">만화</a></li>
	            <li><a href="#">사회과학</a></li>
	            <li><a href="#">소설/시</a></li>
	            <li><a href="#">어린이</a></li>
	            <li><a href="#">에세이</a></li>
	            <li><a href="#">역사</a></li>
	            <li><a href="#">예술/대중문화</a></li>
	            <li><a href="#">인문학</a></li>
	            <li><a href="#">자기계발</a></li>
	            <li><a href="#">종교/역학</a></li>
	            <li><a href="#">청소년</a></li>
	            <li><a href="#">판타지/무협</a></li>
	            <li><a href="#">BL</a></li>
	            <li><a href="#">오디오북</a></li>
	          </ul>
	        </li>
	      </ul>
	    </nav>
	
	    <div class="container">
	      <nav>
	        <ul>
	          <li class="on"><a href="#">도서 모두보기</a></li>
	          <li><a href="#">베스트셀러</a></li>
	          <li><a href="#">정가 인하</a></li>
	          <li><a href="#">추천 도서</a></li>
	        </ul>
	      </nav>
	
	      <div class="book-frame">
	        <ol>
	          <!--동적생성
	          <li>
	            <a href="#">
	              <div class="cover"></div>
	              <div class="text">
	                <h3>자바의 정석</h3>
	                <p>남궁성</p>
	                <p>가격 : <span>27000</span>원</p>
	                <br />
	                <p>
	                  자바 프로그래머로써 반드시 알아야하는 것을 모두 담은책. 저자는 자바를 소개하는데 그치지 않고 프로그래머로써 꼭 알아야하는 내용들을 체계적으로 정리하였다.
	                </p>
	              </div>
	              <form action="#" method="post" name="listFrm">
	                <input type="hidden" name="bookid">
	                <button>장바구니</button>
	                <button>바로구매</button>
	              </form>
	            </a>
	          </li>
	          -->
	        </ol>
	      </div>
	      <div class="pagination-container">
	        <div class="pagenation-frame">
	          <div class="pagenation-slide">
	            
	          </div>
	        </div>
	      </div>
	    </div><!--.container-->
	  </section>
	  <footer>
      	<address>&copy;Designed by teamMillkyWay</address>
      </footer>
	</div>
</body>

</html>