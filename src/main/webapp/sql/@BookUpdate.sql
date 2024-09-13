

-- ctrl + a (전체선택) 후 ctrl + shift + enter  => 쿼리문 전체 실행

-- 이미지 파일을 바이너리 데이터로 변환하여 삽입
-- UPDATE Booktbl
-- SET photo = LOAD_FILE('C:\\DBimage\\book1.png')
-- WHERE bookid = 1;
-- SHOW VARIABLES LIKE 'secure_file_priv';

-- SHOW VARIABLES LIKE 'secure_file_priv';  -- 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'
-- 이미지 파일이 쿼리문 실행 결과인 C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\ 위치에 있어야함
-- ->
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book1.png') WHERE bookid = 1;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book2.png') WHERE bookid = 2;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book3.png') WHERE bookid = 3;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book4.png') WHERE bookid = 4;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book5.png') WHERE bookid = 5;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book6.png') WHERE bookid = 6;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book7.png') WHERE bookid = 7;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book8.png') WHERE bookid = 8;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book9.png') WHERE bookid = 9;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book10.png') WHERE bookid = 10;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book11.png') WHERE bookid = 11;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book12.png') WHERE bookid = 12;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book13.png') WHERE bookid = 13;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book14.png') WHERE bookid = 14;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book15.png') WHERE bookid = 15;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book16.png') WHERE bookid = 16;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book17.png') WHERE bookid = 17;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book18.png') WHERE bookid = 18;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book19.png') WHERE bookid = 19;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book20.png') WHERE bookid = 20;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book21.png') WHERE bookid = 21;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book22.png') WHERE bookid = 22;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book23.png') WHERE bookid = 23;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book24.png') WHERE bookid = 24;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book25.png') WHERE bookid = 25;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book26.png') WHERE bookid = 26;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book27.png') WHERE bookid = 27;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book28.png') WHERE bookid = 28;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book29.png') WHERE bookid = 29;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book30.png') WHERE bookid = 30;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book31.png') WHERE bookid = 31;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book32.png') WHERE bookid = 32;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book33.png') WHERE bookid = 33;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book34.png') WHERE bookid = 34;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book35.png') WHERE bookid = 35;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book36.png') WHERE bookid = 36;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book37.png') WHERE bookid = 37;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book38.png') WHERE bookid = 38;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book39.png') WHERE bookid = 39;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book40.png') WHERE bookid = 40;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book41.png') WHERE bookid = 41;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book42.png') WHERE bookid = 42;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book43.png') WHERE bookid = 43;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book44.png') WHERE bookid = 44;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book45.png') WHERE bookid = 45;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book46.png') WHERE bookid = 46;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book47.png') WHERE bookid = 47;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book48.png') WHERE bookid = 48;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book49.png') WHERE bookid = 49;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book50.png') WHERE bookid = 50;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book51.png') WHERE bookid = 51;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book52.png') WHERE bookid = 52;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book53.png') WHERE bookid = 53;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book54.png') WHERE bookid = 54;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book55.png') WHERE bookid = 55;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book56.png') WHERE bookid = 56;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book57.png') WHERE bookid = 57;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book58.png') WHERE bookid = 58;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book59.png') WHERE bookid = 59;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book60.png') WHERE bookid = 60;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book61.png') WHERE bookid = 61;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book62.png') WHERE bookid = 62;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book63.png') WHERE bookid = 63;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book64.png') WHERE bookid = 64;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book65.png') WHERE bookid = 65;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book66.png') WHERE bookid = 66;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book67.png') WHERE bookid = 67;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book68.png') WHERE bookid = 68;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book69.png') WHERE bookid = 69;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book70.png') WHERE bookid = 70;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book71.png') WHERE bookid = 71;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book72.png') WHERE bookid = 72;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book73.png') WHERE bookid = 73;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book74.png') WHERE bookid = 74;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book75.png') WHERE bookid = 75;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book76.png') WHERE bookid = 76;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book77.png') WHERE bookid = 77;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book78.png') WHERE bookid = 78;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book79.png') WHERE bookid = 79;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book80.png') WHERE bookid = 80;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book81.png') WHERE bookid = 81;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book82.png') WHERE bookid = 82;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book83.png') WHERE bookid = 83;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book84.png') WHERE bookid = 84;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book85.png') WHERE bookid = 85;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book86.png') WHERE bookid = 86;
UPDATE Booktbl SET photo = LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\book87.png') WHERE bookid = 87;



-- authorIntro,contents,contentsTables 임시데이터 업데이트문

-- 이문열
UPDATE Booktbl SET authorIntro = '이문열은 현대 한국 문학의 대표적인 작가로, 1948년에 태어나 서울에서 성장하였다. 그는 다양한 장르의 소설을 집필하였으며, 그 중에서도 "삼국지"의 한국적 재구성으로 유명하다. 그의 작품은 한국 사회와 역사에 대한 깊이 있는 통찰을 제공하며, 국내외에서 많은 독자들에게 사랑받고 있다. 또한 그는 평론가로서도 활발히 활동하며 문학에 대한 깊은 이해와 철학을 지닌 인물이다.' WHERE bookID = 1;

-- 조정래
UPDATE Booktbl SET authorIntro = '조정래는 한국 문학의 거장으로, 1943년에 태어나 경상북도에서 성장하였다. 그의 대표작인 "태백산맥"은 한국 현대사와 사회를 깊이 탐구한 작품으로, 한국 문학의 큰 획을 그었다. 조정래는 자신의 작품을 통해 사회적, 정치적 문제를 다루며 독자들에게 강력한 메시지를 전달하는 것으로 유명하다. 그의 작품은 깊이 있는 역사적 분석과 문학적 성찰을 통해 많은 독자들에게 영향을 미쳤다.' WHERE bookID = 2;

-- 김영하
UPDATE Booktbl SET authorIntro = '김영하는 1968년에 태어난 한국 소설가로, 현대 한국 문학의 주요 작가 중 한 명이다. 그의 작품은 주로 인간의 내면을 탐구하며, 복잡한 심리적 갈등을 진지하게 다룬다. "검은 꽃", "살인자의 기억법" 등은 그가 펼친 독창적인 서사와 심리적 깊이를 잘 보여주는 작품이다. 김영하는 현대 한국 사회와 인간 존재의 본질에 대해 깊은 성찰을 제공하며 많은 독자들에게 큰 영향을 미치고 있다.' WHERE bookID = 3;

-- 신경숙
UPDATE Booktbl SET authorIntro = '신경숙은 1963년에 태어난 한국 여성 작가로, 세련된 문체와 깊이 있는 서사로 많은 사랑을 받고 있다. 그녀의 대표작인 "엄마를 부탁해"는 한국 사회의 가족 문제와 여성의 역할을 깊이 있게 탐구하며 큰 인기를 끌었다. 신경숙은 자신의 작품을 통해 인간의 내면과 사회적 현실을 진지하게 탐구하며 독자들에게 감동을 주는 것으로 유명하다.' WHERE bookID = 4;

-- 박완서
UPDATE Booktbl SET authorIntro = '박완서는 1931년에 태어나 2011년에 세상을 떠난 한국의 유명 작가로, 그녀의 작품은 여성의 삶과 가족 문제를 중심으로 다루며 많은 사랑을 받았다. "그 여자네 집", "엄마를 부탁해" 등 그녀의 작품은 따뜻하고 인간적인 시각으로 독자들에게 큰 감동을 주었다. 박완서는 한국 현대 문학의 중요한 인물로 평가받고 있다.' WHERE bookID = 5;

-- 이기주
UPDATE Booktbl SET authorIntro = '이기주는 1956년에 태어나 한국 문학계에서 활발히 활동하는 작가이자 문학 평론가이다. 그의 작품은 주로 인간의 심리와 사회적 갈등을 깊이 있게 탐구하며, 섬세한 묘사와 강렬한 서사로 독자들에게 인상 깊은 독서 경험을 제공한다. 이기주는 현대 사회와 인간 본성에 대한 진지한 고민을 통해 문학적 성취를 이루어왔다.' WHERE bookID = 6;

-- 조남주
UPDATE Booktbl SET authorIntro = '조남주는 1978년에 태어난 한국 작가로, 현대 사회의 다양한 문제를 현실적이고 진지하게 탐구하는 작품으로 주목받고 있다. "82년생 김지영"으로 큰 인기를 끌며 사회적 메시지를 강력히 전달한 그의 작품은 여성과 가족, 사회적 이슈에 대한 깊이 있는 통찰을 제공한다. 조남주는 사회적 변화와 인간의 삶에 대한 깊은 고민을 문학에 담아내고 있다.' WHERE bookID = 7;

-- 한강
UPDATE Booktbl SET authorIntro = '한강은 1970년에 태어난 한국 작가로, 그녀의 작품은 주로 인간의 내면과 사회적 현실을 탐구하는 데 초점을 맞추고 있다. "채식주의자"로 국제적으로 큰 호평을 받으며, 독창적인 서사와 섬세한 문체로 많은 독자들에게 영향을 미쳤다. 한강은 현대 한국 문학의 중요한 작가로 평가받으며, 다양한 문학적 성취를 이루어왔다.' WHERE bookID = 8;

-- 정유정
UPDATE Booktbl SET authorIntro = '정유정은 1978년에 태어난 한국 소설가로, 그녀의 작품은 복잡한 인간 심리와 사회적 문제를 깊이 탐구하는 것으로 유명하다. "7년의 밤"과 같은 작품에서 보여준 독창적인 서사와 강렬한 캐릭터는 독자들에게 강한 인상을 남겼다. 정유정은 자신의 작품을 통해 현대 사회와 인간 본성에 대한 깊은 성찰을 담아내고 있다.' WHERE bookID = 9;

-- 김훈
UPDATE Booktbl SET authorIntro = '김훈은 1948년에 태어난 한국 작가로, 그의 작품은 주로 한국 역사와 사회적 갈등을 깊이 탐구한다. "칼의 노래"와 "흑산" 등에서 보여준 탁월한 서사와 문체로 많은 사랑을 받고 있다. 김훈은 현대 한국 문학의 중요한 인물로, 역사적 사실과 문학적 상상력을 결합하여 독자들에게 깊은 인상을 주는 작품을 집필하고 있다.' WHERE bookID = 10;

-- 베르나르 베르베르
UPDATE Booktbl SET authorIntro = '베르나르 베르베르는 1961년에 태어난 프랑스 소설가로, 그의 작품은 주로 공상과학과 철학적 주제를 탐구한다. "개미" 시리즈로 잘 알려져 있으며, 그의 독창적인 상상력과 심오한 질문은 많은 독자들에게 큰 인기를 끌었다. 베르베르는 현대 프랑스 문학에서 독특한 위치를 차지하며, 다양한 문학적 장르를 넘나드는 작가로 평가받고 있다.' WHERE bookID = 11;

-- 무라카미 하루키
UPDATE Booktbl SET authorIntro = '무라카미 하루키는 1949년에 태어난 일본의 소설가로, 그의 작품은 현대 일본 문학에서 중요한 위치를 차지하고 있다. "노르웨이의 숲", "1Q84" 등에서 보여준 독창적인 서사와 상상력은 세계적으로 큰 인기를 얻었다. 무라카미는 복잡한 인간 심리와 현실과 비현실을 넘나드는 서사로 독자들에게 깊은 감동을 주며, 문학적 성취를 이룬 작가이다.' WHERE bookID = 12;

-- 가즈오 이시구로
UPDATE Booktbl SET authorIntro = '가즈오 이시구로는 1954년에 태어난 일본-영국 작가로, 그의 작품은 주로 기억과 정체성, 인간의 본성을 탐구한다. "남아있는 나날"과 "자기만의 방" 등에서 보여준 뛰어난 서사와 섬세한 문체로 많은 독자들에게 사랑받고 있다. 이시구로는 현대 문학에서 중요한 작가로 평가받으며, 그의 작품은 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 13;

-- 헤르만 헤세
UPDATE Booktbl SET authorIntro = '헤르만 헤세는 1877년에 태어난 독일 작가로, 그의 작품은 인간의 영적 성장과 내면의 탐구를 중심으로 다루고 있다. "싯다르타", "데미안" 등에서 보여준 깊이 있는 철학적 성찰과 문학적 표현으로 많은 사랑을 받았다. 헤세는 20세기 문학의 중요한 인물로, 그의 작품은 인간 존재의 의미와 자기 발견에 대한 깊은 통찰을 제공한다.' WHERE bookID = 14;

-- 조지 오웰
UPDATE Booktbl SET authorIntro = '조지 오웰은 1903년에 태어난 영국 작가로, 그의 작품은 정치적 비판과 사회적 문제를 깊이 탐구한다. "1984", "동물농장" 등에서 보여준 날카로운 사회 분석과 예리한 비판으로 많은 독자들에게 영향을 미쳤다. 오웰은 현대 사회와 정치에 대한 중요한 성찰을 제공하며, 그의 작품은 오늘날에도 큰 영향력을 지니고 있다.' WHERE bookID = 15;

-- 어니스트 헤밍웨이
UPDATE Booktbl SET authorIntro = '어니스트 헤밍웨이는 1899년에 태어난 미국 작가로, 그의 작품은 간결하고 강렬한 문체로 유명하다. "노인과 바다", "무기여 잘 있거라" 등에서 보여준 인간의 고난과 용기에 대한 깊이 있는 묘사는 그를 20세기 문학의 거장으로 만들어주었다. 헤밍웨이는 현대 문학의 중요한 작가로 평가받으며, 그의 작품은 여전히 많은 독자들에게 감동을 주고 있다.' WHERE bookID = 16;

-- 가브리엘 가르시아 마르케스
UPDATE Booktbl SET authorIntro = '가브리엘 가르시아 마르케스는 1927년에 태어난 콜롬비아 작가로, 그의 작품은 마법적 리얼리즘을 통해 사회와 인간 본성을 탐구한다. "백년의 고독"은 그의 대표작으로, 복잡한 서사와 풍부한 상상력으로 많은 독자들에게 사랑받았다. 가르시아 마르케스는 문학적 혁신과 사회적 통찰을 통해 세계 문학에 큰 영향을 미쳤다.' WHERE bookID = 17;

-- 레프 톨스토이
UPDATE Booktbl SET authorIntro = '레프 톨스토이는 1828년에 태어난 러시아 작가로, 그의 작품은 인간 존재의 의미와 도덕적 문제를 깊이 탐구한다. "전쟁과 평화", "안나 카레니나" 등에서 보여준 탁월한 서사와 사회적 분석으로 문학사에 큰 족적을 남겼다. 톨스토이는 현대 문학의 거장으로 평가받으며, 그의 작품은 깊이 있는 인간 이해와 사회적 성찰을 제공한다.' WHERE bookID = 18;

-- 빅토르 위고
UPDATE Booktbl SET authorIntro = '빅토르 위고는 1802년에 태어난 프랑스 작가로, 그의 작품은 사회적 불평등과 정치적 문제를 탐구한다. "레미제라블", "노트르담 드 파리" 등에서 보여준 강렬한 서사와 인물 묘사는 그를 19세기 문학의 거장으로 만들어주었다. 위고는 사회적 정의와 인권에 대한 깊은 통찰을 작품에 담아내며, 많은 독자들에게 영향을 미쳤다.' WHERE bookID = 19;

-- 제인 오스틴
UPDATE Booktbl SET authorIntro = '제인 오스틴은 1775년에 태어난 영국 작가로, 그녀의 작품은 주로 19세기 영국 상류 사회를 풍자하고 탐구한다. "오만과 편견", "이성과 감성" 등에서 보여준 날카로운 사회적 관찰과 섬세한 인물 묘사는 오늘날에도 많은 사랑을 받고 있다. 오스틴은 현대 소설의 기초를 다진 중요한 작가로 평가받으며, 그녀의 작품은 여전히 많은 독자들에게 큰 영향을 미치고 있다.' WHERE bookID = 20;

-- 하명희
UPDATE Booktbl SET authorIntro = '하명희는 1961년에 태어난 한국 작가로, 그녀의 작품은 주로 가족과 사회적 관계를 중심으로 다룬다. "시절인연", "마음의 고향" 등에서 보여준 따뜻한 인간애와 사회적 통찰은 많은 독자들에게 감동을 주었다. 하명희는 자신의 작품을 통해 인간의 내면과 가족 문제를 진지하게 탐구하며, 현대 한국 문학에서 중요한 역할을 하고 있다.' WHERE bookID = 21;

-- 이민진
UPDATE Booktbl SET authorIntro = '이민진은 1977년에 태어난 한국-미국 작가로, 그녀의 작품은 주로 문화적 충돌과 정체성 문제를 탐구한다. "파친코"는 그녀의 대표작으로, 한국과 일본 간의 역사적 갈등과 개인의 고난을 다루며 큰 인기를 얻었다. 이민진은 자신의 작품을 통해 문화적 다양성과 인간의 본성에 대한 깊은 이해를 제공하며, 많은 독자들에게 사랑받고 있다.' WHERE bookID = 23;

-- 김연수
UPDATE Booktbl SET authorIntro = '김연수는 1969년에 태어난 한국 작가로, 그의 작품은 주로 현대 사회와 인간의 내면을 탐구한다. "피프티 피프티", "리미트" 등에서 보여준 독창적인 서사와 인간 심리에 대한 깊은 통찰은 많은 독자들에게 인상 깊은 독서 경험을 제공한다. 김연수는 현대 한국 문학에서 중요한 역할을 하고 있으며, 그의 작품은 독자들에게 깊이 있는 성찰을 제공한다.' WHERE bookID = 24;

-- 이청준
UPDATE Booktbl SET authorIntro = '이청준은 1939년에 태어난 한국 작가로, 그의 작품은 주로 역사와 사회적 문제를 탐구한다. "당신들의 천국", "수난이대" 등에서 보여준 깊이 있는 사회적 분석과 인간 내면에 대한 탐구는 많은 독자들에게 감동을 주었다. 이청준은 현대 한국 문학의 중요한 인물로 평가받으며, 그의 작품은 한국 사회와 인간 본성에 대한 깊이 있는 성찰을 제공한다.' WHERE bookID = 25;

-- 정미경
UPDATE Booktbl SET authorIntro = '정미경은 1978년에 태어난 한국 작가로, 그녀의 작품은 주로 현대 사회와 인간의 내면을 탐구하는 데 초점을 맞추고 있다. "지구에서 한아만큼"과 같은 작품에서 보여준 섬세한 서사와 인간에 대한 깊은 통찰은 독자들에게 큰 인기를 얻었다. 정미경은 현대 한국 문학에서 중요한 역할을 하고 있으며, 그녀의 작품은 깊이 있는 감동과 성찰을 제공한다.' WHERE bookID = 26;

-- 박범신
UPDATE Booktbl SET authorIntro = '박범신은 1955년에 태어난 한국 소설가로, 그의 작품은 주로 인간의 존재와 사회적 갈등을 탐구한다. "검은 꽃", "바람의 노래" 등에서 보여준 독창적인 서사와 사회적 통찰로 많은 사랑을 받고 있다. 박범신은 현대 한국 문학의 중요한 작가로 평가받으며, 그의 작품은 인간의 내면과 사회적 현실을 깊이 있게 탐구한다.' WHERE bookID = 27;

-- 윤이형
UPDATE Booktbl SET authorIntro = '윤이형은 1970년에 태어난 한국 작가로, 그녀의 작품은 주로 현대 사회와 인간의 내면을 탐구하는 데 초점을 맞추고 있다. "집으로 가는 길", "고백" 등에서 보여준 섬세한 문체와 인간 심리에 대한 깊은 통찰은 많은 독자들에게 사랑받고 있다. 윤이형은 현대 한국 문학에서 중요한 역할을 하고 있으며, 그녀의 작품은 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 28;

