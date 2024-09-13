//슬라이드 이동
const $btnPrev = document.querySelector('.fa-circle-chevron-left').parentElement;
const $btnNext = $btnPrev.nextElementSibling
const $slideRecom = document.querySelector('.slide-recommend');;

const $slidemenus = document.querySelectorAll('nav>ul>li>a');

let nowIdx = 0;
let oldIdx = nowIdx;

const activeFn = () =>{
  $slidemenus[nowIdx].parentElement.classList.add('on');
  $slidemenus[oldIdx].parentElement.classList.remove('on');
  $slideRecom.style.left = -770 * nowIdx +'px';
}

$btnNext.addEventListener('click', (evt)=>{
  evt.preventDefault();
  oldIdx = nowIdx;
  if(nowIdx<3){
    nowIdx++;
  }else{
    nowIdx = 0;
  }
  activeFn();
});

$btnPrev.addEventListener('click', (evt)=>{
  evt.preventDefault();
  oldIdx = nowIdx;
  if(nowIdx>0){
    nowIdx--;
  }else{
    nowIdx = 3;
  }

  activeFn();
});

$slidemenus.forEach(($menu, idx)=>{
  $menu.addEventListener('click', (evt)=>{
    evt.preventDefault();
    oldIdx = nowIdx;
    nowIdx = idx;

    activeFn();
  });
});