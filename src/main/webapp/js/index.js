
const $gnbMenus = document.querySelectorAll('.gnb>li>a');
const $slides = document.querySelectorAll('section>div');
const $h1 = document.querySelector('h1');

let nowIdx = 0;
let oldIdx = nowIdx;
// 페이지 메뉴 클릭시 on 효과 추가
$gnbMenus.forEach(($gnbMenu, idx) => {
    $gnbMenu.addEventListener('click', (evt) => {
        evt.preventDefault();

        oldIdx = nowIdx;
        nowIdx = idx;
        $gnbMenus[oldIdx].classList.remove('on');
        $gnbMenus[nowIdx].classList.add('on');

    });
});

const $recommendFrame = document.querySelector('.recommendSlide>.frame');
const $recommendPrev = document.querySelector('.recommendSlide>.prev');
const $recommendNext = document.querySelector('.recommendSlide>.next');
// 추천영역 좌우 슬라이드
$recommendPrev.addEventListener('click', (evt) => {
    evt.preventDefault();

    $recommendFrame.style.marginLeft = 0 + 'px';
});

$recommendNext.addEventListener('click', (evt) => {
    evt.preventDefault();

    $recommendFrame.style.marginLeft = -1200 + 'px';
});

const $pointers = document.querySelectorAll('.bookCard .pointer');
const $addCartContainers = document.querySelectorAll('.bookCard .addCartContainer');
const $addToCarts = document.querySelectorAll('.bookCard .addToCart');

// 북카드 추가메뉴 클릭시 장바구니추가 영역 보이기
$pointers.forEach(($pointer,idx)=>{
    $pointer.firstElementChild.addEventListener('click',()=>{
        $pointer.firstElementChild.style.display = "none";
        $pointer.lastElementChild.style.display = "block";
        $addCartContainers[idx].style.display = "block";
    });
});

// 북카드 닫기 클릭시 장바구니 영역 숨김
$pointers.forEach(($pointer,idx)=>{
    $pointer.lastElementChild.addEventListener('click',()=>{
        $pointer.lastElementChild.style.display = "none";
        $pointer.firstElementChild.style.display = "block";
        $addCartContainers[idx].style.display = "none";
    });
});

// 장바구니추가 버튼 클릭시 장바구니 추가 로직 & 장바구니 영역 숨김
function addToCart(userId,ranId,title,idx) {
    if(userId=="") {
        if(confirm("장바구니 추가를 위해 로그인 페이지로 이동하시겠습니까?")) {
            location.href="/login/login01";
        }
        return;
    }else if(confirm(title+"를 장바구니에 추가하시겠습니까?")) {
      location.href = '/procs/shopProc?orderNum=1&save=cart&bookid=' + ranId+'&userid=' + userId;
  }

  $pointers[idx].lastElementChild.style.display = "none";
  $pointers[idx].firstElementChild.style.display = "block";
  $addCartContainers[idx].style.display = "none";
}// addToCart(userId,ranId)