-- 김금희
UPDATE Booktbl SET authorIntro = '김금희는 1980년에 태어난 한국 작가로, 그녀의 작품은 주로 현대 사회와 인간의 내면을 탐구한다. "너무 시끄러운 고독", "경이로운 신세계" 등에서 보여준 독창적인 서사와 심리적 깊이는 많은 독자들에게 인상을 남겼다. 김금희는 현대 한국 문학에서 중요한 역할을 하고 있으며, 그녀의 작품은 독자들에게 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 29;

-- 황석영
UPDATE Booktbl SET authorIntro = '황석영은 1943년에 태어난 한국 소설가로, 그의 작품은 주로 사회적 갈등과 역사적 문제를 탐구한다. "삼포가는 길", "장길산" 등에서 보여준 깊이 있는 사회적 분석과 인간 심리는 많은 독자들에게 인상 깊은 독서 경험을 제공한다. 황석영은 현대 한국 문학의 중요한 인물로 평가받으며, 그의 작품은 한국 사회와 역사에 대한 깊은 통찰을 제공한다.' WHERE bookID = 30;

-- 김애란
UPDATE Booktbl SET authorIntro = '김애란은 1980년에 태어난 한국 작가로, 그녀의 작품은 주로 현대 사회와 인간의 내면을 탐구한다. "두근두근 내 인생", "비행운" 등에서 보여준 섬세한 문체와 독창적인 서사는 많은 독자들에게 큰 사랑을 받고 있다. 김애란은 현대 한국 문학에서 중요한 역할을 하고 있으며, 그녀의 작품은 독자들에게 깊이 있는 감동과 성찰을 제공한다.' WHERE bookID = 31;

-- 공지영
UPDATE Booktbl SET authorIntro = '공지영은 1963년에 태어난 한국 작가로, 그녀의 작품은 주로 인간의 내면과 사회적 갈등을 탐구한다. "무소유", "봉순이 언니" 등에서 보여준 깊이 있는 서사와 인간에 대한 통찰은 많은 사랑을 받고 있다. 공지영은 현대 한국 문학의 중요한 인물로 평가받으며, 그녀의 작품은 독자들에게 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 32;

-- 김수영
UPDATE Booktbl SET authorIntro = '김수영은 1921년에 태어나 1968년에 세상을 떠난 한국 시인으로, 그의 작품은 주로 사회적 문제와 인간의 고난을 탐구한다. "거대한 뿌리", "순간의 폭발" 등에서 보여준 강렬한 시적 표현과 사회적 비판은 많은 독자들에게 큰 영향을 미쳤다. 김수영은 현대 한국 시문학에서 중요한 인물로 평가받으며, 그의 작품은 여전히 많은 독자들에게 깊은 감동을 주고 있다.' WHERE bookID = 33;

-- 베르나르 베르베르
UPDATE Booktbl SET authorIntro = '베르나르 베르베르는 1961년에 태어난 프랑스 소설가로, 그의 작품은 주로 공상과학과 철학적 주제를 탐구한다. "개미" 시리즈로 잘 알려져 있으며, 그의 독창적인 상상력과 심오한 질문은 많은 독자들에게 큰 인기를 끌었다. 베르베르는 현대 프랑스 문학에서 독특한 위치를 차지하며, 다양한 문학적 장르를 넘나드는 작가로 평가받고 있다.' WHERE bookID = 36;

-- 파울로 코엘료
UPDATE Booktbl SET authorIntro = '파울로 코엘료는 1947년에 태어난 브라질 작가로, 그의 작품은 주로 인생의 의미와 개인의 영적 여정을 탐구한다. "연금술사", "베로니카, 죽기로 결심하다" 등에서 보여준 심오한 철학과 독창적인 서사는 많은 독자들에게 큰 사랑을 받고 있다. 코엘료는 현대 문학에서 중요한 작가로 평가받으며, 그의 작품은 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 37;

-- 하퍼 리
UPDATE Booktbl SET authorIntro = '하퍼 리는 1926년에 태어난 미국 작가로, 그녀의 작품은 주로 인권과 사회적 정의를 탐구한다. "앵무새 죽이기"는 그녀의 대표작으로, 인종 차별과 사회적 불평등에 대한 깊이 있는 분석으로 많은 사랑을 받았다. 하퍼 리는 현대 문학의 중요한 작가로 평가받으며, 그녀의 작품은 독자들에게 강력한 사회적 메시지를 전달하고 있다.' WHERE bookID = 38;

-- 오에 겐자부로
UPDATE Booktbl SET authorIntro = '오에 겐자부로는 1935년에 태어난 일본 작가로, 그의 작품은 주로 인간의 고난과 사회적 문제를 탐구한다. "개인의 인생", "천황의 고백" 등에서 보여준 깊이 있는 서사와 사회적 통찰은 많은 독자들에게 큰 영향을 미쳤다. 오에는 현대 일본 문학에서 중요한 작가로 평가받으며, 그의 작품은 독자들에게 깊은 성찰과 감동을 제공한다.' WHERE bookID = 39;

-- 조지 오웰
UPDATE Booktbl SET authorIntro = '조지 오웰은 1903년에 태어난 영국 작가로, 그의 작품은 정치적 비판과 사회적 문제를 깊이 탐구한다. "1984", "동물농장" 등에서 보여준 날카로운 사회 분석과 예리한 비판으로 많은 독자들에게 영향을 미쳤다. 오웰은 현대 사회와 정치에 대한 중요한 성찰을 제공하며, 그의 작품은 오늘날에도 큰 영향력을 지니고 있다.' WHERE bookID = 40;

-- 가브리엘 가르시아 마르케스
UPDATE Booktbl SET authorIntro = '가브리엘 가르시아 마르케스는 1927년에 태어난 콜롬비아 작가로, 그의 작품은 마법적 리얼리즘을 통해 사회와 인간 본성을 탐구한다. "백년의 고독"은 그의 대표작으로, 복잡한 서사와 풍부한 상상력으로 많은 독자들에게 사랑받았다. 가르시아 마르케스는 문학적 혁신과 사회적 통찰을 통해 세계 문학에 큰 영향을 미쳤다.' WHERE bookID = 41;

-- 제임스 조이스
UPDATE Booktbl SET authorIntro = '제임스 조이스는 1882년에 태어난 아일랜드 작가로, 그의 작품은 현대 문학의 혁신을 선도했다. "율리시즈", "초인간" 등에서 보여준 실험적인 서사와 복잡한 내면 탐구는 많은 문학 연구자들에게 깊은 영향을 미쳤다. 조이스는 현대 문학에서 중요한 위치를 차지하며, 그의 작품은 문학적 혁신과 심오한 성찰을 제공한다.' WHERE bookID = 42;

-- 마거릿 애트우드
UPDATE Booktbl SET authorIntro = '마거릿 애트우드는 1939년에 태어난 캐나다 작가로, 그녀의 작품은 주로 여성의 권리와 사회적 문제를 탐구한다. "시녀 이야기", "오릭스와 크레이크" 등에서 보여준 독창적인 서사와 사회적 비판은 많은 사랑을 받고 있다. 애트우드는 현대 문학에서 중요한 인물로 평가받으며, 그녀의 작품은 독자들에게 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 43;

-- 니콜로 마키아벨리
UPDATE Booktbl SET authorIntro = '니콜로 마키아벨리는 1469년에 태어난 이탈리아의 정치 철학자로, 그의 작품은 주로 정치 권력과 전략에 대한 분석을 다룬다. "군주론"은 그의 대표작으로, 권력의 본질과 정치적 현실을 깊이 탐구하며, 현대 정치학에 큰 영향을 미쳤다. 마키아벨리는 정치 이론과 전략에 대한 중요한 통찰을 제공하며, 그의 작품은 오늘날에도 많은 논의의 중심에 있다.' WHERE bookID = 44;

-- 프란츠 카프카
UPDATE Booktbl SET authorIntro = '프란츠 카프카는 1883년에 태어난 체코 작가로, 그의 작품은 주로 인간의 고난과 사회적 소외를 탐구한다. "변신", "심판" 등에서 보여준 독창적인 서사와 심리적 갈등은 많은 독자들에게 깊은 인상을 남겼다. 카프카는 현대 문학의 중요한 인물로 평가받으며, 그의 작품은 독자들에게 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 45;

-- 헨리 데이비드 소로
UPDATE Booktbl SET authorIntro = '헨리 데이비드 소로는 1817년에 태어난 미국 작가로, 그의 작품은 자연과 인간의 본성에 대한 깊이 있는 탐구를 중심으로 다룬다. "월든", "시민 불복종" 등에서 보여준 독창적인 사상과 자연에 대한 사랑은 많은 독자들에게 감동을 주었다. 소로는 현대 문학과 사상에 큰 영향을 미쳤으며, 그의 작품은 오늘날에도 많은 독자들에게 깊이 있는 성찰을 제공한다.' WHERE bookID = 46;

-- 알베르 카뮈
UPDATE Booktbl SET authorIntro = '알베르 카뮈는 1913년에 태어난 프랑스 작가로, 그의 작품은 주로 인간 존재의 의미와 삶의 부조리를 탐구한다. "이방인", "시시포스의 신화" 등에서 보여준 독창적인 철학적 성찰과 강렬한 서사는 많은 사랑을 받고 있다. 카뮈는 현대 문학의 중요한 인물로 평가받으며, 그의 작품은 독자들에게 깊이 있는 성찰과 감동을 제공한다.' WHERE bookID = 47;

-- 필립 K. 딕
UPDATE Booktbl SET authorIntro = '필립 K. 딕은 1928년에 태어난 미국 작가로, 그의 작품은 주로 미래 사회와 현실 인식의 문제를 탐구한다. "안드로이드는 전기 양을 꿈꾸는가?", "유령의 그림자" 등에서 보여준 독창적인 상상력과 철학적 질문은 많은 독자들에게 큰 인기를 얻었다. 딕은 현대 SF 문학의 중요한 작가로 평가받으며, 그의 작품은 미래 사회와 인간 본성에 대한 깊은 성찰을 제공한다.' WHERE bookID = 48;

-- 에밀리 브론테
UPDATE Booktbl SET authorIntro = '에밀리 브론테는 1818년에 태어난 영국 작가로, 그녀의 유일한 소설인 "폭풍의 언덕"은 강렬한 서사와 복잡한 인물 관계로 많은 사랑을 받았다. 브론테는 현대 문학의 중요한 작가로 평가받으며, 그녀의 작품은 인간의 감정과 내면을 깊이 탐구하며 독자들에게 큰 감동을 주고 있다.' WHERE bookID = 49;

-- 찰스 디킨스
UPDATE Booktbl SET authorIntro = '찰스 디킨스는 1812년에 태어난 영국 작가로, 그의 작품은 주로 사회적 문제와 인간의 고난을 탐구한다. "올리버 트위스트", "대망" 등에서 보여준 강렬한 서사와 사회적 분석은 많은 사랑을 받았다. 디킨스는 현대 문학의 중요한 인물로 평가받으며, 그의 작품은 독자들에게 깊이 있는 사회적 성찰을 제공한다.' WHERE bookID = 50;

-- 도스토옙스키
UPDATE Booktbl SET authorIntro = '표도르 미하일로비치 도스토옙스키(1821-1881)는 러시아의 소설가이자 철학자로, 인간의 내면과 도덕적 갈등을 심도 있게 탐구했다. 그의 대표작인 "죄와 벌", "카라마조프가의 형제들", "백치" 등에서는 사회적 불평등과 개인의 윤리적 갈등을 중심으로 복잡한 심리적 분석을 펼쳤다. 도스토옙스키는 인간 존재의 본질에 대한 깊은 질문을 던지며, 현대 문학에서 가장 중요한 문헌으로 평가받고 있다.' WHERE bookID = 51;

-- 샬럿 브론테
UPDATE Booktbl SET authorIntro = '샬럿 브론테(1816-1855)는 영국의 소설가이자 시인으로, 19세기 영국 사회에서 여성의 위치와 개인적 갈등을 탐구했다. 그녀의 대표작 "제인 에어"는 강한 여성 주인공과 복잡한 감정선으로 유명하며, 당시 여성의 제약과 자아를 싸우는 이야기를 담고 있다. 브론테의 작품은 그녀의 시대에 대한 도전과 새로운 시각을 제시하며 현대 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 53;

-- 버지니아 울프
UPDATE Booktbl SET authorIntro = '버지니아 울프(1882-1941)는 영국의 작가이자 비평가로, 현대 문학에서 실험적인 서사 기법을 선보였다. 그녀의 대표작 "등대로", "자기만의 방", "미세스 달로웨이" 등에서 내면의 독백과 흐름의 서사 기법을 통해 인간의 심리와 여성의 사회적 위치를 탐구했다. 울프의 작품은 그녀의 시대에 대한 깊은 사회적 비판과 개인의 내면에 대한 섬세한 통찰을 제공하며, 문학계에서 중요한 역할을 하고 있다.' WHERE bookID = 54;

-- 헬렌 필딩
UPDATE Booktbl SET authorIntro = '헬렌 필딩(1958- )은 영국의 작가이자 저널리스트로, 현대 여성의 삶과 유머를 중심으로 한 작품으로 유명하다. 그녀의 대표작 "브리짓 존스의 일기"는 30대 중반의 싱글 여성의 일상과 사랑의 복잡성을 유머러스하게 묘사하며 큰 인기를 끌었다. 필딩은 현대 사회에서 여성의 경험과 고민을 솔직하게 다루며, 독자들에게 큰 웃음과 공감을 선사한다.' WHERE bookID = 55;

-- 스티븐 킹
UPDATE Booktbl SET authorIntro = '스티븐 킹(1947- )은 미국의 작가로, 공포와 스릴러 장르에서 독창적인 작품을 다수 발표했다. 그의 대표작 "샤이닝", "그것", "미저리" 등에서 뛰어난 상상력과 긴장감 넘치는 서사로 독자들을 매료시켰다. 킹의 작품은 공포 장르의 새로운 기준을 제시하며, 현대 문학에서 가장 영향력 있는 작가 중 하나로 평가받고 있다.' WHERE bookID = 56;

-- 어슐러 K. 르귄
UPDATE Booktbl SET authorIntro = '어슐러 K. 르귄(1929-2018)은 미국의 작가로, 과학 소설과 판타지 장르에서 혁신적인 작품을 창작하였다. 그녀의 대표작 "어둠의 왼손", "지구해" 시리즈는 독창적인 세계관과 사회적 주제를 탐구하며 많은 찬사를 받았다. 르귄은 성별과 사회적 구조에 대한 새로운 시각을 제시하며, 현대 SF와 판타지 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 57;

-- 로버트 루이스 스티븐슨
UPDATE Booktbl SET authorIntro = '로버트 루이스 스티븐슨(1850-1894)은 스코틀랜드 출신의 작가로, 모험과 판타지 장르에서 유명하다. 그의 대표작 "지킬 박사와 하이드 씨", "보물섬" 등에서 흥미진진한 이야기와 강렬한 캐릭터를 통해 독자들을 매료시켰다. 스티븐슨은 문학의 새로운 경향을 선도하며 현대 문학에서 중요한 인물로 평가받고 있다.' WHERE bookID = 58;

-- 레몽 크노
UPDATE Booktbl SET authorIntro = '레몽 크노(1896-1974)는 프랑스의 작가로, 현대 문학에서 실험적인 서사 기법을 선보였다. 그의 대표작 "미래의 시대", "철의 왕국" 등에서 독창적인 서사 구조와 철학적 주제를 탐구하며 문학의 새로운 지평을 열었다. 크노는 독창적인 서사 기법과 심오한 주제로 현대 문학의 혁신적인 작가로 평가받으며, 그의 작품은 독자들에게 새로운 문학적 경험을 제공한다.' WHERE bookID = 59;

-- 제임스 볼드윈
UPDATE Booktbl SET authorIntro = '제임스 볼드윈(1924-1987)은 미국의 작가이자 사회 비평가로, 인종 문제와 개인의 정체성을 주제로 한 작품으로 유명하다. 그의 대표작 "딸의 방", "그로부터 먼 거리" 등에서 인종 차별과 사회적 억압을 깊이 탐구하며 강력한 사회적 메시지를 전달했다. 볼드윈의 작품은 현대 사회와 인종 문제에 대한 깊은 성찰을 제공하며, 그는 문학과 사회 비평에서 중요한 인물로 평가받고 있다.' WHERE bookID = 60;

-- 제롬 데이비드 샐린저
UPDATE Booktbl SET authorIntro = '제롬 데이비드 샐린저(1919-2010)는 미국의 작가로, 청소년의 정체성과 사회적 고립을 탐구한 작품으로 유명하다. 그의 대표작 "호밀밭의 파수꾼"은 청소년기의 혼란과 내면의 갈등을 사실적으로 묘사하며 많은 독자들에게 큰 감동을 주었다. 샐린저는 현대 문학에서 중요한 작가로 평가받으며, 그의 작품은 강렬한 감동과 성찰을 제공한다.' WHERE bookID = 61;

-- 제임스 미치너
UPDATE Booktbl SET authorIntro = '제임스 미치너(1907-1997)는 미국의 작가로, 역사적 배경과 인물들을 다룬 작품으로 유명하다. 그의 대표작 "알래스카", "타이탄" 등에서 풍부한 역사적 지식과 몰입감 있는 서사를 통해 독자들에게 강력한 인상을 남겼다. 미치너는 역사적 통찰과 스토리텔링의 기법으로 현대 문학에서 중요한 작가로 평가받고 있다.' WHERE bookID = 62;

-- 나사니엘 호손
UPDATE Booktbl SET authorIntro = '나사니엘 호손(1804-1864)은 미국의 작가로, 인간의 죄와 도덕적 갈등을 주제로 한 작품으로 유명하다. 그의 대표작 "주홍글씨"와 "집사의 고백" 등에서 강렬한 심리적 분석과 사회적 비판을 통해 인간 존재의 본질을 탐구했다. 호손은 현대 문학의 중요한 인물로 평가받으며, 그의 작품은 깊이 있는 성찰을 제공한다.' WHERE bookID = 63;

-- 찰스 다윈
UPDATE Booktbl SET authorIntro = '찰스 다윈(1809-1882)은 영국의 생물학자로, 그의 연구는 주로 진화론과 자연 선택의 이론을 중심으로 한다. 그의 대표작 "종의 기원"은 생물학적 진화에 대한 혁신적인 관점을 제시하며 과학계에 큰 영향을 미쳤다. 다윈은 현대 생물학의 아버지로 평가받으며, 그의 이론은 오늘날에도 많은 논의의 중심에 있다.' WHERE bookID = 64;

-- 알렉상드르 뒤마
UPDATE Booktbl SET authorIntro = '알렉상드르 뒤마(1802-1870)는 프랑스의 작가로, 역사적 모험과 로맨스 장르에서 두각을 나타냈다. 그의 대표작 "삼총사"와 "몬테크리스토 백작" 등에서 흥미진진한 이야기와 강렬한 캐릭터를 통해 독자들을 매료시켰다. 뒤마의 작품은 당시 문학의 새로운 경향을 선도하며, 현대 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 65;

-- 에밀 졸라
UPDATE Booktbl SET authorIntro = '에밀 졸라(1840-1902)는 프랑스의 소설가이자 사회 비평가로, 자연주의 문학의 선구자로 평가받는다. 그의 대표작 "테레즈 라캥", "제제" 등에서 사회적 불평등과 인간의 본성을 탐구하며 당시 사회의 모순을 비판했다. 졸라는 사회적 현실을 사실적으로 묘사하며 현대 문학에서 중요한 역할을 하고 있다.' WHERE bookID = 66;

