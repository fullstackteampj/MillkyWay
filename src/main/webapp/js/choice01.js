
//슬라이드 이동
const $btnPrev = document.querySelector('.fa-circle-chevron-left').parentElement;
const $btnNext = $btnPrev.nextElementSibling
const $slidesRecom = document.querySelector('.slide-recommend');
const $slide = document.querySelectorAll('.slide-recommend>article');
const $slidemenus = document.querySelectorAll('nav>ul>li>a');

let nowIdx = 0;
let slideCount = $slide.length; 
let slideWidth = 770;

//복사본 만드는 함수
const makeClone = () => {
  let cloneFirst = $slide[0].cloneNode(true);
  let cloneLast = $slidesRecom.lastElementChild.cloneNode(true);
  $slidesRecom.append(cloneFirst);
  $slidesRecom.insertBefore(cloneLast, $slidesRecom.firstElementChild);
}

//처음 위치 세팅 함수
const init = () => {
  $slidesRecom.style.width = slideWidth * (slideCount + 2) + 'px';
  $slidesRecom.style.left = - slideWidth + 'px';
}

makeClone();
init();

//메뉴 활성화 함수
const updateSlideMenu = () => {
  $slidemenus.forEach($menu => {
    $menu.parentElement.classList.remove('on'); // 모든 메뉴에서 'on' 클래스 제거
  });
  
  // 현재 인덱스에 맞는 메뉴에 'on' 클래스 추가
  if (nowIdx < slideCount) {
    $slidemenus[nowIdx].parentElement.classList.add('on');
  } else {
    $slidemenus[0].parentElement.classList.add('on'); // 마지막 슬라이드에서 첫 번째 메뉴에 'on'
  }
};

//다음버튼 - 클릭이벤트
$btnNext.addEventListener('click', (evt)=>{
  evt.preventDefault();
  if(nowIdx <= slideCount -1){
    $slidesRecom.style.left = -(nowIdx +2) * slideWidth + 'px';
    $slidesRecom.style.transition = `${0.5}s ease-out`;
  }
  if(nowIdx === slideCount-1){
    setTimeout(()=>{
      $slidesRecom.style.left = -slideWidth + 'px';
      $slidesRecom.style.transition = `${0}s ease-out`;
    }, 500);
    nowIdx = -1;
  }
  nowIdx += 1;
  updateSlideMenu();
});

//이전버튼 - 클릭이벤트
$btnPrev.addEventListener('click', (evt)=>{
  evt.preventDefault();
  if(nowIdx >= 0){
    $slidesRecom.style.left = -(nowIdx) * slideWidth + 'px';
    $slidesRecom.style.transition = `${0.5}s ease-out`;
  }
  if(nowIdx === 0){
    setTimeout(()=>{
      $slidesRecom.style.left = -slideCount * (slideWidth) + 'px';
      $slidesRecom.style.transition = `${0}s ease-out`;
    }, 500);
    nowIdx = slideCount;
   
  }
  nowIdx -= 1;
  updateSlideMenu();
});

$slidemenus.forEach(($menu, idx)=>{
  $menu.addEventListener('click', (evt)=>{
    evt.preventDefault();
    oldIdx = nowIdx;
    nowIdx = idx;
    $slidemenus[nowIdx].parentElement.classList.add('on');
    $slidemenus[oldIdx].parentElement.classList.remove('on');

    $slidesRecom.style.left = -(nowIdx +1) * slideWidth + 'px';
    $slidesRecom.style.transition = `${0.5}s ease-out`;
    console.log(nowIdx);
  });
});
