<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aside</title>
<script defer src="https://kit.fontawesome.com/9ad59cd5cc.js" crossorigin="anonymous"></script>
</head>
<body>

	<aside>

		<i class="fa-solid fa-magnifying-glass on"></i>
		<i class="fa-regular fa-circle-xmark"></i>

		<div class="searchAPIFrame">

			<form name="bookSearchAPIFrm" autocomplete="off">
				<input type="text" name="bookSearchAPI" />
				<button type="submit">네이버 검색</button>
			</form>

			<ul class="APISearchedList">
				
			</ul>

		</div>

	</aside>
	
	<script>

		const addSearchedListItemAPI = (data)=>{
			const $APISearchedList = document.querySelector('.searchAPIFrame>.APISearchedList');

			// 리스트 중첩 방지를 위해 렌더링 전에 리스트 요소 초기화
			const $APIsearchedListItems = document.querySelectorAll('.APISearchedList>li');
			for(let i=0;i<$APIsearchedListItems.length;i++) {
				$APISearchedList.removeChild($APIsearchedListItems[i]);
			}

			/*데이터 양식 ex
			{
				"lastBuildDate": "Mon, 23 Sep 2024 23:36:48 +0900",
				"total": 199,
				"start": 1,
				"display": 5,
				"items": [
					{
						"title": "삶으로 다시 떠오르기 (자유 영혼을 위한 톨레와의 대화)",
						"link": "https://search.shopping.naver.com/book/catalog/32490259594",
						"image": "https://shopping-phinf.pstatic.net/main_3249025/32490259594.20240203070902.jpg",
						"author": "에크하르트 톨레",
						"discount": "18000",
						"publisher": "연금술사",
						"pubdate": "20240201",
						"isbn": "9791195026128",
						"description": "지금, 에고와 결별을 선언한다!\n\n『삶으로 다시 떠오르기』는 새롭게 떠오르는 영성가이며 21세기의 영적 교사로 일컬어지는 에크하르트 톨레의 더 나은 삶, 더 나은 세계를 위한 지침서이다. 톨레의 저서들은 생각과 감정을 자신이라고 여기는 인간의 근본적인 착각을 다룬 명저로 꼽힌다. ‘에고에 바탕을 둔 삶’과 그러한 삶들이 모인 세상에서 살고 있지만 그 에고가 모든 인간관계에 문제를 일으키고 실체를 보는 것을 가로막는 장애물임을 알려주며, 그리고 그것이 인간 존재의 전부가 아니라고 강조한다. \n\n이 책은 일화와 철학적 내용을 통해 모든 고통과 불행의 원인인 ‘자기 자신’이라는 감옥에서 나와 ‘나는 누구인지’를 깨닫고 진정한 삶으로 다시 떠오르는 길을 제시한다. 류시화가 1차 재번역, 일본어 번역본과의 대조 번역, 2차 재번역 등의 과정을 거치며 심혈을 기울인 책으로, 이 책을 주제로 오프라 윈프리와 함께 10주에 걸쳐 스카이프를 통한 인터넷 온라인 독자 참여를 가진 바 있다. ‘허구의 나’를 자신이라고 믿는 마음이 개인과 사회를 불행에 이르게 한다는 톨레의 통찰을 만나볼 수 있다.\n\n▶ 이 책은 2008년에 출간된 ≪NOW: 행성의 미래를 상상하는 사람들에게≫(조화로운삶)의 개정판입니다."
					},
					{
						"title": "연금술사 (파울로 코엘료 장편소설)",
						"link": "https://search.shopping.naver.com/book/catalog/32441623802",
						"image": "https://shopping-phinf.pstatic.net/main_3244162/32441623802.20230926084829.jpg",
						"author": "파울로 코엘료",
						"discount": "6400",
						"publisher": "문학동네",
						"pubdate": "20181205",
						"isbn": "9788982814471",
						"description": "삶에 대한 깊은 통찰을 담은 현대의 고전!\n\n1987년 출간이후 전세계 120여 개국에서 변역되어 2,000만 부가 넘는 판매량을 기록한 파울로 코엘료의 『연금술사』. 청년 산티아고가 만물에 깃들인 영혼의 언어들을 하나하나 배워가는 과정을 그리고 있다. 마음의 목소리에 귀를 기울이는 것이 얼마나 중요한지를 증언하고, 진정 자기 자신의 꿈과 대면하고자 하는 모든 이들을 축복하는 희망과 환희의 메시지를 담은 작품이다. \n\n신부가 되기 위해 라틴어, 스페인어, 신학을 공부한 산티아고는 어느 날 부모님의 기대를 저버리고 떠돌아다니기 위해 양치기가 되어 길을 떠난다. 그의 인생을 살맛나게 해주는 건 ‘꿈이 실현되리라고 믿는 것’. 언제나 자신이 원하는 게 무엇인지 알고 있어야 한다는 늙은 왕의 말과 그가 건네준 두 개의 보석을 표지로 삼아 기약없는 여정에 뛰어든 그는 집시여인, 늙은 왕, 도둑, 화학자, 낙타몰이꾼, 아름다운 연인 파티마, 절대적인 사막의 침묵과 죽음의 위협 그리고 마침내 연금술사를 만나 자신의 보물을 찾게 되는데……."
					},
					{
						"title": "백만 광년의 고독 속에서 한 줄의 시를 읽다 (류시화의 하이쿠 읽기)",
						"link": "https://search.shopping.naver.com/book/catalog/32482671630",
						"image": "https://shopping-phinf.pstatic.net/main_3248267/32482671630.20240203070930.jpg",
						"author": "류시화",
						"discount": "25200",
						"publisher": "연금술사",
						"pubdate": "20140616",
						"isbn": "9791195026142",
						"description": "단 열입곱 자 안에 담긴, 한 줄의 시!\n\n하이쿠모음집 《한 줄도 너무 길다》로 하이쿠에 대한 관심을 불러일으킨 바 있는 류시화 시인이 다시금 내놓은 하이쿠 소개서『백만 광년의 고독 속에서 한 줄의 시를 읽다』. 열일곱 자로 이루어진 하이쿠는 세계 문학에서 가장 짧은 형태의 시다. 짧은 시가 가진 함축미와 선명한 이미지는 일찍이 세계의 문학가들에게 사랑받았지만, 우리나라에는 여전히 생소하기만하다. 이에 류시화 시인은 하이쿠를 읽기 위해 독학으로 일본어와 일본 문학을 배워가장 널리 읽히고 문학적으로 평가받는 하이쿠를 모두 모았으며, 15년의 시간을 들여 일본의 대표적인 하이쿠 시인들의 작품을 모아 충실한 해설을 붙였다. \n\n책에는 750쪽에 달하는 방대한 분량으로, 에도 시대의 바쇼, 부손, 잇사, 시키뿐 아니라 현대의 다코쓰, 만타로, 구사타오 등 130명의 시인들의 주옥같은 하이쿠 1,370여 편이 실려 있다. 또한 책 뒤의 150쪽에 이르는 해설 '언어의 정원에서 읽는 한 줄의 시'는 하이쿠의 역사와 배경뿐 아니라 서양의 하이쿠 시인들에 대한 소개까지 담아 하이쿠의 세계를 깊이 이해할 수 있다. 과거와 현대의 하이쿠가 집대성되고 진지한 해설이 곁들여진 이 책은 우리나라 뿐 아니라 일본이나 서양에서도 귀한 자료가 되어줄 것이다. 특히 캘리그라퍼 강병인이 쓴 하이쿠 캘리 다섯 점이 특별 제본으로 담겨 있다."
					},
					{
						"title": "지구별 여행자",
						"link": "https://search.shopping.naver.com/book/catalog/32473636675",
						"image": "https://shopping-phinf.pstatic.net/main_3247363/32473636675.20230919123103.jpg",
						"author": "류시화",
						"discount": "15300",
						"publisher": "연금술사",
						"pubdate": "20190628",
						"isbn": "9791186686454",
						"description": "『하늘 호수로 떠난 여행』에 이은\n또 한 권의 특별한 인도 여행기\n\n“여행을 떠날 때는 따로 책을 들고 갈 필요가 없었다. 세상이 곧 책이었다. 기차 안이 소설책이고, 버스 지붕과 들판과 외딴 마을은 시집이었다. 그 책을 나는 읽었다. 책장을 넘기면 언제나 새로운 길이 나타났다.”\n시를 쓰고 명상에 관한 책들을 번역하며 해마다 인도와 네팔을 여행하는 류시화는 길 위의 시인이다. 『지구별 여행자』는 그가 15년 동안 매해 인도를 여행하면서, 그리고 한 장소에 오래 머무르면서 얻은 삶의 교훈과 깨달음의 기록이다. 성자와 걸인, 사막의 유목민, 여인숙 주인, 신발 도둑, 새점 치는 남자 등과의 만남은, 우리 모두는 이 세상에 여행 온 여행자들이며, 인생 수업을 받는 학생들이라는 시인의 시각이 잘 드러나 있다.\n\n80만 독자의 사랑을 받은 『하늘 호수로 떠난 여행』과 마찬가지로 『지구별 여행자』는 가볍게 읽어 내려가다가 큰 깨달음을 얻는 책이다. 유머로 가득한 철학, 가장 심오한 이야기를 가장 쉽게 전달해 주는 것이 이 책의 미덕이다. 그 흔한 인물 사진과 풍경 사진 한 장 없는 여행 에세이들이 다큐멘터리보다 더 생생하다. 하나하나의 구절들에는 그가 꿈꿔 왔던 자유의 본질, 그리고 깨달음에 관한 사색과 명상이 가득하다. 그렇다고 그가 일반인들이 평생 만나 보기 힘든 거창한 사람들과 유적지들을 돌아다닌 것은 아니다. 도망간 새를 기다리는 새점 치는 남자, 말끝마다 명언하기를 좋아하는 식당 주인, 은근슬쩍 다가와 땅콩을 까먹으며 다른 사람들로부터 여행자를 독차지하기 위해 안간힘을 쓰는 남자, 시를 좋아하는 강도 두목 등이다. 작가에게 그들은 이 세상 모든 사람들의 ‘원형적 모델’이다. 그래서 인도인들에 대한 이야기이지만, 그들만의 이야기가 아닌 우리 모두의 이야기이다. \n\n‘신은 어디에 있는가’라는 물음으로 시작되는 책은 “아 유 해피?”로 끝난다. ‘신’은 이상향의 세계를 뜻하지만, 사람들은 언제나 마치 주문처럼 '노 프러블럼'을 외치며 그들의 이상향을 만들어 낸다. 어처구니없어 웃음을 자아내는 일화들이 많지만, 그냥 흘려 버리기에는 진실이 담긴 책이다. 누구든 한번 잡으면 끝까지 읽을 수 밖에 없는 매력적인 이야기들이 계속 이어진다. 책과 여행을 좋아하지 않는 사람들에게도 권할 수 있고, 책을 덮는 순간 “나마스테.”를 외치며 인도로 떠나고 싶게 만든다. 다른 사람들이 세워 놓은 질서에 순응하는 것이 아니라, 나 자신의 질서를 발견하는 것, 그것을 저자는 자유라고 부른다."
					},
					{
						"title": "인생 우화 (천사의 실수로 세상의 바보들이 한 마을에 모여 살게 되었다)",
						"link": "https://search.shopping.naver.com/book/catalog/32482726917",
						"image": "https://shopping-phinf.pstatic.net/main_3248272/32482726917.20230606092422.jpg",
						"author": "류시화",
						"discount": "14400",
						"publisher": "연금술사",
						"pubdate": "20180730",
						"isbn": "9791186686348",
						"description": "우리 안의 바보는 어떤 엉뚱한 방식으로 문제를 해결하며 살아갈까?\n\n류시화 시인이 들려주는 우화 『인생 우화』. 폴란드에서 전해 내려오는 폴란드 남동부의 작은 마을 헤움의 이야기들을 저본으로 삼아 재창작한 우화들과 그 이야기에서 영감을 얻어 저자가 창작한 우화 45편을 담은 책으로, 현실과 비현실을 넘나들며 우리를 상상의 이야기 속으로 안내해 우화가 주는 재미와 의미를 느끼게 한다. 지금은 사라지고 없는 한 마을에 천사의 실수로 세상의 모든 바보들이 모여 살게 되었다. 그들은 자신들이 세상에서 가장 지혜로운 사람들이라고 믿었다. 세상의 바보들이 한 장소에 모여 살면 어떤 일이 일어날까? \n\n자신이 누구인지 확인하기 위해 손목에 묶은 붉은색 끈이 사라지자 자신을 찾아 헤매는 빵장수, 실수로 창문을 만들지 않은 캄캄한 교회당을 밝히기 위해 손바닥으로 햇빛을 나르는 신도들, 진실을 구입하러 다른 도시에 갔다가 속아서 구린내 나는 오물을 한 통 사 가지고 와서는 ‘진실은 구리다’고 고개를 끄덕이는 이들의 이야기까지 순수함, 어리석음, 그리고 논리적인 비논리 속에 우리가 사는 사회를 담아낸 우화들을 통해 우리 안의 바보가 어떤 엉뚱한 방식으로 문제를 해결하는지, 그래서 어떻게 더 많은 문제를 만드는지 보여 준다."
					}
				]
			}
			*/

			// data.items[i].title;
			// data.items[i].link;
			// data.items[i].image;
			// data.items[i].author;
			// data.items[i].publisher;
			// data.items[i].pubdate;
			// data.items[i].description;

			// 검색 실패시 표시
			if(data.items.length===0||data===null){
				const $li = document.createElement('li');
				$li.textContent = "검색에 실패하였습니다.";
				$APISearchedList.appendChild($li);
				return;
			}

			//검색된 결고(최대5개)를 화면에 반영
			for(let i=0;i<data.items.length;i++) {
				// title 응답에서 부연설명 부분분리
				let title;
				let description;

				if(data.items[i].title.includes('(')){
					title = data.items[i].title.split("(")[0];
					description = data.items[i].title.split("(")[1];
					description = description.slice(0,-1);
				}else{
					title = data.items[i].title;
					description = data.items[i].description;
				}

				const $li = document.createElement('li');
				const $a = document.createElement('a');
				const $image = document.createElement('img');
				const $div = document.createElement('div');
				const $title = document.createElement('p');
				const $author = document.createElement('p');
				const $publisher = document.createElement('p');
				const $description = document.createElement('p');

				$a.setAttribute('href', data.items[i].link);
				$image.setAttribute('src', data.items[i].image);
				$image.setAttribute('alt', title);
				$title.classList.add('title');
				$title.textContent = title;
				$author.classList.add('author');
				$author.textContent = data.items[i].author;
				$publisher.classList.add('publisher');
				$publisher.textContent = data.items[i].publisher;
				$description.classList.add('description');
				$description.textContent = description;

				$div.append($title,$author,$publisher,$description);
				$a.append($image,$div);
				$li.appendChild($a);
				$APISearchedList.appendChild($li);
			}//for
		}//renderAPISearch = (data)=>{


		// 검색을 실행하는 함수
	    async function searchAPI() {
	        const subject = document.querySelector("input[name=bookSearchAPI]").value;
			
	        if (subject.trim() === "") {
	            alert("검색하실 내용을 입력해주세요.");
	            document.bookSearchAPIFrm.bookSearchAPI.focus();
	            return;
	        }else{
		        try {
		            // fetch를 사용하여 GET 요청을 서블릿으로 전송
		            const response = await fetch('/searchAPI?subject=' + encodeURIComponent(subject));
		            const data = await response.json();
		            console.log(data);
		            addSearchedListItemAPI(data);

		        } catch (error) {
		            console.error('API 작동에 실패하였습니다.:', error);
		        }
	        }//if(subject==null || subject=="")~else
	    }// async function search()
	    

		//submit이벤트 발생시 이벤트 방지 및 검색함수 호출
	    const $bookSearchAPIFrm = document.querySelector("form[name=bookSearchAPIFrm]");
	    $bookSearchAPIFrm.addEventListener('submit', (evt) => {
	        evt.preventDefault(); // 기본 제출 방지
	        searchAPI(); // 검색 함수 호출
	        $bookSearchAPIFrm.reset(); //검색어초기화
	    });


		// aside클릭시마다 검색창을 보였다가 안보였다가
		const $searchAPIFrame = document.querySelector('aside>.searchAPIFrame');
		const $APIShowers = document.querySelectorAll('aside>i');
		$APIShowers.forEach(($APIShower)=>{
			$APIShower.addEventListener('click',()=>{
				$APIShowers[0].classList.toggle('on');
				$APIShowers[1].classList.toggle('on');
				$searchAPIFrame.classList.toggle('on');
			});
		});

	</script>

</body>
</html>






