-- 귀스타브 플로베르
UPDATE Booktbl SET authorIntro = '귀스타브 플로베르(1821-1880)는 프랑스의 작가로, 사실주의 문학의 발전에 기여했다. 그의 대표작 "보바리 부인"은 당시 사회의 도덕적 모순과 개인의 갈등을 심도 있게 탐구하며 문학적 혁신을 이끌었다. 플로베르는 문학의 스타일과 기법을 새롭게 정의하며 현대 문학에서 중요한 인물로 평가받고 있다.' WHERE bookID = 67;

-- 발터 슈바이커트
UPDATE Booktbl SET authorIntro = '발터 슈바이커트(1879-1960)는 독일의 작가이자 철학자로, 현대 문학과 사상에 큰 영향을 미쳤다. 그의 대표작 "역사와 인식"과 "비극과 극복" 등에서 철학적 사고와 역사적 분석을 통해 인간 존재의 의미를 탐구했다. 슈바이커트는 문학과 사상을 융합하여 깊이 있는 통찰을 제공하며, 현대 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 68;

-- 니콜라스 스파크스
UPDATE Booktbl SET authorIntro = '니콜라스 스파크스(1965- )는 미국의 작가로, 감성적이고 드라마틱한 사랑 이야기를 중심으로 한 작품으로 유명하다. 그의 대표작 "노트북", "사랑할 때까지" 등에서 강렬한 감정선과 인간 관계의 복잡성을 탐구하며 많은 독자들에게 감동을 주었다. 스파크스는 현대 로맨스 문학의 중요한 작가로 평가받고 있다.' WHERE bookID = 69;

-- 에드가 앨런 포
UPDATE Booktbl SET authorIntro = '에드가 앨런 포(1809-1849)는 미국의 시인, 소설가, 수필가로, 공포와 추리 장르에서 중요한 기여를 했다. 그의 대표작 "흑새"와 "우체국의 소포" 등에서 독창적인 상상력과 강렬한 분위기로 독자들을 매료시켰다. 포는 현대 추리와 공포 문학의 기초를 닦았으며, 그의 작품은 여전히 많은 사랑을 받고 있다.' WHERE bookID = 70;

-- 토머스 하디
UPDATE Booktbl SET authorIntro = '토머스 하디(1840-1928)는 영국의 소설가이자 시인으로, 19세기 영국 사회의 복잡한 갈등과 인간의 운명을 탐구했다. 그의 대표작 "테스", "드로터의 여인" 등에서 사회적 불평등과 개인의 비극적인 운명을 심도 있게 다루었다. 하디의 작품은 당시 사회의 모순과 인간의 고뇌를 깊이 있게 묘사하며 현대 문학에서 중요한 인물로 평가받고 있다.' WHERE bookID = 71;

-- 가르시아 로르카
UPDATE Booktbl SET authorIntro = '가르시아 로르카(1898-1936)는 스페인의 시인, 극작가로, 스페인 문학의 중요한 인물 중 하나로 평가된다. 그의 대표작 "가정의 여왕", "로마서" 등에서 독창적인 시적 표현과 사회적 비판을 통해 스페인 문학에 큰 영향을 미쳤다. 로르카는 정치적 억압과 사회적 갈등 속에서 강렬한 문학적 목소리를 내며, 현대 문학에서도 큰 영향력을 발휘하고 있다.' WHERE bookID = 72;

-- 헨리크 입센
UPDATE Booktbl SET authorIntro = '헨리크 입센(1828-1906)은 노르웨이의 극작가이자 소설가로, 현대 연극의 중요한 혁신자로 평가된다. 그의 대표작 "인형의 집", "헤다 가블러" 등에서 사회적 제약과 개인의 갈등을 중심으로 한 강렬한 이야기를 다루었다. 입센의 작품은 당시 사회의 모순과 인간의 내면을 깊이 탐구하며 현대 문학에 큰 영향을 미쳤다.' WHERE bookID = 73;

-- 요한 볼프강 폰 괴테
UPDATE Booktbl SET authorIntro = '요한 볼프강 폰 괴테(1749-1832)는 독일의 작가이자 철학자로, 독일 문학과 사상의 중요한 인물 중 하나이다. 그의 대표작 "파우스트", "젊은 베르터의 고백" 등에서 인간의 존재와 운명을 탐구하며 문학적 혁신을 이루었다. 괴테는 그의 시대와 문화를 넘어서는 깊은 철학적 통찰과 문학적 성취로 현대 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 74;

-- 루이스 캐럴
UPDATE Booktbl SET authorIntro = '루이스 캐럴(1832-1898)은 영국의 작가이자 수학자로, 어린이 문학의 혁신적 작품을 남겼다. 그의 대표작 "이상한 나라의 앨리스"와 "거울 나라의 앨리스" 등에서 기발한 상상력과 독창적인 서사로 어린이와 어른 모두에게 큰 사랑을 받았다. 캐럴은 어린이 문학의 새로운 지평을 열었으며, 그의 작품은 시간이 지나도 여전히 많은 사람들에게 사랑받고 있다.' WHERE bookID = 75;

-- 프레드릭 백만
UPDATE Booktbl SET authorIntro = '프레드릭 백만(1850-1917)은 프랑스의 작가로, 그의 작품은 주로 인간의 도덕적, 사회적 갈등을 중심으로 한다. 그의 대표작 "빨간 머리 앤", "장미의 속삭임" 등에서 인간의 본성과 사회적 갈등을 탐구하며 독자들에게 강한 인상을 남겼다. 백만의 작품은 그의 시대와 사회를 비판하며 현대 문학에 중요한 기여를 했다.' WHERE bookID = 76;

-- 하랄드 슈미트
UPDATE Booktbl SET authorIntro = '하랄드 슈미트(1888-1965)는 독일의 작가이자 극작가로, 그의 작품은 주로 인간의 심리와 사회적 갈등을 탐구한다. 그의 대표작 "모래의 고백", "황혼의 노래" 등에서 심리적 깊이와 사회적 비판을 통해 독자들에게 강렬한 인상을 남겼다. 슈미트의 작품은 현대 문학의 중요한 부분을 차지하며, 심오한 인문적 통찰을 제공한다.' WHERE bookID = 77;

-- 마르셀 프루스트
UPDATE Booktbl SET authorIntro = '마르셀 프루스트(1871-1922)는 프랑스의 작가로, 그의 작품은 주로 기억과 시간의 흐름을 탐구한다. 그의 대표작 "잃어버린 시간을 찾아서"는 세밀한 심리적 분석과 독창적인 서사 기법으로 문학적 혁신을 이루었다. 프루스트는 내면의 세계와 시간의 본질을 탐구하며 현대 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 79;

-- 앙드레 지드
UPDATE Booktbl SET authorIntro = '앙드레 지드(1869-1951)는 프랑스의 작가로, 인간의 내면과 사회적 도덕을 탐구하는 작품으로 유명하다. 그의 대표작 "지하실", "호미니드" 등에서 개인의 자아와 도덕적 갈등을 심도 있게 다루었다. 지드는 문학적 실험과 사상적 탐구를 통해 현대 문학에서 중요한 역할을 하며, 그의 작품은 많은 독자들에게 깊은 성찰을 제공한다.' WHERE bookID = 80;

-- 제롬 K. 제롬
UPDATE Booktbl SET authorIntro = '제롬 K. 제롬(1859-1927)은 영국의 작가로, 그의 작품은 주로 유머와 풍자를 중심으로 한다. 그의 대표작 "세 남자와 보트", "여행하는 의사" 등에서 기발한 유머와 재치 있는 이야기로 독자들에게 큰 사랑을 받았다. 제롬은 현대 유머 문학의 중요한 인물로 평가받으며, 그의 작품은 여전히 많은 사람들에게 웃음을 주고 있다.' WHERE bookID = 81;

-- 로맹 가리
UPDATE Booktbl SET authorIntro = '로맹 가리(1914-1980)는 프랑스의 작가이자 외교관으로, 그의 작품은 주로 인간의 갈등과 사회적 모순을 탐구한다. 그의 대표작 "저 하늘의 별들", "어느 날, 어머니" 등에서 복잡한 인간 관계와 사회적 문제를 깊이 있게 다루었다. 가리는 현대 문학에서 중요한 위치를 차지하며, 그의 작품은 독자들에게 깊은 감동과 성찰을 제공한다.' WHERE bookID = 82;

-- 에리히 프롬
UPDATE Booktbl SET authorIntro = '에리히 프롬(1900-1980)은 독일의 심리학자이자 사회 비평가로, 인간의 자유와 사회적 제약을 중심으로 한 작품으로 유명하다. 그의 대표작 "사랑의 혁명", "자유의 두 얼굴" 등에서 인간의 본성과 사회적 억압을 탐구하며 많은 영향을 미쳤다. 프롬은 사회적 통찰과 심리학적 분석을 통해 현대 문학과 사회 비평에서 중요한 역할을 하고 있다.' WHERE bookID = 83;

-- 플라톤
UPDATE Booktbl SET authorIntro = '플라톤(427-347 B.C.)은 고대 그리스의 철학자로, 서양 철학의 기초를 다진 인물로 평가받는다. 그의 대표작 "공화국", "향연" 등에서 정의, 사랑, 국가의 본질을 탐구하며 철학적 사유를 깊이 있게 제시했다. 플라톤은 그의 시대를 넘어서는 깊은 철학적 통찰과 사상으로 현대 철학과 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 84;

-- 장자크 루소
UPDATE Booktbl SET authorIntro = '장자크 루소(1712-1778)는 프랑스의 철학자이자 작가로, 현대 정치 사상과 교육 사상에 큰 영향을 미쳤다. 그의 대표작 "사회 계약론", "에밀" 등에서 인간의 자유와 평등, 교육의 중요성을 탐구하며 많은 찬사를 받았다. 루소의 사상은 현대 사회의 정치적 논의와 교육 이론에 중요한 기여를 하고 있으며, 그의 작품은 여전히 많은 독자들에게 깊은 영향을 미치고 있다.' WHERE bookID = 85;

-- 장폴 사르트르
UPDATE Booktbl SET authorIntro = '장폴 사르트르(1905-1980)는 프랑스의 철학자이자 소설가로, 실존주의 사상의 주요 인물로 평가받는다. 그의 대표작 "구토", "존재와 무" 등에서 인간 존재의 부조리와 자유를 탐구하며 깊은 철학적 통찰을 제공했다. 사르트르의 사상과 문학적 작품은 현대 철학과 문학에서 중요한 위치를 차지하며, 많은 독자들에게 깊은 성찰을 제공한다.' WHERE bookID = 86;

-- 아우구스티누스
UPDATE Booktbl SET authorIntro = '아우구스티누스(354-430)는 초기 기독교의 신학자이자 철학자로, 그의 사상은 서양 기독교 사상의 기초를 다졌다. 그의 대표작 "고백록"과 "신국론" 등에서 인간의 본성과 신의 뜻, 구원의 문제를 탐구하며 기독교 신학에 중요한 기여를 했다. 아우구스티누스의 사상은 기독교 사상과 철학에서 중요한 역할을 하며, 그의 작품은 오늘날에도 많은 독자들에게 깊은 영향을 미치고 있다.' WHERE bookID = 87;

-- 조정래
UPDATE Booktbl SET authorIntro = '조정래(1943- )는 한국의 소설가이자 작가로, 역사와 사회적 갈등을 중심으로 한 작품으로 잘 알려져 있다. 그의 대표작 "태백산맥", "아리랑" 등에서 한국 현대사의 중요한 사건들과 사회적 이슈를 심도 있게 다루며, 한국 문학에서 큰 영향을 미쳤다. 조정래의 작품은 한국의 역사적, 사회적 맥락을 깊이 있게 탐구하며 많은 독자들에게 깊은 인상을 남겼다.' WHERE bookID = 22;

-- 한강
UPDATE Booktbl SET authorIntro = '한강(1970- )은 현대 한국 문학의 주요 작가 중 한 명으로, 그의 작품은 인간의 고통과 회복을 중심으로 한 섬세한 서사로 유명하다. 대표작 "채식주의자", "소년이 온다" 등에서 사회적, 정치적 갈등과 개인의 내면적 갈등을 탐구하며, 독특한 문체와 깊이 있는 내용으로 많은 찬사를 받았다. 한강의 작품은 한국 문학에서 중요한 위치를 차지하고 있다.' WHERE bookID = 34;

-- 이문열
UPDATE Booktbl SET authorIntro = '이문열(1948- )은 한국의 대표적인 소설가이자 사회 비평가로, 그의 작품은 한국 사회와 역사에 대한 깊은 통찰을 제공한다. 대표작 "우리들의 일그러진 영웅", "삼국지" 등에서 사회적 모순과 인간의 본성을 탐구하며, 문학적 성취와 사회적 비판을 통해 많은 독자들에게 영향을 미쳤다. 이문열은 한국 문학의 중요한 인물로 평가받고 있다.' WHERE bookID = 35;

-- 레프 톨스토이
UPDATE Booktbl SET authorIntro = '레프 톨스토이(1828-1910)는 러시아의 대문호로, 그의 작품은 인간 존재와 도덕적 문제를 깊이 탐구한다. 대표작 "전쟁과 평화", "안나 카레니나" 등에서 복잡한 인간 관계와 사회적 갈등을 사실적으로 묘사하며 문학적 혁신을 이끌었다. 톨스토이는 그의 시대를 넘어서는 심오한 통찰로 현대 문학에서도 중요한 위치를 차지하고 있다.' WHERE bookID = 52;

-- 레프 톨스토이
UPDATE Booktbl SET authorIntro = '레프 톨스토이(1828-1910)는 러시아 문학의 거장으로, 인간 존재의 의미와 도덕적 갈등을 심도 있게 탐구한 작품으로 유명하다. "전쟁과 평화"와 "안나 카레니나"는 그의 대표작으로, 러시아 사회와 역사적 배경을 생생히 묘사하며 문학적 혁신을 이루었다. 톨스토이의 작품은 오늘날에도 많은 독자들에게 깊은 영향을 미치고 있다.' WHERE bookID = 78;

















-- 작품명: 우리들의 일그러진 영웅
UPDATE booktbl
SET contents = '‘우리들의 일그러진 영웅’은 이문열 작가의 한국 현대문학의 대표작으로, 군사정권 시절의 학교를 배경으로 한 소설입니다. 이 작품은 독재와 권력의 압박 아래에서 일어나는 학생들 간의 갈등과 인간성을 그립니다. 이문열은 이 작품을 통해 권위주의적 사회에서의 인간 존재와 도덕적 혼란을 사실적이고도 심도 깊게 묘사하며, 독자들에게 권력과 인간성에 대한 깊은 사색을 제공합니다. ‘우리들의 일그러진 영웅’은 한국 현대문학에서 중요한 위치를 차지하며, 사회적 메시지를 전달하는 중요한 작품입니다.'
WHERE bookid = '1';

-- 작품명: 태백산맥
UPDATE booktbl
SET contents = '‘태백산맥’은 조정래 작가의 한국 역사소설의 정수로, 한국 현대사의 중요한 사건인 한국 전쟁과 그로 인한 사회적 변화를 중심으로 한 대서사시입니다. 조정래는 이 작품을 통해 전쟁과 사회적 격변 속에서의 인간의 고난과 삶을 사실적이고도 심도 깊게 묘사하며, 독자들에게 한국 현대사에 대한 깊은 이해와 교훈을 제공합니다. ‘태백산맥’은 한국 현대문학의 중요한 작품으로, 현대사의 복잡한 문제와 개인의 삶에 대한 깊은 통찰을 제시합니다.'
WHERE bookid = '2';

-- 작품명: 오직 두 사람
UPDATE booktbl
SET contents = '‘오직 두 사람’은 김영하 작가의 단편 소설집으로, 현대 사회의 다양한 인간 군상을 사실적이고도 섬세하게 그립니다. 김영하는 이 작품을 통해 인간의 내면과 사회적 갈등을 탐구하며, 독자들에게 현대인의 복잡한 감정과 상황을 깊이 이해할 수 있는 기회를 제공합니다. ‘오직 두 사람’은 현대 문학의 중요한 작품으로, 인간 관계와 사회적 문제에 대한 심도 있는 탐구를 담고 있습니다.'
WHERE bookid = '3';

-- 작품명: 엄마를 부탁해
UPDATE booktbl
SET contents = '‘엄마를 부탁해’는 신경숙 작가의 한국 문학의 또 다른 진면목으로, 가족과 어머니의 사랑을 중심으로 한 감동적인 이야기입니다. 이 작품은 어머니의 실종과 그로 인한 가족의 고통을 그리며, 한국 사회의 가족 가치와 인간의 본성을 탐구합니다. 신경숙은 이 작품을 통해 가족의 의미와 어머니의 희생을 사실적이고도 감동적으로 묘사하며, 독자들에게 가족과 사랑의 중요성을 깊이 이해할 수 있는 기회를 제공합니다. ‘엄마를 부탁해’는 한국 문학에서 중요한 위치를 차지하며, 인간의 감정과 가족에 대한 깊은 통찰을 제공합니다.'
WHERE bookid = '4';

-- 작품명: 나목
UPDATE booktbl
SET contents = '‘나목’은 박완서 작가의 한국 전쟁을 배경으로 한 소설로, 전쟁의 참혹함과 그로 인한 사회적 변화를 중심으로 이야기를 전개합니다. 이 작품은 전쟁 속에서의 인간의 고난과 삶의 의미를 사실적이고도 심도 깊게 탐구하며, 독자들에게 전쟁의 참상과 인간의 존엄성에 대한 깊은 이해를 제공합니다. 박완서는 이 작품을 통해 전쟁과 평화의 복잡한 문제를 조명하며, 한국 문학에서 중요한 위치를 차지하는 작품입니다.'
WHERE bookid = '5';

-- 작품명: 언어의 온도
UPDATE booktbl
SET contents = '‘언어의 온도’는 이기주 작가의 삶과 사랑에 대한 짧은 에세이로, 언어와 감정의 관계를 탐구합니다. 이 작품은 다양한 상황에서의 언어의 사용과 그로 인한 감정의 변화를 중심으로, 인간의 내면을 심도 깊게 탐구하며 독자들에게 언어의 힘과 감정의 연관성을 이해할 수 있는 기회를 제공합니다. ‘언어의 온도’는 현대 문학에서 중요한 위치를 차지하며, 감정과 언어에 대한 깊은 통찰을 제공합니다.'
WHERE bookid = '6';

-- 작품명: 82년생 김지영
UPDATE booktbl
SET contents = '‘82년생 김지영’은 조남주 작가의 현대 여성의 이야기를 담은 소설로, 한국 사회에서 여성의 삶과 그로 인한 사회적 갈등을 중심으로 전개됩니다. 이 작품은 여성의 일상과 사회적 압박을 사실적이고도 감동적으로 묘사하며, 독자들에게 현대 사회에서의 여성 문제와 그로 인한 사회적 불평등에 대한 깊은 이해를 제공합니다. ‘82년생 김지영’은 현대 문학에서 중요한 작품으로, 여성의 권리와 사회적 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '7';

-- 작품명: 채식주의자
UPDATE booktbl
SET contents = '‘채식주의자’는 한강 작가의 인간 내면의 폭력을 다룬 소설로, 현대 사회에서의 인간의 심리와 갈등을 중심으로 진행됩니다. 이 작품은 주인공의 채식주의적 선택과 그로 인한 가족과 사회적 갈등을 사실적이고도 심도 깊게 탐구하며, 독자들에게 인간의 내면과 사회적 압박에 대한 깊은 이해를 제공합니다. ‘채식주의자’는 현대 문학에서 중요한 작품으로, 인간 심리와 사회적 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '8';

-- 작품명: 7년의 밤
UPDATE booktbl
SET contents = '‘7년의 밤’은 정유정 작가의 인간의 심리를 깊이 파고드는 소설로, 범죄와 그로 인한 사회적 갈등을 중심으로 전개됩니다. 이 작품은 주인공의 복잡한 심리와 그로 인한 갈등을 사실적이고도 심도 깊게 묘사하며, 독자들에게 인간의 내면과 범죄의 심각성에 대한 깊은 이해를 제공합니다. ‘7년의 밤’은 현대 문학에서 중요한 작품으로, 인간 심리와 범죄 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '9';

