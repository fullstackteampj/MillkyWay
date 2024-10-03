// 로그인 검사
function goLogin() {
	const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?");
	if(result) {
		location.href = "../login/login01";
	}
}

const headerelement = document.querySelector('header');
const $category = document.getElementById('category');
const $rightBox = document.getElementById('rightBox');
const $footer = document.querySelector('footer');
const scrollTop = Math.ceil(window.scrollY);

let lastScrollba = document.documentElement.scrollTop || 0;

// 상단고정/하단막힘 함수 정의
// 1. 스크롤업/다운에 따라 유동적인 헤더높이에 맞춰 스크롤에 따른 top값을 동적으로 부여해 상단고정.
// 2. footer에 닿으면 상단고정풀고 하단고정 ((브라우저 창의 높이가 낮은경우를 대비)) <-- 테스트하려면 브라우저높이를 카테고리박스/인기글박스보다 짧게 줄여주세욤 !
function topfixedFn(targetE, baseE, scrollPos) { // 매개변수 - 상단고정할 요소, 하단고정기준요소, 상단고정될 스크롤값

  const scrollTop = Math.ceil(window.scrollY);
  const baseERect = baseE.getBoundingClientRect();
  const targetERect = targetE.getBoundingClientRect();

  if(targetERect.bottom >= baseERect.top) { //카테고리가 footer에 닿으면 //footer에 닿기전 하단고정되는 오류있어서 수정해야함
    // 상단고정 풀고 하단고정
    targetE.style.top = 'initial';
    targetE.style.bottom = 0;

  } else { //카테고리가 footer에 안닿았으면
    // 하단 풀고
    targetE.style.bottom = 'initial';
    // 카테고리 - 스크롤 다운 시 낮아진 헤더만큼의 top값을 가지며 상단 fixed
    if(scrollTop >= scrollPos) {
      targetE.style.top = (scrollTop-scrollPos) + 'px';
    } else if(scrollTop < scrollPos) {
      targetE.style.top = 0;
    }
  }
}

// 클릭에따른 스타일적용 함수 정의
function clickFn(targetArr, startIdx = 0) {
  
  let nowIdx = startIdx;
  let oldIdx = nowIdx;
  
  targetArr.forEach((target, idx)=>{
    
    target.addEventListener('click', ()=>{
      oldIdx = nowIdx;
      nowIdx = idx;
  
      targetArr[nowIdx].classList.add('on');
      targetArr[oldIdx].classList.remove('on');
    })
  })
  
}


// 스크롤시 헤더/카테고리박스/인기글 박스 조작
window.addEventListener('scroll', ()=>{
  const scrollTop = Math.ceil(window.scrollY);
  let nowScroll = document.documentElement.scrollTop;

  // 초기값
  // 카테고리 - 스크롤 업 시 높아진 헤더만큼의 top값을 가지며 상단 fixed
  if(scrollTop >= 50) {
    $category.style.top = (scrollTop-50) + 'px';
  } else if(scrollTop < 50) {
    $category.style.top = '0';
  }

  // 인기글
  if(scrollTop >= 100) {
    $rightBox.style.top = (scrollTop-100) + 'px';
  } else if(scrollTop < 100) {
    $rightBox.style.top = '0';
  }

  // 헤더 - 스크롤 시 세로스크롤만 상단 fixed
  headerelement.style.top = scrollTop + 'px';

  // 스크롤 감지 if문 - 업, 다운에 따른 헤더높이 변동. 그에따른 카테고리박스, 인기글박스의 상단고정값 변동.
  if(nowScroll > lastScrollba) { // 스크롤 다운
    // 헤더
    headerelement.classList.add('scrolled');
    // 카테고리
    topfixedFn($category, $footer, 120);
    // 인기글
    topfixedFn($rightBox, $footer, 170);

  } else { // 스크롤 업
    //헤더 - 스크롤업 시 헤더탑 보이기
    headerelement.classList.remove('scrolled');
    // 카테고리
    topfixedFn($category, $footer, 50);
    // 인기글
    topfixedFn($rightBox, $footer, 100);
  }
  
  lastScrollba = nowScroll;
});

// 요소 클릭했을 때 스타일 적용
// 카테고리
const $categorylis = document.querySelectorAll('#category>ul>li');
clickFn($categorylis);
// 탭
const $tabs = document.querySelectorAll('#tab>li');
clickFn($tabs);
// 페이지네이션
const $paginations = document.querySelectorAll('#pagination>li');
clickFn($paginations, 2);







// 정훈님
const $gnbMenus = document.querySelectorAll('.gnb>li>a');
const $h1 = document.querySelector('h1');

let nowIdx = 0;
let oldIdx = nowIdx;
$gnbMenus.forEach(($gnbMenu, idx) => {
    $gnbMenu.addEventListener('click', (evt) => {
        evt.preventDefault();

        oldIdx = nowIdx;
        nowIdx = idx;
        $gnbMenus[oldIdx].classList.remove('on');
        $gnbMenus[nowIdx].classList.add('on');

    });
});
