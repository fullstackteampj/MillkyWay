// 스크롤 감지 헤더 노출
const header = document.querySelector('header');

let lastScrollbar = document.documentElement.scrollTop || 0;

window.addEventListener('scroll', ()=>{
  let nowScroll = document.documentElement.scrollTop;
  const scrollTop = Math.ceil(window.scrollY);

  // 헤더 - 스크롤 시 세로스크롤만 상단 fixed
  header.style.top = scrollTop + 'px';

  // 스크롤감지헤더
  if(nowScroll > lastScrollbar) { // 스크롤 다운
    // 헤더탑 숨김
    header.classList.add('scrolled');
  } else { // 스크롤 업
    // 헤더탑 보임
    header.classList.remove('scrolled');
  }
  
  lastScrollbar = nowScroll;
});



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