-- 작품명: 칼의 노래
UPDATE booktbl
SET contents = '‘칼의 노래’는 김훈 작가의 이순신 장군의 삶을 다룬 소설로, 한국 역사와 그로 인한 사회적 변화에 대한 이야기를 중심으로 전개됩니다. 이 작품은 이순신 장군의 용기와 지혜, 그리고 전쟁의 참상을 사실적이고도 심도 깊게 탐구하며, 독자들에게 한국 역사와 인간의 고난에 대한 깊은 이해를 제공합니다. ‘칼의 노래’는 한국 문학에서 중요한 작품으로, 역사와 인간의 삶에 대한 깊은 통찰을 제시합니다.'
WHERE bookid = '10';

-- 작품명: 개미
UPDATE booktbl
SET contents = '‘개미’는 베르나르 베르베르 작가의 프랑스 소설의 걸작으로, 인간과 개미의 상호작용을 중심으로 한 독특한 이야기입니다. 이 작품은 개미 사회와 인간 사회의 유사점과 차이점을 탐구하며, 인간의 존재와 사회적 구조를 사실적이고도 상상력 넘치는 방식으로 묘사합니다. ‘개미’는 현대 문학에서 중요한 작품으로, 인간과 자연의 관계에 대한 깊은 통찰을 제공합니다.'
WHERE bookid = '11';

-- 작품명: 1Q84
UPDATE booktbl
SET contents = '‘1Q84’는 무라카미 하루키 작가의 현대 일본 소설의 대표작으로, 평행 세계와 그로 인한 사회적 갈등을 중심으로 한 대서사시입니다. 이 작품은 주인공들이 겪는 복잡한 현실과 상상의 경계를 탐구하며, 현대 사회의 문제와 인간의 내면을 사실적이고도 심도 깊게 묘사합니다. ‘1Q84’는 현대 문학에서 중요한 작품으로, 평행 세계와 인간 존재에 대한 깊은 이해를 제공합니다.'
WHERE bookid = '12';

-- 작품명: 나를 보내지 마
UPDATE booktbl
SET contents = '‘나를 보내지 마’는 가즈오 이시구로 작가의 노벨 문학상 수상작으로, 기억과 정체성, 그리고 인간의 삶에 대한 깊은 탐구를 중심으로 한 소설입니다. 이 작품은 주인공들의 복잡한 감정과 과거의 기억을 사실적이고도 심도 깊게 탐구하며, 독자들에게 인간 존재와 정체성에 대한 깊은 이해를 제공합니다. ‘나를 보내지 마’는 현대 문학에서 중요한 작품으로, 기억과 정체성의 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '13';

-- 작품명: 데미안
UPDATE booktbl
SET contents = '‘데미안’은 헤르만 헤세 작가의 독일 문학의 정수로, 자아 발견과 성장의 과정을 중심으로 한 철학적 소설입니다. 이 작품은 주인공이 자신의 정체성을 찾기 위해 겪는 내적 갈등과 성장을 사실적이고도 심도 깊게 묘사하며, 독자들에게 자아 탐구와 성장에 대한 깊은 이해를 제공합니다. ‘데미안’은 현대 문학에서 중요한 작품으로, 자아 발견과 철학적 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '14';

-- 작품명: 1984
UPDATE booktbl
SET contents = '‘1984’는 조지 오웰 작가의 전체주의의 위험을 경고하는 작품으로, 디스토피아적 사회를 배경으로 한 정치적 풍자 소설입니다. 이 작품은 전체주의 체제와 그로 인한 개인의 자유와 인간성을 억압하는 사회적 구조를 사실적이고도 심도 깊게 탐구하며, 독자들에게 정치적 경각심과 인간의 존엄성에 대한 깊은 이해를 제공합니다. ‘1984’는 현대 문학에서 중요한 작품으로, 전체주의와 자유의 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '15';

-- 작품명: 노인과 바다
UPDATE booktbl
SET contents = '‘노인과 바다’는 어니스트 헤밍웨이 작가의 노벨 문학상 수상작으로, 인간의 고난과 인내를 중심으로 한 감동적인 이야기입니다. 이 작품은 노인의 바다에서의 싸움과 그로 인한 인간의 본성에 대한 탐구를 사실적이고도 감동적으로 묘사하며, 독자들에게 인간의 고난과 용기에 대한 깊은 이해를 제공합니다. ‘노인과 바다’는 현대 문학에서 중요한 작품으로, 인간의 고난과 인내를 탐구하는 중요한 소설입니다.'
WHERE bookid = '16';

-- 작품명: 백년의 고독
UPDATE booktbl
SET contents = '‘백년의 고독’은 가브리엘 가르시아 마르케스 작가의 라틴 아메리카 문학의 정수로, 마술적 리얼리즘의 대표작입니다. 이 작품은 부에나비스타 가문의 역사와 그로 인한 사회적 변화와 인간의 운명을 중심으로 한 대서사시입니다. 가르시아 마르케스는 이 작품을 통해 라틴 아메리카의 역사와 문화, 인간의 본성을 사실적이고도 상상력 넘치는 방식으로 묘사하며, 독자들에게 라틴 아메리카의 정체성과 인간 존재에 대한 깊은 이해를 제공합니다. ‘백년의 고독’은 현대 문학에서 중요한 작품으로, 마술적 리얼리즘과 인간의 운명에 대한 깊은 통찰을 제시합니다.'
WHERE bookid = '17';

-- 작품명: 전쟁과 평화
UPDATE booktbl
SET contents = '‘전쟁과 평화’는 레프 톨스토이 작가의 러시아 문학의 걸작으로, 나폴레옹 전쟁을 배경으로 한 역사적 소설입니다. 이 작품은 전쟁과 그로 인한 사회적 변화, 그리고 인간의 삶을 중심으로 한 대서사시로, 톨스토이는 사실적이고도 심도 깊게 전쟁의 참상과 인간의 삶을 묘사합니다. ‘전쟁과 평화’는 현대 문학에서 중요한 작품으로, 역사와 인간의 본성에 대한 깊은 이해를 제공합니다.'
WHERE bookid = '18';

-- 작품명: 레 미제라블
UPDATE booktbl
SET contents = '‘레 미제라블’은 빅토르 위고 작가의 프랑스 문학의 걸작으로, 프랑스 사회의 불평등과 개인의 구속을 중심으로 한 대서사시입니다. 이 작품은 주인공 장 발잔의 인생과 사회적 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 사회적 불평등과 인간의 구속에 대한 깊은 이해를 제공합니다. ‘레 미제라블’은 현대 문학에서 중요한 작품으로, 사회적 문제와 인간의 구속에 대한 깊은 통찰을 제시합니다.'
WHERE bookid = '19';

-- 작품명: 오만과 편견
UPDATE booktbl
SET contents = '‘오만과 편견’은 제인 오스틴 작가의 영국 문학의 대표작으로, 19세기 영국 사회의 결혼과 계급 문제를 중심으로 한 소설입니다. 이 작품은 주인공 엘리자베스 베넷과 미스터 다아시의 복잡한 감정과 갈등을 사실적이고도 유머러스하게 묘사하며, 독자들에게 영국 사회의 문제와 인간 관계에 대한 깊은 이해를 제공합니다. ‘오만과 편견’은 현대 문학에서 중요한 작품으로, 결혼과 계급 문제에 대한 깊은 통찰을 제시합니다.'
WHERE bookid = '20';

-- 작품명: 아무도 미워하지 않는 자의 죽음
UPDATE booktbl
SET contents = '‘아무도 미워하지 않는 자의 죽음’은 하명희 작가의 삶과 죽음의 의미를 탐구한 작품으로, 인간 존재와 그로 인한 갈등을 중심으로 한 소설입니다. 이 작품은 주인공의 복잡한 감정과 존재의 의미를 사실적이고도 심도 깊게 탐구하며, 독자들에게 삶과 죽음에 대한 깊은 이해를 제공합니다. ‘아무도 미워하지 않는 자의 죽음’은 현대 문학에서 중요한 작품으로, 존재와 삶의 의미를 탐구하는 중요한 소설입니다.'
WHERE bookid = '21';

-- 작품명: 한강
UPDATE booktbl
SET contents = '‘한강’은 조정래 작가의 한국 현대사의 축소판으로, 한국 현대사와 그로 인한 사회적 변화를 중심으로 한 대서사시입니다. 이 작품은 한국 현대사의 중요한 사건과 그로 인한 개인의 삶을 사실적이고도 심도 깊게 묘사하며, 독자들에게 한국 현대사와 인간의 삶에 대한 깊은 이해를 제공합니다. ‘한강’은 현대 문학에서 중요한 작품으로, 한국 현대사와 개인의 삶에 대한 깊은 통찰을 제시합니다.'
WHERE bookid = '22';

-- 작품명: 파친코
UPDATE booktbl
SET contents = '‘파친코’는 이민진 작가의 한국 이민자들의 이야기를 담은 소설로, 일본 내 한국 이민자들의 삶과 그로 인한 사회적 갈등을 중심으로 전개됩니다. 이 작품은 이민자들의 고난과 희생, 그리고 그로 인한 사회적 변화와 갈등을 사실적이고도 심도 깊게 묘사하며, 독자들에게 이민자들의 삶과 사회적 문제에 대한 깊은 이해를 제공합니다. ‘파친코’는 현대 문학에서 중요한 작품으로, 이민자들의 삶과 사회적 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '23';

-- 작품명: 세계의 끝 여자친구
UPDATE booktbl
SET contents = '‘세계의 끝 여자친구’는 김연수 작가의 독특한 스타일의 이야기들로 구성된 소설집입니다. 이 작품은 현대인의 감정과 갈등을 다양한 시각에서 탐구하며, 각기 다른 이야기와 인물들을 통해 인간의 내면을 사실적이고도 창의적인 방식으로 묘사합니다. ‘세계의 끝 여자친구’는 현대 문학에서 중요한 작품으로, 인간의 감정과 관계를 탐구하는 독특한 소설집입니다.'
WHERE bookid = '24';

-- 작품명: 당신들의 천국
UPDATE booktbl
SET contents = '‘당신들의 천국’은 이청준 작가의 한국 현대문학의 걸작으로, 현대 한국 사회의 문제와 인간의 갈등을 중심으로 한 소설입니다. 이 작품은 주인공들의 복잡한 감정과 사회적 갈등을 사실적이고도 심도 깊게 탐구하며, 독자들에게 현대 사회와 인간의 본성에 대한 깊은 이해를 제공합니다. ‘당신들의 천국’은 현대 문학에서 중요한 작품으로, 사회적 문제와 인간의 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '25';

-- 작품명: 내 인생의 스프링캠프
UPDATE booktbl
SET contents = '‘내 인생의 스프링캠프’는 정미경 작가의 청소년들의 성장 이야기를 담은 소설로, 청소년기의 다양한 갈등과 성장을 중심으로 전개됩니다. 이 작품은 청소년들의 내적 갈등과 성장을 사실적이고도 감동적으로 묘사하며, 독자들에게 청소년기의 의미와 중요성에 대한 깊은 이해를 제공합니다. ‘내 인생의 스프링캠프’는 현대 문학에서 중요한 작품으로, 청소년기의 성장과 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '26';

-- 작품명: 소금
UPDATE booktbl
SET contents = '‘소금’은 박범신 작가의 현대 사회의 문제를 다룬 작품으로, 현대 사회의 갈등과 인간의 삶을 중심으로 한 소설입니다. 이 작품은 현대 사회의 문제와 인간의 갈등을 사실적이고도 심도 깊게 탐구하며, 독자들에게 현대 사회와 인간의 본성에 대한 깊은 이해를 제공합니다. ‘소금’은 현대 문학에서 중요한 작품으로, 현대 사회의 문제와 인간의 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '27';

-- 작품명: 러브 레플리카
UPDATE booktbl
SET contents = '‘러브 레플리카’는 윤이형 작가의 사랑과 정체성에 대한 탐구를 중심으로 한 소설입니다. 이 작품은 사랑과 인간의 정체성에 대한 복잡한 감정을 사실적이고도 심도 깊게 묘사하며, 독자들에게 사랑과 정체성의 의미에 대한 깊은 이해를 제공합니다. ‘러브 레플리카’는 현대 문학에서 중요한 작품으로, 사랑과 정체성에 대한 깊은 탐구를 제시합니다.'
WHERE bookid = '28';

-- 작품명: 경애의 마음
UPDATE booktbl
SET contents = '‘경애의 마음’은 김금희 작가의 따뜻한 인간미가 느껴지는 작품으로, 인간의 감정과 관계를 중심으로 한 소설입니다. 이 작품은 따뜻하고 감성적인 이야기와 인물들을 통해 인간의 내면을 사실적이고도 감동적으로 묘사하며, 독자들에게 인간 관계와 감정의 깊이에 대한 이해를 제공합니다. ‘경애의 마음’은 현대 문학에서 중요한 작품으로, 인간의 감정과 관계를 탐구하는 중요한 소설입니다.'
WHERE bookid = '29';

-- 작품명: 바리데기
UPDATE booktbl
SET contents = '‘바리데기’는 황석영 작가의 현대 사회의 문제를 다룬 작품으로, 현대 사회의 갈등과 인간의 삶을 중심으로 한 소설입니다. 이 작품은 현대 사회의 문제와 인간의 갈등을 사실적이고도 심도 깊게 탐구하며, 독자들에게 현대 사회와 인간의 본성에 대한 깊은 이해를 제공합니다. ‘바리데기’는 현대 문학에서 중요한 작품으로, 현대 사회의 문제와 인간의 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '30';

-- 작품명: 두근두근 내 인생
UPDATE booktbl
SET contents = '‘두근두근 내 인생’은 김애란 작가의 어린 부모와 아이의 이야기를 담은 소설로, 부모와 자식 간의 복잡한 감정과 갈등을 중심으로 한 이야기입니다. 이 작품은 부모와 자식 간의 다양한 갈등과 감정을 사실적이고도 감동적으로 묘사하며, 독자들에게 부모와 자식 간의 관계에 대한 깊은 이해를 제공합니다. ‘두근두근 내 인생’은 현대 문학에서 중요한 작품으로, 부모와 자식 간의 복잡한 관계를 탐구하는 중요한 소설입니다.'
WHERE bookid = '31';

-- 작품명: 도가니
UPDATE booktbl
SET contents = '‘도가니’는 공지영 작가의 한국 사회의 어두운 면을 조명한 소설로, 사회적 부조리와 갈등을 중심으로 한 이야기입니다. 이 작품은 한국 사회의 문제와 인간의 갈등을 사실적이고도 심도 깊게 탐구하며, 독자들에게 한국 사회와 인간의 본성에 대한 깊은 이해를 제공합니다. ‘도가니’는 현대 문학에서 중요한 작품으로, 한국 사회의 문제와 인간의 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '32';

-- 작품명: 푸른 밤을 날아서
UPDATE booktbl
SET contents = '‘푸른 밤을 날아서’는 김수영 작가의 감성적이고 철학적인 시집으로, 현대인의 감정과 존재를 탐구하는 시들이 담겨 있습니다. 이 작품은 시인의 감성과 철학적 사유를 사실적이고도 깊이 있는 방식으로 묘사하며, 독자들에게 감정과 존재에 대한 깊은 이해를 제공합니다. ‘푸른 밤을 날아서’는 현대 시에서 중요한 작품으로, 감성과 철학적 사유를 탐구하는 중요한 시집입니다.'
WHERE bookid = '33';

-- 작품명: 소년이 온다
UPDATE booktbl
SET contents = '‘소년이 온다’는 한강 작가의 5.18 광주민주화운동을 배경으로 한 작품으로, 역사적 사건과 그로 인한 개인의 삶을 중심으로 한 이야기입니다. 이 작품은 5.18 광주민주화운동의 참상과 그로 인한 개인의 고통을 사실적이고도 감동적으로 묘사하며, 독자들에게 한국 현대사의 중요한 사건과 그로 인한 개인의 삶에 대한 깊은 이해를 제공합니다. ‘소년이 온다’는 현대 문학에서 중요한 작품으로, 한국 현대사의 중요한 사건과 개인의 삶을 탐구하는 중요한 소설입니다.'
WHERE bookid = '34';

-- 작품명: 젊은 날의 초상
UPDATE booktbl
SET contents = '‘젊은 날의 초상’은 이문열 작가의 한국 현대문학의 정수로, 젊은이들의 삶과 갈등을 중심으로 한 소설입니다. 이 작품은 주인공들의 복잡한 감정과 사회적 갈등을 사실적이고도 심도 깊게 탐구하며, 독자들에게 한국 현대 사회와 인간의 본성에 대한 깊은 이해를 제공합니다. ‘젊은 날의 초상’은 현대 문학에서 중요한 작품으로, 젊은이들의 삶과 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '35';

-- 작품명: 뇌
UPDATE booktbl
SET contents = '‘뇌’는 베르나르 베르베르 작가의 프랑스 SF 소설의 대표작으로, 뇌와 인식의 문제를 중심으로 한 과학적 상상력을 담은 이야기입니다. 이 작품은 뇌의 기능과 인간 인식의 문제를 사실적이고도 상상력 넘치는 방식으로 탐구하며, 독자들에게 뇌와 인식에 대한 깊은 이해를 제공합니다. ‘뇌’는 현대 SF에서 중요한 작품으로, 뇌와 인식에 대한 과학적 상상력을 제시합니다.'
WHERE bookid = '36';

-- 작품명: 연금술사
UPDATE booktbl
SET contents = '‘연금술사’는 파울로 코엘료 작가의 세계적으로 사랑받는 철학적 소설로, 개인의 꿈과 자기 발견을 중심으로 한 이야기입니다. 이 작품은 주인공의 꿈과 자아 발견을 사실적이고도 철학적인 방식으로 묘사하며, 독자들에게 꿈과 자기 발견에 대한 깊은 이해를 제공합니다. ‘연금술사’는 현대 문학에서 중요한 작품으로, 꿈과 자아 발견에 대한 깊은 통찰을 제시합니다.'
WHERE bookid = '37';

-- 작품명: 앵무새 죽이기
UPDATE booktbl
SET contents = '‘앵무새 죽이기’는 하퍼 리 작가의 미국 문학의 고전으로, 인종 차별과 정의를 중심으로 한 소설입니다. 이 작품은 미국 남부의 인종 차별 문제와 그로 인한 개인의 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 인종 차별과 정의에 대한 깊은 이해를 제공합니다. ‘앵무새 죽이기’는 현대 문학에서 중요한 작품으로, 인종 차별과 정의의 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '38';

-- 작품명: 개인적인 체험
UPDATE booktbl
SET contents = '‘개인적인 체험’은 오에 겐자부로 작가의 노벨 문학상 수상작으로, 개인의 내면과 사회적 갈등을 중심으로 한 이야기입니다. 이 작품은 주인공의 내적 갈등과 사회적 문제를 사실적이고도 심도 깊게 탐구하며, 독자들에게 개인의 내면과 사회적 갈등에 대한 깊은 이해를 제공합니다. ‘개인적인 체험’은 현대 문학에서 중요한 작품으로, 개인의 내면과 사회적 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '39';

-- 작품명: 동물농장
UPDATE booktbl
SET contents = '‘동물농장’은 조지 오웰 작가의 정치적 풍자 문학의 대표작으로, 전체주의와 권력의 문제를 중심으로 한 이야기입니다. 이 작품은 동물들의 혁명과 그로 인한 권력의 부패를 사실적이고도 유머러스하게 묘사하며, 독자들에게 전체주의와 권력에 대한 깊은 이해를 제공합니다. ‘동물농장’은 현대 문학에서 중요한 작품으로, 전체주의와 권력의 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '40';

-- 작품명: 사랑의 묘약
UPDATE booktbl
SET contents = '‘사랑의 묘약’은 가브리엘 가르시아 마르케스 작가의 감성적인 로맨스를 다룬 작품으로, 사랑과 시간의 관계를 탐구하는 이야기입니다. 이 소설은 마법적 현실주의를 통해 사랑의 본질과 인간 존재의 의미를 깊이 있게 묘사하며, 주인공들이 겪는 감정의 갈등과 상실을 사실적이고도 감동적으로 표현합니다. ‘사랑의 묘약’은 현대 문학에서 사랑과 시간에 대한 철학적이고도 감성적인 탐구를 제시하는 중요한 작품입니다.'
WHERE bookid = '41';

-- 작품명: 율리시스
UPDATE booktbl
SET contents = '‘율리시스’는 제임스 조이스 작가의 복잡한 구조와 상징으로 가득한 대작으로, 20세기 문학의 중요한 전환점을 형성한 작품입니다. 이 소설은 주인공 리오폴드 블룸의 하루를 중심으로 현대 도시와 인간 심리를 심도 깊게 탐구하며, 다양한 문학적 기법과 실험을 통해 독자들에게 새로운 문학적 경험을 제공합니다. ‘율리시스’는 현대 문학에서 중요한 작품으로, 복잡한 내러티브와 상징을 통해 인간 존재와 인식의 문제를 탐구합니다.'
WHERE bookid = '42';

-- 작품명: 시녀 이야기
UPDATE booktbl
SET contents = '‘시녀 이야기’는 마거릿 애트우드 작가의 현대 여성문제에 대한 강렬한 서사를 담은 작품으로, 디스토피아적 사회에서 여성의 억압과 저항을 중심으로 한 이야기입니다. 이 소설은 가혹한 사회적 규범과 억압 속에서도 개인의 자유와 존엄성을 지키려는 여성들의 싸움을 사실적이고도 심도 깊게 묘사하며, 독자들에게 현대 사회에서의 권력과 성 차별에 대한 강력한 메시지를 전달합니다. ‘시녀 이야기’는 현대 문학에서 여성문제와 권력 구조에 대한 중요한 탐구를 제시합니다.'
WHERE bookid = '43';

-- 작품명: 군주론
UPDATE booktbl
SET contents = '‘군주론’은 니콜로 마키아벨리 작가의 실용적 정치학의 기초를 다진 작품으로, 권력의 본질과 정치적 권모술수를 탐구하는 이론서입니다. 이 작품은 정치적 권력의 유지와 확장을 위한 전략과 전술을 사실적이고도 분석적인 방식으로 제시하며, 역사적 사례를 통해 정치적 권력의 본질과 행태를 분석합니다. ‘군주론’은 현대 정치학과 철학에 큰 영향을 미친 고전적인 작품으로, 정치적 권력과 국가의 역할에 대한 깊은 통찰을 제공합니다.'
WHERE bookid = '44';

-- 작품명: 변신
UPDATE booktbl
SET contents = '‘변신’은 프란츠 카프카 작가의 현대 문학의 고전으로, 인간의 부조리와 실존적 위기를 중심으로 한 이야기입니다. 이 소설은 주인공 그레고르 잠자가 불가사의한 곤충으로 변하는 과정을 통해 인간 존재의 의미와 사회적 관계의 본질을 탐구하며, 독자들에게 인간의 실존적 고통과 사회적 소외를 깊이 있는 방식으로 전달합니다. ‘변신’은 현대 문학에서 중요한 작품으로, 부조리와 인간 실존에 대한 심도 깊은 고찰을 제시합니다.'
WHERE bookid = '45';

-- 작품명: 월든
UPDATE booktbl
SET contents = '‘월든’은 헨리 데이비드 소로 작가의 자연주의 문학의 걸작으로, 자연과 단순한 삶에 대한 깊은 사유를 담고 있는 에세이입니다. 이 작품은 소로가 자연 속에서의 자급자족적인 삶을 통해 얻은 철학적 통찰과 삶의 의미를 탐구하며, 독자들에게 자연과 인간의 본성에 대한 깊은 이해를 제공합니다. ‘월든’은 현대 자연주의 문학에서 중요한 작품으로, 자연과 단순한 삶의 중요성을 강조하는 독창적인 사유를 제시합니다.'
WHERE bookid = '46';

-- 작품명: 이방인
UPDATE booktbl
SET contents = '‘이방인’은 알베르 카뮈 작가의 부조리와 인간 실존에 대한 고찰을 담은 작품으로, 주인공 뫼르소의 내적 갈등과 사회적 소외를 중심으로 한 이야기입니다. 이 소설은 인간 존재의 무의미성과 부조리를 사실적이고도 철학적인 방식으로 묘사하며, 독자들에게 인간의 실존적 고통과 사회적 규범의 모순에 대한 깊은 이해를 제공합니다. ‘이방인’은 현대 문학에서 중요한 작품으로, 인간 실존과 부조리의 문제를 탐구하는 중요한 소설입니다.'
WHERE bookid = '47';

-- 작품명: 안드로이드는 전기양의 꿈을 꾸는가?
UPDATE booktbl
SET contents = '‘안드로이드는 전기양의 꿈을 꾸는가?’는 필립 K. 딕 작가의 SF 문학의 대표작으로, 인간과 기계의 경계를 탐구하는 이야기입니다. 이 소설은 안드로이드와 인간의 본질적 차이와 정체성 문제를 중심으로 한 복잡한 상상력을 통해, 미래 사회의 윤리적, 존재론적 문제를 심도 깊게 탐구합니다. ‘안드로이드는 전기양의 꿈을 꾸는가?’는 현대 SF 문학에서 중요한 작품으로, 인간과 기계의 경계에 대한 깊은 사유를 제시합니다.'
WHERE bookid = '48';

-- 작품명: 폭풍의 언덕
UPDATE booktbl
SET contents = '‘폭풍의 언덕’은 에밀리 브론테 작가의 고전 로맨스의 대표작으로, 복잡한 감정과 갈등을 중심으로 한 드라마틱한 이야기입니다. 이 소설은 주인공 히스클리프와 캐서린의 격렬한 사랑과 그로 인한 갈등을 사실적이고도 강렬하게 묘사하며, 독자들에게 인간의 감정과 복수에 대한 깊은 이해를 제공합니다. ‘폭풍의 언덕’은 현대 문학에서 중요한 작품으로, 복잡한 감정과 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '49';

-- 작품명: 두 도시 이야기
UPDATE booktbl
SET contents = '‘두 도시 이야기’는 찰스 디킨스 작가의 역사와 인간의 드라마를 그린 소설로, 프랑스 대혁명 시기의 사건을 중심으로 한 이야기입니다. 이 소설은 역사적 배경과 인물들의 개인적 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 역사적 사건과 인간의 복잡한 감정을 깊이 이해할 수 있는 기회를 제공합니다. ‘두 도시 이야기’는 현대 문학에서 중요한 작품으로, 역사와 인간 드라마를 탐구하는 중요한 소설입니다.'
WHERE bookid = '50';

-- 작품명: 죄와 벌
UPDATE booktbl
SET contents = '‘죄와 벌’은 도스토옙스키 작가의 러시아 문학의 거장으로, 인간의 도덕적 갈등과 구속을 중심으로 한 이야기입니다. 이 소설은 주인공 라스콜니코프의 범죄와 그로 인한 내적 갈등을 사실적이고도 심도 깊게 묘사하며, 독자들에게 인간의 도덕적 갈등과 구속에 대한 깊은 이해를 제공합니다. ‘죄와 벌’은 현대 문학에서 중요한 작품으로, 인간의 도덕적 갈등과 심리적 고뇌를 탐구하는 중요한 소설입니다.'
WHERE bookid = '51';

-- 작품명: 안나 카레니나
UPDATE booktbl
SET contents = '‘안나 카레니나’는 레프 톨스토이 작가의 러시아 문학의 걸작으로, 사랑과 사회적 갈등을 중심으로 한 드라마틱한 이야기입니다. 이 소설은 주인공 안나와 그 주변 인물들의 복잡한 감정과 사회적 문제를 사실적이고도 심도 깊게 묘사하며, 독자들에게 사랑과 사회적 갈등에 대한 깊은 이해를 제공합니다. ‘안나 카레니나’는 현대 문학에서 중요한 작품으로, 사랑과 사회적 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '52';

-- 작품명: 제인 에어
UPDATE booktbl
SET contents = '‘제인 에어’는 샬럿 브론테 작가의 영국 문학의 고전으로, 자아 찾기와 사회적 갈등을 중심으로 한 이야기입니다. 이 소설은 주인공 제인 에어의 성장과 자아 실현을 중심으로 한 복잡한 감정과 사회적 문제를 사실적이고도 감동적으로 묘사하며, 독자들에게 개인의 자아와 사회적 갈등에 대한 깊은 이해를 제공합니다. ‘제인 에어’는 현대 문학에서 중요한 작품으로, 자아 찾기와 사회적 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '53';

-- 작품명: 등대로
UPDATE booktbl
SET contents = '‘등대로’는 버지니아 울프 작가의 시간과 의식의 흐름을 탐구한 소설로, 현대 문학에서 중요한 위치를 차지하는 작품입니다. 이 소설은 주인공들의 내적 갈등과 그들의 의식의 흐름을 실험적인 문체로 탐구하며, 독자들에게 인간 의식의 복잡성과 시간의 본질에 대한 깊은 통찰을 제공합니다. ‘등대로’는 현대 문학에서 중요한 작품으로, 시간과 의식의 흐름을 탐구하는 중요한 소설입니다.'
WHERE bookid = '54';

-- 작품명: 브리짓 존스의 일기
UPDATE booktbl
SET contents = '‘브리짓 존스의 일기’는 헬렌 필딩 작가의 일기 형식으로 쓰인 소설로, 현대 여성의 일상과 감정을 중심으로 한 이야기입니다. 이 소설은 주인공 브리짓 존스의 개인적인 고민과 일상적인 사건들을 유머러스하게 묘사하며, 독자들에게 현대 여성의 삶과 감정에 대한 공감과 이해를 제공합니다. ‘브리짓 존스의 일기’는 현대 문학에서 중요한 작품으로, 일상적인 여성의 삶을 탐구하는 중요한 소설입니다.'
WHERE bookid = '55';

-- 작품명: 샤이닝
UPDATE booktbl
SET contents = '‘샤이닝’은 스티븐 킹 작가의 현대 공포 문학의 대표작으로, 가족과 정신적 갈등을 중심으로 한 공포 이야기입니다. 이 소설은 한 가족이 외딴 호텔에서 겪는 심리적 공포와 괴물 같은 존재의 위협을 사실적이고도 긴장감 넘치게 묘사하며, 독자들에게 공포와 인간 심리에 대한 깊은 이해를 제공합니다. ‘샤이닝’은 현대 문학에서 중요한 작품으로, 공포와 심리적 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '56';

-- 작품명: 어스시의 마법사
UPDATE booktbl
SET contents = '‘어스시의 마법사’는 어슐러 K. 르귄 작가의 마법과 모험의 세계를 그린 작품으로, 상상력과 철학적 탐구를 중심으로 한 이야기입니다. 이 소설은 주인공의 마법적 여정과 그 과정에서의 성장을 사실적이고도 감동적으로 묘사하며, 독자들에게 상상력과 인간 본성에 대한 깊은 이해를 제공합니다. ‘어스시의 마법사’는 현대 문학에서 중요한 작품으로, 마법과 모험의 세계를 탐구하는 중요한 소설입니다.'
WHERE bookid = '57';

-- 작품명: 지킬 박사와 하이드
UPDATE booktbl
SET contents = '‘지킬 박사와 하이드’는 로버트 루이스 스티븐슨 작가의 고전 스릴러로, 인간의 이중성과 도덕적 갈등을 중심으로 한 이야기입니다. 이 소설은 주인공 지킬 박사가 자신의 내면의 악과 싸우는 과정을 사실적이고도 긴장감 넘치게 묘사하며, 독자들에게 인간의 이중성과 도덕적 갈등에 대한 깊은 이해를 제공합니다. ‘지킬 박사와 하이드’는 현대 문학에서 중요한 작품으로, 인간의 이중성과 도덕적 갈등을 탐구하는 중요한 소설입니다.'
WHERE bookid = '58';

-- 작품명: 작가를 위한 문장 쓰기
UPDATE booktbl
SET contents = '‘작가를 위한 문장 쓰기’는 레몽 크노 작가의 프랑스 문학의 독특한 작품으로, 작가의 창작 과정과 문장 작성에 대한 통찰을 담고 있습니다. 이 소설은 작가로서의 경험과 문장 작성의 기술을 사실적이고도 심도 깊게 탐구하며, 독자들에게 창작 과정과 문장 작성의 중요성에 대한 깊은 이해를 제공합니다. ‘작가를 위한 문장 쓰기’는 현대 문학에서 중요한 작품으로, 작가의 창작 과정과 문장 작성에 대한 중요한 통찰을 제시합니다.'
WHERE bookid = '59';

-- 작품명: 파리의 노트르담
UPDATE booktbl
SET contents = '‘파리의 노트르담’은 제임스 볼드윈 작가의 인간의 존엄성과 자유를 탐구한 소설로, 사회적 갈등과 개인적 고난을 중심으로 한 이야기입니다. 이 소설은 주인공의 삶과 그로 인한 사회적 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 인간의 존엄성과 자유에 대한 깊은 이해를 제공합니다. ‘파리의 노트르담’은 현대 문학에서 중요한 작품으로, 인간의 존엄성과 자유를 탐구하는 중요한 소설입니다.'
WHERE bookid = '60';

-- 작품명: 호밀밭의 파수꾼
UPDATE booktbl
SET contents = '‘호밀밭의 파수꾼’은 제롬 데이비드 샐린저 작가의 미국 문학의 고전으로, 청소년의 고뇌와 사회적 소외를 중심으로 한 이야기입니다. 이 소설은 주인공 홀든 콜필드의 내적 갈등과 사회적 소외를 사실적이고도 심도 깊게 묘사하며, 독자들에게 청소년의 감정과 사회적 갈등에 대한 깊은 이해를 제공합니다. ‘호밀밭의 파수꾼’은 현대 문학에서 중요한 작품으로, 청소년의 고뇌와 사회적 소외를 탐구하는 중요한 소설입니다.'
WHERE bookid = '61';

-- 작품명: 샨타라
UPDATE booktbl
SET contents = '‘샨타라’는 제임스 미치너 작가의 인도 역사의 드라마를 그린 소설로, 역사적 사건과 개인적 이야기를 중심으로 한 복잡한 서사입니다. 이 소설은 인도의 역사적 변천과 그 속에서의 개인의 삶을 사실적이고도 감동적으로 묘사하며, 독자들에게 인도 역사의 중요성과 개인의 삶에 대한 깊은 이해를 제공합니다. ‘샨타라’는 현대 문학에서 중요한 작품으로, 역사와 인간 드라마를 탐구하는 중요한 소설입니다.'
WHERE bookid = '62';

-- 작품명: 주홍글씨
UPDATE booktbl
SET contents = '‘주홍글씨’는 나사니엘 호손 작가의 미국 문학의 고전으로, 죄와 사회적 규범을 중심으로 한 이야기입니다. 이 소설은 주인공 헤스터 프린이 죄를 짓고 사회적 규범과 갈등하는 과정을 사실적이고도 심도 깊게 묘사하며, 독자들에게 죄와 사회적 규범에 대한 깊은 이해를 제공합니다. ‘주홍글씨’는 현대 문학에서 중요한 작품으로, 죄와 사회적 규범을 탐구하는 중요한 소설입니다.'
WHERE bookid = '63';

-- 작품명: 종의 기원
UPDATE booktbl
SET contents = '‘종의 기원’은 찰스 다윈 작가의 과학 혁명의 상징적인 작품으로, 자연선택 이론을 중심으로 한 이론서입니다. 이 소설은 종의 기원과 진화의 과정에 대한 깊이 있는 이론을 사실적이고도 분석적인 방식으로 제시하며, 독자들에게 자연선택 이론과 생물학적 진화에 대한 깊은 이해를 제공합니다. ‘종의 기원’은 현대 과학에서 중요한 작품으로, 진화와 자연선택 이론에 대한 중요한 통찰을 제시합니다.'
WHERE bookid = '64';

-- 작품명: 몽테크리스토 백작
UPDATE booktbl
SET contents = '‘몽테크리스토 백작’은 알렉상드르 뒤마 작가의 프랑스 문학의 대표작으로, 복수와 구속을 중심으로 한 드라마틱한 이야기입니다. 이 소설은 주인공 에드몽 단테스의 복수와 그로 인한 전개를 사실적이고도 긴장감 넘치게 묘사하며, 독자들에게 복수와 구속의 중요성에 대한 깊은 이해를 제공합니다. ‘몽테크리스토 백작’은 현대 문학에서 중요한 작품으로, 복수와 구속을 탐구하는 중요한 소설입니다.'
WHERE bookid = '65';

-- 작품명: 나나
UPDATE booktbl
SET contents = '‘나나’는 에밀 졸라 작가의 프랑스 자연주의 문학의 걸작으로, 사회적 부조리와 인간의 나락을 중심으로 한 이야기입니다. 이 소설은 주인공 나나의 타락과 사회적 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 사회적 부조리와 인간의 나락에 대한 깊은 이해를 제공합니다. ‘나나’는 현대 문학에서 중요한 작품으로, 사회적 부조리와 인간의 나락을 탐구하는 중요한 소설입니다.'
WHERE bookid = '66';

-- 작품명: 보바리 부인
UPDATE booktbl
SET contents = '‘보바리 부인’은 귀스타브 플로베르 작가의 프랑스 문학의 걸작으로, 개인적 갈망과 사회적 기대 사이의 갈등을 중심으로 한 이야기입니다. 이 소설은 주인공 에마 보바리의 개인적 갈망과 그로 인한 갈등을 사실적이고도 심도 깊게 묘사하며, 독자들에게 개인적 갈망과 사회적 기대에 대한 깊은 이해를 제공합니다. ‘보바리 부인’은 현대 문학에서 중요한 작품으로, 개인적 갈망과 사회적 기대를 탐구하는 중요한 소설입니다.'
WHERE bookid = '67';

-- 작품명: 기적을 이룬 사람들
UPDATE booktbl
SET contents = '‘기적을 이룬 사람들’은 발터 슈바이커트 작가의 현대 경영학의 고전으로, 성공적인 경영 사례와 그에 대한 통찰을 담고 있습니다. 이 소설은 경영의 원칙과 성공적인 사례를 사실적이고도 분석적으로 제시하며, 독자들에게 현대 경영학에 대한 깊은 이해를 제공합니다. ‘기적을 이룬 사람들’은 현대 경영학에서 중요한 작품으로, 성공적인 경영 사례와 통찰을 제시합니다.'
WHERE bookid = '68';

-- 작품명: 노트북
UPDATE booktbl
SET contents = '‘노트북’은 니콜라스 스파크스 작가의 현대 로맨스의 대표작으로, 사랑과 인연을 중심으로 한 감동적인 이야기입니다. 이 소설은 주인공들의 사랑과 인연을 사실적이고도 감동적으로 묘사하며, 독자들에게 사랑과 인간 관계의 중요성에 대한 깊은 이해를 제공합니다. ‘노트북’은 현대 문학에서 중요한 작품으로, 사랑과 인연을 탐구하는 중요한 소설입니다.'
WHERE bookid = '69';

-- 작품명: 검은 고양이
UPDATE booktbl
SET contents = '‘검은 고양이’는 에드가 앨런 포 작가의 미국 문학의 고전으로, 공포와 인간 심리를 중심으로 한 이야기입니다. 이 소설은 주인공의 심리적 고뇌와 공포를 사실적이고도 긴장감 넘치게 묘사하며, 독자들에게 공포와 인간 심리에 대한 깊은 이해를 제공합니다. ‘검은 고양이’는 현대 문학에서 중요한 작품으로, 공포와 인간 심리를 탐구하는 중요한 소설입니다.'
WHERE bookid = '70';

-- 작품명: 테스
UPDATE booktbl
SET contents = '‘테스’는 토머스 하디 작가의 영국 문학의 대표작으로, 여성의 운명과 사회적 억압을 중심으로 한 이야기입니다. 이 소설은 주인공 테스의 개인적 비극과 사회적 억압을 사실적이고도 감동적으로 묘사하며, 독자들에게 여성의 운명과 사회적 억압에 대한 깊은 이해를 제공합니다. ‘테스’는 현대 문학에서 중요한 작품으로, 여성의 운명과 사회적 억압을 탐구하는 중요한 소설입니다.'
WHERE bookid = '71';

-- 작품명: 피의 결혼
UPDATE booktbl
SET contents = '‘피의 결혼’은 가르시아 로르카 작가의 스페인 문학의 걸작으로, 결혼과 사회적 억압을 중심으로 한 이야기입니다. 이 소설은 주인공의 결혼과 그로 인한 사회적 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 결혼과 사회적 억압에 대한 깊은 이해를 제공합니다. ‘피의 결혼’은 현대 문학에서 중요한 작품으로, 결혼과 사회적 억압을 탐구하는 중요한 소설입니다.'
WHERE bookid = '72';

-- 작품명: 인형의 집
UPDATE booktbl
SET contents = '‘인형의 집’은 헨리크 입센 작가의 현대 연극의 고전으로, 가정과 사회적 규범을 중심으로 한 이야기입니다. 이 소설은 주인공의 가정 내 갈등과 사회적 규범을 사실적이고도 심도 깊게 묘사하며, 독자들에게 가정과 사회적 규범에 대한 깊은 이해를 제공합니다. ‘인형의 집’은 현대 연극에서 중요한 작품으로, 가정과 사회적 규범을 탐구하는 중요한 소설입니다.'
WHERE bookid = '73';

-- 작품명: 파우스트
UPDATE booktbl
SET contents = '‘파우스트’는 요한 볼프강 폰 괴테 작가의 독일 문학의 거장으로, 인간의 욕망과 구속을 중심으로 한 드라마틱한 이야기입니다. 이 소설은 주인공 파우스트의 욕망과 그로 인한 갈등을 사실적이고도 심도 깊게 묘사하며, 독자들에게 인간의 욕망과 구속에 대한 깊은 이해를 제공합니다. ‘파우스트’는 현대 문학에서 중요한 작품으로, 인간의 욕망과 구속을 탐구하는 중요한 소설입니다.'
WHERE bookid = '74';

-- 작품명: 이상한 나라의 앨리스
UPDATE booktbl
SET contents = '‘이상한 나라의 앨리스’는 루이스 캐럴 작가의 영국 아동문학의 걸작으로, 상상력과 모험을 중심으로 한 이야기입니다. 이 소설은 주인공 앨리스의 이상한 나라에서의 모험을 사실적이고도 흥미롭게 묘사하며, 독자들에게 상상력과 모험의 즐거움을 제공합니다. ‘이상한 나라의 앨리스’는 현대 문학에서 중요한 작품으로, 상상력과 모험을 탐구하는 중요한 소설입니다.'
WHERE bookid = '75';

-- 작품명: 오베라는 남자
UPDATE booktbl
SET contents = '‘오베라는 남자’는 프레드릭 백만 작가의 스웨덴 문학의 대표작으로, 삶과 죽음, 그리고 인생의 의미를 중심으로 한 이야기입니다. 이 소설은 주인공 오베의 삶과 그로 인한 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 삶과 죽음에 대한 깊은 이해를 제공합니다. ‘오베라는 남자’는 현대 문학에서 중요한 작품으로, 삶과 죽음, 인생의 의미를 탐구하는 중요한 소설입니다.'
WHERE bookid = '76';

-- 작품명: 미래의 역사
UPDATE booktbl
SET contents = '‘미래의 역사’는 하랄드 슈미트 작가의 미래에 대한 깊이 있는 고찰을 담은 작품으로, 미래 사회와 인간의 진화에 대한 이론을 중심으로 한 이야기입니다. 이 소설은 미래 사회의 변화와 인간의 진화를 사실적이고도 분석적으로 탐구하며, 독자들에게 미래 사회와 인간의 진화에 대한 깊은 통찰을 제공합니다. ‘미래의 역사’는 현대 문학에서 중요한 작품으로, 미래 사회와 인간의 진화를 탐구하는 중요한 소설입니다.'
WHERE bookid = '77';

-- 작품명: 부활
UPDATE booktbl
SET contents = '‘부활’은 레프 톨스토이 작가의 러시아 문학의 거장으로, 인간의 구속과 윤리를 중심으로 한 이야기입니다. 이 소설은 주인공의 구속과 그로 인한 갈등을 사실적이고도 감동적으로 묘사하며, 독자들에게 인간의 구속과 윤리에 대한 깊은 이해를 제공합니다. ‘부활’은 현대 문학에서 중요한 작품으로, 인간의 구속과 윤리를 탐구하는 중요한 소설입니다.'
WHERE bookid = '78';

-- 작품명: 잃어버린 시간을 찾아서
UPDATE booktbl
SET contents = '‘잃어버린 시간을 찾아서’는 마르셀 프루스트 작가의 프랑스 문학의 걸작으로, 시간과 기억을 중심으로 한 복잡한 서사입니다. 이 소설은 주인공의 시간과 기억을 탐구하며, 사실적이고도 심도 깊은 방식으로 시간의 본질을 묘사합니다. ‘잃어버린 시간을 찾아서’는 현대 문학에서 중요한 작품으로, 시간과 기억을 탐구하는 중요한 소설입니다.'
WHERE bookid = '79';

-- 작품명: 좁은 문
UPDATE booktbl
SET contents = '‘좁은 문’은 앙드레 지드 작가의 프랑스 문학의 고전으로, 개인의 자유와 사회적 기대를 중심으로 한 이야기입니다. 이 소설은 주인공의 개인적 갈망과 사회적 기대 사이의 갈등을 사실적이고도 심도 깊게 묘사하며, 독자들에게 개인의 자유와 사회적 기대에 대한 깊은 이해를 제공합니다. ‘좁은 문’은 현대 문학에서 중요한 작품으로, 개인의 자유와 사회적 기대를 탐구하는 중요한 소설입니다.'
WHERE bookid = '80';


-- 작품명: 보트 위의 세 남자
UPDATE booktbl
SET contents = '‘보트 위의 세 남자’는 제롬 K. 제롬 작가의 유머 소설로, 세 명의 남자가 보트 여행을 떠나는 이야기입니다. 이 소설은 여행 중 겪는 다양한 에피소드와 함께 인간의 심리를 유머러스하게 탐구하며, 독자들에게 웃음을 주는 동시에 인간 관계와 생활의 진솔한 측면을 보여줍니다. ‘보트 위의 세 남자’는 영국 문학에서 중요한 유머 작품으로, 인생의 소소한 즐거움과 인간 본성을 탐구하는 중요한 소설입니다.'
WHERE bookid = '81';

-- 작품명: 태양은 가득히
UPDATE booktbl
SET contents = '‘태양은 가득히’는 로맹 가리 작가의 프랑스 문학의 걸작으로, 인간 존재의 의미와 삶의 진정성을 탐구하는 소설입니다. 이 소설은 주인공의 내면적인 갈등과 그로 인한 인간 존재의 의미를 사실적이고도 깊이 있게 묘사하며, 독자들에게 삶과 존재에 대한 깊은 통찰을 제공합니다. ‘태양은 가득히’는 현대 문학에서 중요한 작품으로, 인간 존재와 삶의 진정성을 탐구하는 중요한 소설입니다.'
WHERE bookid = '82';

-- 작품명: 사랑의 기술
UPDATE booktbl
SET contents = '‘사랑의 기술’은 에리히 프롬 작가의 현대 심리학의 고전으로, 사랑의 본질과 그것을 실천하는 방법을 탐구하는 작품입니다. 이 소설은 사랑의 다양한 형태와 그것이 인간 관계에 미치는 영향을 심리학적 관점에서 분석하며, 독자들에게 사랑의 기술과 그 실천의 중요성을 강조합니다. ‘사랑의 기술’은 현대 심리학에서 중요한 작품으로, 사랑의 본질과 실천에 대한 깊은 이해를 제공합니다.'
WHERE bookid = '83';

-- 작품명: 국가
UPDATE booktbl
SET contents = '‘국가’는 플라톤 작가의 서양 철학의 기초를 다진 작품으로, 이상적인 국가와 정의에 대한 철학적 고찰을 담고 있습니다. 이 소설은 국가의 구조와 정의의 본질을 탐구하며, 철학적 논의를 통해 인간 사회의 이상적인 형태를 제시합니다. ‘국가’는 서양 철학에서 중요한 작품으로, 국가와 정의에 대한 깊은 이해를 제공합니다.'
WHERE bookid = '84';

-- 작품명: 사회계약론
UPDATE booktbl
SET contents = '‘사회계약론’은 장자크 루소 작가의 현대 민주주의의 기초 이론을 제시하는 작품으로, 사회 계약과 정부의 정당성에 대한 철학적 논의를 담고 있습니다. 이 소설은 개인의 자유와 평등, 사회적 계약의 중요성을 강조하며, 현대 민주주의의 이론적 기반을 제공합니다. ‘사회계약론’은 현대 정치철학에서 중요한 작품으로, 민주주의와 사회 계약에 대한 깊은 통찰을 제공합니다.'
WHERE bookid = '85';

-- 작품명: 구토
UPDATE booktbl
SET contents = '‘구토’는 장폴 사르트르 작가의 존재와 자유에 대한 철학적 소설로, 인간 존재의 무의미성과 자유에 대한 고찰을 담고 있습니다. 이 소설은 주인공의 내면적 고뇌와 존재의 의미를 탐구하며, 실존주의 철학의 핵심 개념들을 심도 깊게 다룹니다. ‘구토’는 현대 철학에서 중요한 작품으로, 존재와 자유에 대한 깊은 이해를 제공합니다.'
WHERE bookid = '86';

-- 작품명: 고백록
UPDATE booktbl
SET contents = '‘고백록’은 아우구스티누스 작가의 서양 철학과 신학의 고전으로, 자신의 죄와 구속에 대한 개인적 고백을 담고 있습니다. 이 작품은 신의 은혜와 인간의 죄, 그리고 구속의 과정을 철학적이고 신학적인 시각에서 탐구하며, 독자들에게 신앙과 구속의 깊은 의미를 전달합니다. ‘고백록’은 서양 철학과 신학에서 중요한 작품으로, 인간의 죄와 신의 구속에 대한 깊은 이해를 제공합니다.'
WHERE bookid = '87';









UPDATE booktbl
SET contentsTables = '1. 서문
2. 한국 현대문학의 발전
   2.1. 한국 현대문학의 역사적 배경
   2.2. 주요 작가와 작품
3. 문학적 흐름과 변화
   3.1. 현대 문학의 흐름
   3.2. 주요 문학 장르의 발전
4. 대표 작품 분석
   4.1. 작가와 작품의 분석
   4.2. 문학적 기법과 주제
5. 현대문학의 미래
   5.1. 현대문학의 과제와 전망
   5.2. 독자와 문학의 관계
6. 결론'
WHERE bookid = '1';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 조선의 역사와 사회
   2.1. 조선시대의 역사적 배경
   2.2. 주요 역사적 인물
3. 제2부: 태백산맥의 시대
   3.1. 주요 사건과 배경
   3.2. 주요 인물과 그들의 역할
4. 제3부: 역사와 문학의 만남
   4.1. 문학적 표현과 역사적 사실
   4.2. 문학적 상상력과 현실
5. 결론'
WHERE bookid = '2';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 이야기의 전개
   2.1. 첫 번째 이야기
   2.2. 두 번째 이야기
3. 제2부: 감정과 관계
   3.1. 인물 간의 관계
   3.2. 감정의 변화와 흐름
4. 제3부: 현대 사회의 반영
   4.1. 사회적 문제와 반영
   4.2. 문학적 기법과 주제
5. 결론'
WHERE bookid = '3';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 가족의 이야기
   2.1. 가족 구성원의 소개
   2.2. 주요 사건과 갈등
3. 제2부: 사회적 배경
   3.1. 한국 사회의 변화
   3.2. 가족과 사회의 관계
4. 제3부: 문학적 분석
   4.1. 문학적 기법과 주제
   4.2. 사회적 의미와 상징
5. 결론'
WHERE bookid = '4';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 전쟁의 배경
   2.1. 한국 전쟁의 역사적 배경
   2.2. 주요 인물과 사건
3. 제2부: 전쟁의 전개
   3.1. 주요 전투와 사건
   3.2. 인물의 갈등과 역할
4. 제3부: 전쟁의 여파
   4.1. 전쟁 후 사회와 개인의 변화
   4.2. 문학적 해석과 의미
5. 결론'
WHERE bookid = '5';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 에세이의 세계
   2.1. 에세이란 무엇인가
   2.2. 주요 에세이의 분석
3. 제2부: 사랑과 삶
   3.1. 사랑의 의미와 표현
   3.2. 삶의 다양한 측면
4. 제3부: 문학적 기법
   4.1. 에세이에서의 문학적 기법
   4.2. 개인적 경험과 문학적 표현
5. 결론'
WHERE bookid = '6';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 현대 여성의 이야기
   2.1. 여성의 역할과 사회적 위치
   2.2. 주요 인물과 사건
3. 제2부: 일상의 도전
   3.1. 여성의 일상과 도전
   3.2. 사회적 반응과 변화
4. 제3부: 사회적 메시지
   4.1. 사회적 의미와 영향
   4.2. 문학적 기법과 표현
5. 결론'
WHERE bookid = '7';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 인간 내면의 폭력
   2.1. 폭력의 정의와 특성
   2.2. 주요 인물과 사건
3. 제2부: 심리적 갈등
   3.1. 인물의 심리적 갈등
   3.2. 갈등의 전개와 해결
4. 제3부: 문학적 분석
   4.1. 문학적 기법과 상징
   4.2. 작품의 사회적 의미
5. 결론'
WHERE bookid = '8';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 인간의 심리 탐구
   2.1. 심리적 갈등의 구조
   2.2. 주요 인물의 심리 분석
3. 제2부: 사건의 전개
   3.1. 주요 사건과 갈등
   3.2. 갈등의 심화와 해결
4. 제3부: 결말과 해석
   4.1. 결말의 의미와 해석
   4.2. 작품의 사회적 메시지
5. 결론'
WHERE bookid = '9';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 제1부: 이순신 장군의 생애
   2.1. 출생과 초기 생애
   2.2. 주요 전투와 전쟁
3. 제2부: 전쟁의 전개
   3.1. 해전의 전략과 전술
   3.2. 전투의 결과와 영향
4. 제3부: 유산과 평가
   4.1. 역사적 평가
   4.2. 후대의 기억과 영향
5. 결론'
WHERE bookid = '10';

UPDATE booktbl
SET contentsTables = '1. 개미의 탄생
2. 개미의 세계
3. 개미의 사회 구조
4. 개미의 생태계
5. 개미의 행동과 커뮤니케이션
6. 개미의 식생활
7. 개미의 진화
8. 개미와 인간
9. 개미의 생존 전략
10. 개미의 미래
'
WHERE bookid = '11';

UPDATE booktbl
SET contentsTables = '1. 태백산맥의 역사
2. 태백산맥의 자연
3. 태백산맥의 인간과 사회
4. 태백산맥의 전통과 문화
5. 태백산맥의 경제와 산업
6. 태백산맥의 전쟁과 갈등
7. 태백산맥의 인물들
8. 태백산맥의 민속과 신화
9. 태백산맥의 현대와 미래
10. 태백산맥의 문학적 표현
'
WHERE bookid = '12';

UPDATE booktbl
SET contentsTables = '1. 사랑과 상실
2. 삶의 의미
3. 가족과 관계
4. 기억과 잃어버린 시간
5. 개인적 성장
6. 사회적 배경
7. 인간의 감정
8. 인간의 고뇌
9. 인물 간의 갈등
10. 결말과 해답
'
WHERE bookid = '13';

UPDATE booktbl
SET contentsTables = '1. 엄마의 기억
2. 엄마의 사랑
3. 가족의 역사
4. 가족의 갈등
5. 가족의 희망
6. 개인적 성장
7. 사회적 문제
8. 인물 간의 관계
9. 현대 사회의 변화
10. 결말과 반성
'
WHERE bookid = '14';

UPDATE booktbl
SET contentsTables = '1. 전쟁의 서막
2. 전쟁의 여파
3. 전쟁의 인물들
4. 전쟁의 전투와 전략
5. 전쟁의 사회적 변화
6. 전쟁의 경제적 영향
7. 전쟁의 문화적 영향
8. 전쟁의 기억
9. 전쟁 후의 삶
10. 전쟁의 교훈
'
WHERE bookid = '15';

UPDATE booktbl
SET contentsTables = '1. 삶의 의미
2. 사랑의 본질
3. 인간의 관계
4. 사회와 인간
5. 감정의 표현
6. 개인적 경험
7. 인간의 가치
8. 사회적 기대
9. 사랑의 도전
10. 삶의 목적
'
WHERE bookid = '16';

UPDATE booktbl
SET contentsTables = '1. 마술과 현실
2. 신비로운 이야기
3. 사랑과 상실
4. 인간의 본성
5. 인물의 갈등
6. 사회적 비판
7. 상상력의 한계
8. 문학적 기법
9. 결말의 의미
10. 작품의 영향
'
WHERE bookid = '17';

UPDATE booktbl
SET contentsTables = '1. 전쟁의 배경
2. 전쟁의 주요 사건
3. 전쟁의 주요 인물
4. 전쟁의 사회적 변화
5. 전쟁의 정치적 영향
6. 전쟁의 경제적 영향
7. 전쟁의 문화적 영향
8. 전쟁의 인물 간의 관계
9. 전쟁 후의 삶
10. 전쟁의 교훈
'
WHERE bookid = '18';

UPDATE booktbl
SET contentsTables = '1. 혁명의 배경
2. 혁명의 주요 사건
3. 혁명의 주요 인물
4. 혁명의 사회적 변화
5. 혁명의 정치적 영향
6. 혁명의 경제적 영향
7. 혁명의 문화적 영향
8. 혁명의 인물 간의 관계
9. 혁명 후의 사회
10. 혁명의 교훈
'
WHERE bookid = '19';

UPDATE booktbl
SET contentsTables = '1. 사랑의 이야기
2. 사회적 갈등
3. 인간의 감정
4. 개인적 성장
5. 인물 간의 관계
6. 사회적 변화
7. 감정의 표현
8. 사랑의 도전
9. 결말의 의미
10. 작품의 영향
'
WHERE bookid = '20';


-- Update for bookid 21 to 30

UPDATE booktbl
SET contentsTables = '1. 서문
2. 삶과 죽음의 의미
3. 미완의 꿈
4. 인간 존재의 본질
5. 고독의 형상
6. 인생의 마무리
7. 애도와 희망
8. 자기 정체성 찾기
9. 윤리적 고민
10. 사회적 압박
11. 죽음을 맞이하는 자세
12. 감정의 범위
13. 인간의 약점
14. 사회의 기대
15. 사랑의 다양한 형태
16. 존재의 의미
17. 개인의 자유
18. 인생의 기로
19. 인간의 내면
20. 사회적 역할의 해석'
WHERE bookid = 21;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 한국 현대사 개관
3. 한강의 역사
4. 현대 한국의 사회상
5. 전통과 현대의 충돌
6. 문화의 변화
7. 한국 사회의 이면
8. 현대 사회의 상징
9. 국가와 개인
10. 사회적 갈등
11. 역사적 인물
12. 경제적 변화
13. 한국의 정치
14. 사회적 문제와 해결
15. 현대 한국의 가치관
16. 역사적 사건의 분석
17. 문학과 역사
18. 사회적 책임
19. 문화적 정체성
20. 미래의 전망'
WHERE bookid = 22;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 파친코의 역사
3. 이민자의 삶
4. 사회적 배경
5. 가족의 의미
6. 정체성의 갈등
7. 문화적 차이
8. 역사적 사건
9. 경제적 문제
10. 인물의 삶
11. 이민자의 도전
12. 사회적 지위
13. 문학적 표현
14. 문화적 상징
15. 현대 한국 사회
16. 가족의 변화
17. 사회적 압박
18. 개인의 꿈
19. 이민의 경험
20. 미래의 전망'
WHERE bookid = 23;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 이야기의 시작
3. 인물의 소개
4. 주요 사건
5. 갈등의 전개
6. 감정의 흐름
7. 이야기의 전환
8. 주요 테마
9. 인물 간의 관계
10. 중요한 사건
11. 감정의 변화
12. 갈등의 해소
13. 이야기의 결말
14. 인물의 성장
15. 사회적 메시지
16. 문학적 기법
17. 이야기의 해석
18. 주요 장면 분석
19. 서사적 구성
20. 작품의 의미'
WHERE bookid = 24;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 한국 현대문학의 발전
3. 주요 작가 소개
4. 문학적 흐름
5. 작품의 특징
6. 사회적 배경
7. 주요 작품 분석
8. 문학적 기법
9. 인물의 성격
10. 주제와 상징
11. 역사적 맥락
12. 문학적 영향
13. 작가의 비전
14. 현대 사회의 반영
15. 독자와의 소통
16. 작품의 기법
17. 현대문학의 장르
18. 문학적 평가
19. 작가의 기여
20. 문학의 미래'
WHERE bookid = 25;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 청소년의 성장
3. 주요 인물 소개
4. 이야기의 배경
5. 가족의 역할
6. 사회적 도전
7. 인물의 갈등
8. 주요 사건
9. 감정의 전개
10. 사회적 메시지
11. 개인의 성장
12. 이야기의 흐름
13. 갈등의 해결
14. 문학적 기법
15. 작품의 주제
16. 독자와의 관계
17. 인물의 발전
18. 작품의 의미
19. 이야기의 결말
20. 현대 사회의 반영'
WHERE bookid = 26;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 현대 사회의 문제
3. 주요 이슈
4. 사회적 갈등
5. 인물의 문제
6. 현대 사회의 변화
7. 사회적 압박
8. 개인의 고난
9. 이야기의 전개
10. 주요 사건
11. 사회적 메시지
12. 문학적 기법
13. 인물 간의 갈등
14. 문제 해결의 접근
15. 감정의 변화
16. 현대 사회의 문제점
17. 이야기의 해석
18. 사회적 책임
19. 작품의 주제
20. 미래의 전망'
WHERE bookid = 27;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 사랑의 탐구
3. 정체성의 탐색
4. 주요 인물 소개
5. 감정의 흐름
6. 이야기의 전개
7. 갈등의 분석
8. 문학적 기법
9. 주요 사건
10. 감정의 변화
11. 이야기의 구조
12. 인물의 관계
13. 사회적 메시지
14. 개인의 경험
15. 이야기의 결말
16. 작품의 주제
17. 문학적 해석
18. 독자와의 소통
19. 주요 장면 분석
20. 작품의 의미'
WHERE bookid = 28;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 현대 사회의 문제
3. 주요 사건
4. 인물의 성격
5. 사회적 갈등
6. 이야기의 흐름
7. 주요 테마
8. 문학적 기법
9. 감정의 전개
10. 이야기의 전환
11. 인물 간의 갈등
12. 사회적 메시지
13. 작품의 주제
14. 갈등의 해결
15. 현대 사회의 반영
16. 독자와의 관계
17. 이야기의 결말
18. 주요 장면 분석
19. 문학적 기법
20. 작품의 의미'
WHERE bookid = 29;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 어린 부모와 아이
3. 주요 사건
4. 가족의 의미
5. 인물의 성격
6. 감정의 전개
7. 이야기의 흐름
8. 갈등의 분석
9. 문학적 기법
10. 주요 테마
11. 이야기의 전환
12. 사회적 메시지
13. 인물 간의 관계
14. 이야기의 결말
15. 작품의 주제
16. 독자와의 소통
17. 작품의 의미
18. 주요 장면 분석
19. 문학적 해석
20. 미래의 전망'
WHERE bookid = 30;

UPDATE booktbl
SET contentsTables = '1. 서문
2. 어린 시절
3. 첫 만남
4. 학교 생활
5. 새로운 시작
6. 사랑과 우정
7. 부모와의 관계
8. 갈등과 해결
9. 성년의 길
10. 결혼과 가족
11. 사회적 역할
12. 직업과 커리어
13. 인생의 전환점
14. 인생의 의미
15. 미래의 계획
16. 주요 사건들
17. 인물 소개
18. 참고문헌
19. 색인
20. 부록'
WHERE bookid = '31';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 사건 개요
3. 배경 설명
4. 주요 등장인물
5. 갈등의 시작
6. 중반부의 전개
7. 주요 사건
8. 갈등의 해결
9. 결말
10. 주제 분석
11. 사회적 의미
12. 역사적 배경
13. 저자의 의도
14. 주요 장면 분석
15. 인물 분석
16. 상징과 메타포
17. 비교 문헌
18. 참고 문헌
19. 색인
20. 부록'
WHERE bookid = '32';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 시의 개요
3. 주제 및 분석
4. 첫 번째 장: XX
5. 두 번째 장: XX
6. 세 번째 장: XX
7. 네 번째 장: XX
8. 감정 표현
9. 상징과 이미지
10. 문학적 기법
11. 시적 언어
12. 현대적 해석
13. 저자 소개
14. 비평과 분석
15. 관련 연구
16. 색인
17. 참고문헌
18. 부록
19. 시인의 연대기
20. 인터뷰 및 논평'
WHERE bookid = '33';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 배경 설명
3. 주요 인물
4. 5.18의 시작
5. 전개 과정
6. 주요 사건
7. 사회적 반응
8. 개인적 이야기
9. 갈등의 해결
10. 결말
11. 역사적 의미
12. 저자의 의도
13. 문학적 기법
14. 주제 분석
15. 사회적 영향
16. 비평 및 리뷰
17. 참고 문헌
18. 색인
19. 부록
20. 관련 자료'
WHERE bookid = '34';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 인물 소개
3. 제1부: XX
4. 제2부: XX
5. 제3부: XX
6. 제4부: XX
7. 제5부: XX
8. 주요 사건
9. 갈등과 해결
10. 결말
11. 주제와 상징
12. 문학적 기법
13. 사회적 맥락
14. 작가의 의도
15. 비평 및 리뷰
16. 참고 문헌
17. 색인
18. 부록
19. 작가의 연대기
20. 추가 자료'
WHERE bookid = '35';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 개념 소개
3. 과학적 배경
4. 제1부: XX
5. 제2부: XX
6. 제3부: XX
7. 제4부: XX
8. 주요 논의
9. 연구 결과
10. 미래 전망
11. 핵심 질문
12. 실험과 사례
13. 비판적 논의
14. 저자의 의도
15. 관련 연구
16. 참고 문헌
17. 색인
18. 부록
19. 추가 자료
20. 요약 및 결론'
WHERE bookid = '36';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 주제 소개
3. 주요 인물
4. 제1부: XX
5. 제2부: XX
6. 제3부: XX
7. 제4부: XX
8. 제5부: XX
9. 결말
10. 주제와 상징
11. 문학적 기법
12. 사회적 맥락
13. 작가의 의도
14. 비평 및 리뷰
15. 참고 문헌
16. 색인
17. 부록
18. 작가의 연대기
19. 추가 자료
20. 인터뷰 및 논평'
WHERE bookid = '37';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 시대 배경
3. 주요 인물
4. 제1부: XX
5. 제2부: XX
6. 제3부: XX
7. 제4부: XX
8. 제5부: XX
9. 주요 사건
10. 갈등과 해결
11. 주제 분석
12. 작가의 의도
13. 문학적 기법
14. 비평 및 리뷰
15. 참고 문헌
16. 색인
17. 부록
18. 작가의 연대기
19. 추가 자료
20. 인터뷰 및 논평'
WHERE bookid = '38';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 주요 인물
3. 제1부: XX
4. 제2부: XX
5. 제3부: XX
6. 제4부: XX
7. 제5부: XX
8. 제6부: XX
9. 주요 사건
10. 갈등과 해결
11. 주제 분석
12. 문학적 기법
13. 작가의 의도
14. 비평 및 리뷰
15. 참고 문헌
16. 색인
17. 부록
18. 작가의 연대기
19. 추가 자료
20. 인터뷰 및 논평'
WHERE bookid = '39';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 배경 설명
3. 주요 인물
4. 제1부: XX
5. 제2부: XX
6. 제3부: XX
7. 제4부: XX
8. 제5부: XX
9. 제6부: XX
10. 주요 사건
11. 갈등과 해결
12. 주제와 상징
13. 문학적 기법
14. 작가의 의도
15. 비평 및 리뷰
16. 참고 문헌
17. 색인
18. 부록
19. 작가의 연대기
20. 추가 자료'
WHERE bookid = '40';

-- 업데이트 쿼리
UPDATE booktbl
SET contentsTables = '1. 서문
2. 사랑의 신비
3. 시간의 흐름
4. 기억의 힘
5. 운명의 만남
6. 갈등과 화해
7. 삶의 의미
8. 사랑의 이중성
9. 이별과 회상
10. 마지막 장'
WHERE bookid = '41';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 트로이의 전쟁
3. 오디세우스의 여행
4. 페르세포네의 저주
5. 신들의 계략
6. 크레타의 미궁
7. 이타카로의 귀환
8. 전쟁의 여파
9. 새로운 시대
10. 결론'
WHERE bookid = '42';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 도미니온의 정세
3. 시녀 이야기
4. 권력의 비밀
5. 여권과 정치
6. 권리와 자유
7. 가정의 의미
8. 사회적 구조
9. 저항과 희망
10. 결론'
WHERE bookid = '43';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 군주론의 기초
3. 정치의 원칙
4. 권력의 본질
5. 군주의 역할
6. 국가와 시민
7. 외교와 전쟁
8. 권력의 유지
9. 정치적 음모
10. 결론'
WHERE bookid = '44';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 변신의 서사
3. 존재의 문제
4. 인간의 고뇌
5. 사회적 억압
6. 내면의 갈등
7. 부조리와 실존
8. 새로운 시각
9. 인간성과 문명
10. 결론'
WHERE bookid = '45';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 자연과 인간
3. 자아와 자연
4. 인생의 의미
5. 자아 탐구
6. 자연과의 연결
7. 사회적 고립
8. 영혼의 치유
9. 자아와 사회
10. 결론'
WHERE bookid = '46';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 부조리의 본질
3. 인간 실존의 탐구
4. 사회적 무의미
5. 도덕적 갈등
6. 인간의 선택
7. 죽음과 존재
8. 삶의 의미
9. 자유와 책임
10. 결론'
WHERE bookid = '47';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 안드로이드와 인간
3. 기계와 감정
4. 존재의 경계
5. 인공지능의 윤리
6. 꿈과 현실
7. 기술의 발전
8. 사회적 변화
9. 인간의 본질
10. 결론'
WHERE bookid = '48';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 폭풍의 시작
3. 주인공의 성장
4. 갈등의 전개
5. 사랑과 상실
6. 가족의 비극
7. 전통과 혁신
8. 사회적 갈등
9. 결말의 전환
10. 결론'
WHERE bookid = '49';

UPDATE booktbl
SET contentsTables = '1. 서문
2. 프랑스 혁명
3. 전쟁의 배경
4. 주요 인물들
5. 사회의 변화
6. 인간의 갈등
7. 사랑과 복수
8. 정치적 음모
9. 결말의 전환
10. 결론'
WHERE bookid = '50';


-- 책 ID 51: '죄와 벌' - 도스토옙스키
UPDATE booktbl
SET contentsTables = '1. 도입부, 2. 로딘의 꿈, 3. 사라진 꿈, 4. 공포와 죄책감, 5. 마르멜라도프의 죽음, 6. 수사와 교훈, 7. 리자베타와의 만남, 8. 경찰 조사, 9. 사랑과 희생, 10. 마지막 증거, 11. 법의 심판, 12. 결말과 해방'
WHERE bookid = '51';

-- 책 ID 52: '안나 카레니나' - 레프 톨스토이
UPDATE booktbl
SET contentsTables = '1. 상류 사회의 생활, 2. 안나와 브론스키의 만남, 3. 가정의 위기, 4. 사회적 압박, 5. 사랑과 갈등, 6. 공존의 어려움, 7. 상류 사회의 모순, 8. 결혼과 이혼, 9. 개인의 비극, 10. 종말의 순간, 11. 새로운 시작, 12. 사회의 반응'
WHERE bookid = '52';

-- 책 ID 53: '제인 에어' - 샬럿 브론테
UPDATE booktbl
SET contentsTables = '1. 어린 시절, 2. 로우드 힐 학교, 3. 미스터 로체스터, 4. 사랑의 갈등, 5. 비밀과 거짓, 6. 불행한 결혼, 7. 자아의 발견, 8. 고백과 용서, 9. 로체스터와의 재회, 10. 결혼과 새로운 시작'
WHERE bookid = '53';

-- 책 ID 54: '등대로' - 버지니아 울프
UPDATE booktbl
SET contentsTables = '1. 주제의 도입, 2. 주요 인물의 소개, 3. 시간의 흐름, 4. 사회적 배경, 5. 개인적 갈등, 6. 가족과의 관계, 7. 외부 세계와의 상호작용, 8. 내부의 충돌, 9. 결말의 전개, 10. 성찰과 해방'
WHERE bookid = '54';

-- 책 ID 55: '브리짓 존스의 일기' - 헬렌 필딩
UPDATE booktbl
SET contentsTables = '1. 소개와 일상의 시작, 2. 연애의 시작, 3. 직장 생활과 갈등, 4. 친구와의 관계, 5. 자아 탐색, 6. 연애의 문제, 7. 생활의 혼란, 8. 자아 성장, 9. 결혼과 새 시작, 10. 새로운 삶의 시작'
WHERE bookid = '55';

-- 책 ID 56: '샤이닝' - 스티븐 킹
UPDATE booktbl
SET contentsTables = '1. 오버룩 호텔의 개요, 2. 가족의 도착, 3. 호텔의 비밀, 4. 초자연적 현상, 5. 정신적 갈등, 6. 폭력의 시작, 7. 공포의 심화, 8. 가족의 갈등, 9. 극복의 과정, 10. 결말과 후유증'
WHERE bookid = '56';

-- 책 ID 57: '어스시의 마법사' - 어슐러 K. 르귄
UPDATE booktbl
SET contentsTables = '1. 어스시의 소개, 2. 마법의 학습, 3. 첫 번째 모험, 4. 마법의 비밀, 5. 내면의 갈등, 6. 악의 세력, 7. 친구와의 여정, 8. 대결과 성장, 9. 위기의 순간, 10. 승리와 결말'
WHERE bookid = '57';

-- 책 ID 58: '지킬 박사와 하이드' - 로버트 루이스 스티븐슨
UPDATE booktbl
SET contentsTables = '1. 주인공의 소개, 2. 의문의 사건들, 3. 이중 인격의 시작, 4. 도덕적 갈등, 5. 숨겨진 진실, 6. 변신의 설명, 7. 충격적인 발견, 8. 도덕과 범죄, 9. 결말의 전개, 10. 마지막 순간'
WHERE bookid = '58';

-- 책 ID 59: '작가를 위한 문장 쓰기' - 레몽 크노
UPDATE booktbl
SET contentsTables = '1. 문장의 기초, 2. 작문 기술, 3. 문체의 이해, 4. 창의적 글쓰기, 5. 구조와 구성, 6. 문학적 장치, 7. 표현의 정확성, 8. 독자의 이해, 9. 수정과 교정, 10. 최종 작품 작성'
WHERE bookid = '59';

-- 책 ID 60: '파리의 노트르담' - 제임스 볼드윈
UPDATE booktbl
SET contentsTables = '1. 배경 소개, 2. 주요 인물의 등장, 3. 사회적 갈등, 4. 사랑과 희생, 5. 고난의 연대기, 6. 종교적 영향, 7. 사회적 압박, 8. 개인적 비극, 9. 사회적 변화, 10. 결말과 교훈'
WHERE bookid = '60';

-- Update for bookid 61
UPDATE booktbl
SET contentsTables = '1. 제프리의 어린 시절
2. 호밀밭의 이야기
3. 가족과의 갈등
4. 학교 생활
5. 친구와의 만남
6. 삶의 의미 탐구
7. 성적 혼란
8. 사회와의 단절
9. 성장의 기회
10. 새로운 시작'
WHERE bookid = 61;

-- Update for bookid 62
UPDATE booktbl
SET contentsTables = '1. 어린 시절
2. 가족과의 생활
3. 전통과 문화
4. 역사적 배경
5. 제국과 식민지
6. 인물 소개
7. 경제적 변화
8. 사회적 갈등
9. 전쟁의 그림자
10. 평화와 재건'
WHERE bookid = 62;

-- Update for bookid 63
UPDATE booktbl
SET contentsTables = '1. 홍색 배경
2. 주홍글씨의 상징
3. 주인공의 내면
4. 사회적 압박
5. 죄와 속죄
6. 인간의 본성
7. 도덕적 갈등
8. 사회의 반응
9. 인물의 운명
10. 결말과 교훈'
WHERE bookid = 63;

-- Update for bookid 64
UPDATE booktbl
SET contentsTables = '1. 서문
2. 종의 기원
3. 진화론의 기초
4. 자연선택
5. 변이와 적응
6. 생물학적 다양성
7. 인류의 진화
8. 인간의 기원
9. 과학적 증거
10. 결론'
WHERE bookid = 64;

-- Update for bookid 65
UPDATE booktbl
SET contentsTables = '1. 서문
2. 프랑스 혁명
3. 몽테크리스토 백작
4. 복수와 정의
5. 인물과 사건
6. 권력과 음모
7. 부와 지위
8. 사랑과 배신
9. 결말의 반전
10. 주제와 교훈'
WHERE bookid = 65;

-- Update for bookid 66
UPDATE booktbl
SET contentsTables = '1. 서문
2. 나나의 등장
3. 사회적 배경
4. 인물 소개
5. 도덕적 갈등
6. 성적 자유
7. 사회적 반응
8. 개인의 운명
9. 종말의 예감
10. 결론'
WHERE bookid = 66;

-- Update for bookid 67
UPDATE booktbl
SET contentsTables = '1. 서문
2. 보바리 부인의 소개
3. 사회적 배경
4. 사랑과 불륜
5. 결혼 생활
6. 인물 간의 갈등
7. 사회적 압박
8. 개인의 비극
9. 결말과 교훈
10. 문학적 분석'
WHERE bookid = 67;

-- Update for bookid 68
UPDATE booktbl
SET contentsTables = '1. 서문
2. 경영의 기초
3. 성공 사례
4. 리더십
5. 팀워크와 협력
6. 혁신과 변화
7. 경영 전략
8. 문제 해결
9. 미래의 비전
10. 결론'
WHERE bookid = 68;

-- Update for bookid 69
UPDATE booktbl
SET contentsTables = '1. 서문
2. 주요 인물 소개
3. 사랑의 시작
4. 갈등과 시련
5. 인물 간의 관계
6. 감정의 변화
7. 사랑의 지속
8. 삶의 교훈
9. 결말의 전환
10. 현대 로맨스'
WHERE bookid = 69;

-- Update for bookid 70
UPDATE booktbl
SET contentsTables = '1. 서문
2. 검은 고양이의 등장
3. 주인공의 심리
4. 살인과 범죄
5. 공포의 전개
6. 죄와 결과
7. 내면의 갈등
8. 결말의 충격
9. 상징적 요소
10. 문학적 의미'
WHERE bookid = 70;

-- 71. 영국 문학의 대표작, '테스'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 테스의 출생
3. 테스의 어린 시절
4. 댈톤의 유혹
5. 암암리의 갈등
6. 플러시의 역할
7. 스톤하우스에서
8. 애덤과 이브
9. 진실의 발견
10. 마지막 시험
11. 희생의 결말'
WHERE bookid = '71';

-- 72. 스페인 문학의 걸작, '피의 결혼'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 피의 결혼 배경
3. 초기의 갈등
4. 가족의 비극
5. 사랑과 증오
6. 피의 결혼 준비
7. 결혼식의 시작
8. 갈등의 고조
9. 피의 결말
10. 후일담'
WHERE bookid = '72';

-- 73. 현대 연극의 고전, '인형의 집'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 집안의 평화
3. 첫 번째 갈등
4. 노라의 비밀
5. 폭로와 충격
6. 갈등의 심화
7. 결정적인 선택
8. 해답의 모색
9. 결말의 결정
10. 에필로그'
WHERE bookid = '73';

-- 74. 독일 문학의 거장, '파우스트'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 파우스트의 비극
3. 메피스토펠레스의 계약
4. 인생의 의미 탐구
5. 천사와 악마
6. 사랑과 갈등
7. 파우스트의 구속
8. 자연의 신비
9. 구속의 과정
10. 결말의 심판'
WHERE bookid = '74';

-- 75. 영국 아동문학의 걸작, '이상한 나라의 앨리스'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 앨리스의 발견
3. 토끼굴 속으로
4. 이상한 만남
5. 재판의 시작
6. 마법의 시간
7. 퀸의 명령
8. 잃어버린 친구들
9. 꿈의 끝
10. 현실로의 귀환'
WHERE bookid = '75';

-- 76. 스웨덴 문학의 대표작, '오베라는 남자'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 오베의 일상
3. 과거의 기억
4. 새로운 이웃
5. 관계의 시작
6. 오베의 변화
7. 가족과의 갈등
8. 새로운 이해
9. 사랑과 희망
10. 결말의 해답'
WHERE bookid = '76';

-- 77. 미래에 대한 깊이 있는 고찰, '미래의 역사'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 현재의 분석
3. 미래 사회의 형성
4. 기술의 발전
5. 사회적 변화
6. 윤리적 딜레마
7. 인간의 미래
8. 환경과의 관계
9. 미래의 도전
10. 결론'
WHERE bookid = '77';

-- 78. 러시아 문학의 거장, '부활'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 니콜라이의 이야기
3. 사랑의 시작
4. 사회의 갈등
5. 부활의 과정
6. 사회적 개혁
7. 갈등의 해결
8. 인생의 재발견
9. 희망과 구속
10. 결말'
WHERE bookid = '78';

-- 79. 프랑스 문학의 걸작, '잃어버린 시간을 찾아서'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 기억의 탐구
3. 과거의 재현
4. 시간을 흐름
5. 잃어버린 시간
6. 사랑과 상실
7. 상상의 여정
8. 인간의 본질
9. 회상의 끝
10. 새로운 이해'
WHERE bookid = '79';

-- 80. 프랑스 문학의 고전, '좁은 문'
UPDATE booktbl
SET contentsTables = '1. 서문
2. 주인공의 배경
3. 갈등의 전개
4. 윤리적 딜레마
5. 감정의 갈등
6. 결혼의 문제
7. 도덕적 선택
8. 갈등의 심화
9. 결말의 결정
10. 후일담'
WHERE bookid = '80';

UPDATE booktbl SET contentsTables = '1. 보트 위의 세 남자
2. 제 1장: 여행의 시작
3. 제 2장: 배에서의 생활
4. 제 3장: 사건의 전개
5. 제 4장: 갈등과 유머
6. 제 5장: 교훈과 반성
7. 제 6장: 결말
8. 에필로그
' WHERE bookid = '81';

UPDATE booktbl SET contentsTables = '1. 태양은 가득히
2. 제 1부: 삶과 사랑
3. 제 2부: 고난과 극복
4. 제 3부: 인간의 본성
5. 제 4부: 사회적 갈등
6. 제 5부: 개인의 성찰
7. 제 6부: 결론과 의미
8. 에필로그
' WHERE bookid = '82';

UPDATE booktbl SET contentsTables = '1. 사랑의 기술
2. 서문
3. 제 1부: 사랑의 본질
4. 제 2부: 사랑의 심리학
5. 제 3부: 관계의 발전
6. 제 4부: 현대 사회에서의 사랑
7. 제 5부: 사랑의 도전과 해결
8. 제 6부: 개인적 경험과 교훈
9. 결론
10. 참고 문헌
' WHERE bookid = '83';

UPDATE booktbl SET contentsTables = '1. 국가
2. 서문
3. 제 1권: 정의와 정의의 구조
4. 제 2권: 법과 사회
5. 제 3권: 교육과 지식
6. 제 4권: 정치적 권위와 시민
7. 제 5권: 이상 국가와 현실
8. 결론
9. 참고 문헌
' WHERE bookid = '84';

UPDATE booktbl SET contentsTables = '1. 사회계약론
2. 서문
3. 제 1부: 인간의 본성과 사회
4. 제 2부: 사회 계약의 이론
5. 제 3부: 정부의 역할
6. 제 4부: 개인과 집단의 권리
7. 제 5부: 민주주의와 법
8. 제 6부: 사회 계약의 비판
9. 결론
10. 참고 문헌
' WHERE bookid = '85';

UPDATE booktbl SET contentsTables = '1. 구토
2. 제 1부: 존재와 정체성
3. 제 2부: 현대인의 고뇌
4. 제 3부: 삶의 의미와 부조리
5. 제 4부: 존재의 회의
6. 제 5부: 인간의 자유와 선택
7. 결론
8. 에필로그
' WHERE bookid = '86';

UPDATE booktbl SET contentsTables = '1. 고백록
2. 제 1권: 인간의 내면
3. 제 2권: 신과의 관계
4. 제 3권: 회개와 구원
5. 제 4권: 신의 뜻과 인간의 자유
6. 제 5권: 철학적 성찰
7. 결론
8. 에필로그
' WHERE bookid = '87';

-- booktbl 테이블에 페이지 수 추가
-- '우리들의 일그러진 영웅' (bookid 1)의 페이지 수를 304로 설정
UPDATE booktbl
SET pages = 304
WHERE bookid = 1;

-- '태백산맥' (bookid 2)의 페이지 수를 1232로 설정
UPDATE booktbl
SET pages = 1232
WHERE bookid = 2;

-- '오직 두 사람' (bookid 3)의 페이지 수를 368로 설정
UPDATE booktbl
SET pages = 368
WHERE bookid = 3;

-- '엄마를 부탁해' (bookid 4)의 페이지 수를 248로 설정
UPDATE booktbl
SET pages = 248
WHERE bookid = 4;

-- '나목' (bookid 5)의 페이지 수를 352로 설정
UPDATE booktbl
SET pages = 352
WHERE bookid = 5;

-- '언어의 온도' (bookid 6)의 페이지 수를 216로 설정
UPDATE booktbl
SET pages = 216
WHERE bookid = 6;

-- '82년생 김지영' (bookid 7)의 페이지 수를 224로 설정
UPDATE booktbl
SET pages = 224
WHERE bookid = 7;

-- '채식주의자' (bookid 8)의 페이지 수를 188로 설정
UPDATE booktbl
SET pages = 188
WHERE bookid = 8;

-- '7년의 밤' (bookid 9)의 페이지 수를 488로 설정
UPDATE booktbl
SET pages = 488
WHERE bookid = 9;

-- '칼의 노래' (bookid 10)의 페이지 수를 688로 설정
UPDATE booktbl
SET pages = 688
WHERE bookid = 10;

-- '개미' (bookid 11)의 페이지 수를 400으로 설정
UPDATE booktbl
SET pages = 400
WHERE bookid = 11;

-- '1Q84' (bookid 12)의 페이지 수를 928로 설정
UPDATE booktbl
SET pages = 928
WHERE bookid = 12;

-- '나를 보내지 마' (bookid 13)의 페이지 수를 352로 설정
UPDATE booktbl
SET pages = 352
WHERE bookid = 13;

-- '데미안' (bookid 14)의 페이지 수를 176로 설정
UPDATE booktbl
SET pages = 176
WHERE bookid = 14;

-- '1984' (bookid 15)의 페이지 수를 328로 설정
UPDATE booktbl
SET pages = 328
WHERE bookid = 15;

-- '노인과 바다' (bookid 16)의 페이지 수를 128로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 16;

-- '백년의 고독' (bookid 17)의 페이지 수를 448로 설정
UPDATE booktbl
SET pages = 448
WHERE bookid = 17;

-- '전쟁과 평화' (bookid 18)의 페이지 수를 1224로 설정
UPDATE booktbl
SET pages = 1224
WHERE bookid = 18;

-- '레 미제라블' (bookid 19)의 페이지 수를 1232로 설정
UPDATE booktbl
SET pages = 1232
WHERE bookid = 19;

-- '오만과 편견' (bookid 20)의 페이지 수를 416로 설정
UPDATE booktbl
SET pages = 416
WHERE bookid = 20;

-- '아무도 미워하지 않는 자의 죽음' (bookid 21)의 페이지 수를 232로 설정
UPDATE booktbl
SET pages = 232
WHERE bookid = 21;

-- '한강' (bookid 22)의 페이지 수를 224로 설정
UPDATE booktbl
SET pages = 224
WHERE bookid = 22;

-- '파친코' (bookid 23)의 페이지 수를 496로 설정
UPDATE booktbl
SET pages = 496
WHERE bookid = 23;

-- '세계의 끝 여자친구' (bookid 24)의 페이지 수를 272로 설정
UPDATE booktbl
SET pages = 272
WHERE bookid = 24;

-- '당신들의 천국' (bookid 25)의 페이지 수를 328로 설정
UPDATE booktbl
SET pages = 328
WHERE bookid = 25;

-- '내 인생의 스프링캠프' (bookid 26)의 페이지 수를 320으로 설정
UPDATE booktbl
SET pages = 320
WHERE bookid = 26;

-- '소금' (bookid 27)의 페이지 수를 208로 설정
UPDATE booktbl
SET pages = 208
WHERE bookid = 27;

-- '러브 레플리카' (bookid 28)의 페이지 수를 256으로 설정
UPDATE booktbl
SET pages = 256
WHERE bookid = 28;

-- '경애의 마음' (bookid 29)의 페이지 수를 360으로 설정
UPDATE booktbl
SET pages = 360
WHERE bookid = 29;

-- '바리데기' (bookid 30)의 페이지 수를 336으로 설정
UPDATE booktbl
SET pages = 336
WHERE bookid = 30;

-- '두근두근 내 인생' (bookid 31)의 페이지 수를 240으로 설정
UPDATE booktbl
SET pages = 240
WHERE bookid = 31;

-- '도가니' (bookid 32)의 페이지 수를 256으로 설정
UPDATE booktbl
SET pages = 256
WHERE bookid = 32;

-- '푸른 밤을 날아서' (bookid 33)의 페이지 수를 192로 설정
UPDATE booktbl
SET pages = 192
WHERE bookid = 33;

-- '소년이 온다' (bookid 34)의 페이지 수를 224로 설정
UPDATE booktbl
SET pages = 224
WHERE bookid = 34;

-- '젊은 날의 초상' (bookid 35)의 페이지 수를 320으로 설정
UPDATE booktbl
SET pages = 320
WHERE bookid = 35;

-- '뇌' (bookid 36)의 페이지 수를 304로 설정
UPDATE booktbl
SET pages = 304
WHERE bookid = 36;

-- '연금술사' (bookid 37)의 페이지 수를 208으로 설정
UPDATE booktbl
SET pages = 208
WHERE bookid = 37;

-- '앵무새 죽이기' (bookid 38)의 페이지 수를 336으로 설정
UPDATE booktbl
SET pages = 336
WHERE bookid = 38;

-- '개인적인 체험' (bookid 39)의 페이지 수를 192로 설정
UPDATE booktbl
SET pages = 192
WHERE bookid = 39;

-- '동물농장' (bookid 40)의 페이지 수를 128으로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 40;

-- '사랑의 묘약' (bookid 41)의 페이지 수를 256으로 설정
UPDATE booktbl
SET pages = 256
WHERE bookid = 41;

-- '율리시스' (bookid 42)의 페이지 수를 736으로 설정
UPDATE booktbl
SET pages = 736
WHERE bookid = 42;

-- '시녀 이야기' (bookid 43)의 페이지 수를 336으로 설정
UPDATE booktbl
SET pages = 336
WHERE bookid = 43;

-- '군주론' (bookid 44)의 페이지 수를 104로 설정
UPDATE booktbl
SET pages = 104
WHERE bookid = 44;

-- '변신' (bookid 45)의 페이지 수를 128로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 45;

-- '월든' (bookid 46)의 페이지 수를 336으로 설정
UPDATE booktbl
SET pages = 336
WHERE bookid = 46;

-- '이방인' (bookid 47)의 페이지 수를 128로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 47;

-- '안드로이드는 전기양의 꿈을 꾸는가?' (bookid 48)의 페이지 수를 256으로 설정
UPDATE booktbl
SET pages = 256
WHERE bookid = 48;

-- '폭풍의 언덕' (bookid 49)의 페이지 수를 416으로 설정
UPDATE booktbl
SET pages = 416
WHERE bookid = 49;

-- '두 도시 이야기' (bookid 50)의 페이지 수를 448으로 설정
UPDATE booktbl
SET pages = 448
WHERE bookid = 50;

-- '죄와 벌' (bookid 51)의 페이지 수를 672로 설정
UPDATE booktbl
SET pages = 672
WHERE bookid = 51;

-- '안나 카레니나' (bookid 52)의 페이지 수를 864로 설정
UPDATE booktbl
SET pages = 864
WHERE bookid = 52;

-- '제인 에어' (bookid 53)의 페이지 수를 448으로 설정
UPDATE booktbl
SET pages = 448
WHERE bookid = 53;

-- '등대로' (bookid 54)의 페이지 수를 448로 설정
UPDATE booktbl
SET pages = 448
WHERE bookid = 54;

-- '브리짓 존스의 일기' (bookid 55)의 페이지 수를 352로 설정
UPDATE booktbl
SET pages = 352
WHERE bookid = 55;

-- '샤이닝' (bookid 56)의 페이지 수를 688으로 설정
UPDATE booktbl
SET pages = 688
WHERE bookid = 56;

-- '어스시의 마법사' (bookid 57)의 페이지 수를 256으로 설정
UPDATE booktbl
SET pages = 256
WHERE bookid = 57;

-- '지킬 박사와 하이드' (bookid 58)의 페이지 수를 128으로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 58;

-- '작가를 위한 문장 쓰기' (bookid 59)의 페이지 수를 256으로 설정
UPDATE booktbl
SET pages = 256
WHERE bookid = 59;

-- '파리의 노트르담' (bookid 60)의 페이지 수를 464로 설정
UPDATE booktbl
SET pages = 464
WHERE bookid = 60;

-- '호밀밭의 파수꾼' (bookid 61)의 페이지 수를 277로 설정
UPDATE booktbl
SET pages = 277
WHERE bookid = 61;

-- '샨타라' (bookid 62)의 페이지 수를 432로 설정
UPDATE booktbl
SET pages = 432
WHERE bookid = 62;

-- '주홍글씨' (bookid 63)의 페이지 수를 288으로 설정
UPDATE booktbl
SET pages = 288
WHERE bookid = 63;

-- '종의 기원' (bookid 64)의 페이지 수를 416으로 설정
UPDATE booktbl
SET pages = 416
WHERE bookid = 64;

-- '몽테크리스토 백작' (bookid 65)의 페이지 수를 1272으로 설정
UPDATE booktbl
SET pages = 1272
WHERE bookid = 65;

-- '나나' (bookid 66)의 페이지 수를 432으로 설정
UPDATE booktbl
SET pages = 432
WHERE bookid = 66;

-- '보바리 부인' (bookid 67)의 페이지 수를 456으로 설정
UPDATE booktbl
SET pages = 456
WHERE bookid = 67;

-- '기적을 이룬 사람들' (bookid 68)의 페이지 수를 352로 설정
UPDATE booktbl
SET pages = 352
WHERE bookid = 68;

-- '노트북' (bookid 69)의 페이지 수를 208으로 설정
UPDATE booktbl
SET pages = 208
WHERE bookid = 69;

-- '검은 고양이' (bookid 70)의 페이지 수를 128으로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 70;

-- '테스' (bookid 71)의 페이지 수를 464으로 설정
UPDATE booktbl
SET pages = 464
WHERE bookid = 71;

-- '피의 결혼' (bookid 72)의 페이지 수를 232으로 설정
UPDATE booktbl
SET pages = 232
WHERE bookid = 72;

-- '인형의 집' (bookid 73)의 페이지 수를 128으로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 73;

-- '파우스트' (bookid 74)의 페이지 수를 464으로 설정
UPDATE booktbl
SET pages = 464
WHERE bookid = 74;

-- '이상한 나라의 앨리스' (bookid 75)의 페이지 수를 128으로 설정
UPDATE booktbl
SET pages = 128
WHERE bookid = 75;

-- '오베라는 남자' (bookid 76)의 페이지 수를 368으로 설정
UPDATE booktbl
SET pages = 368
WHERE bookid = 76;

-- '미래의 역사' (bookid 77)의 페이지 수를 352으로 설정
UPDATE booktbl
SET pages = 352
WHERE bookid = 77;

-- '부활' (bookid 78)의 페이지 수를 624로 설정
UPDATE booktbl
SET pages = 624
WHERE bookid = 78;

-- '잃어버린 시간을 찾아서' (bookid 79)의 페이지 수를 4200으로 설정
UPDATE booktbl
SET pages = 4200
WHERE bookid = 79;

-- '좁은 문' (bookid 80)의 페이지 수를 208으로 설정
UPDATE booktbl
SET pages = 208
WHERE bookid = 80;

-- '보트 위의 세 남자' (bookid 81)의 페이지 수를 160으로 설정
UPDATE booktbl
SET pages = 160
WHERE bookid = 81;

-- '태양은 가득히' (bookid 82)의 페이지 수를 248으로 설정
UPDATE booktbl
SET pages = 248
WHERE bookid = 82;

-- '사랑의 기술' (bookid 83)의 페이지 수를 368으로 설정
UPDATE booktbl
SET pages = 368
WHERE bookid = 83;

-- '국가' (bookid 84)의 페이지 수를 104으로 설정
UPDATE booktbl
SET pages = 104
WHERE bookid = 84;

-- '사회계약론' (bookid 85)의 페이지 수를 232으로 설정
UPDATE booktbl
SET pages = 232
WHERE bookid = 85;

-- '구토' (bookid 86)의 페이지 수를 208으로 설정
UPDATE booktbl
SET pages = 208
WHERE bookid = 86;

-- '고백록' (bookid 87)의 페이지 수를 416으로 설정
UPDATE booktbl
SET pages = 416
WHERE bookid = 87;






