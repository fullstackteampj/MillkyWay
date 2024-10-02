//뒤로 가기 버튼
const $prevPage = document.querySelector('.shop-product>h2>.fa-chevron-left');
$prevPage.addEventListener('click', ()=>{
  history.back();
});

//가격에 따른 포인트 적립 출력
const $price = document.querySelector('.shop-product form[name=orderFrm]>h3>span');
const $point = document.querySelector('.shop-product .point');
const $freeDelivery = $point.parentElement.nextElementSibling;

$point.textContent = parseInt($price.textContent)/10;


//한줄평 이동
const $scrollOneReview = document.querySelector('.shop-product .scroll-oneReview');

const $oneReview = document.querySelector('.shop-product .one-review');

const oneReviewTop = $oneReview.offsetTop;

$scrollOneReview.addEventListener('click', (evt)=>{
  evt.preventDefault();
  window.scrollTo({
    top: oneReviewTop,
    behavior: "smooth"
  });
});


//수량 선택
const $orderNum = document.querySelector('.shop-product .order-qty>.updown-qty>input');
const $orderUp = document.querySelector('.shop-product .btn-updown>button:first-child');
const $orderDown = $orderUp.nextElementSibling;
const $preTotal = document.querySelector('.shop-product .pretotal');
const $delivery = $preTotal.nextElementSibling;
const $totalPrice = document.querySelector('.shop-product .total-price');
const $quickTotal = document.querySelector('.shop-product .quick-total');

let orderNum = 1;

const calcFn = () => {
  let total = parseInt($price.textContent)*orderNum;
  $preTotal.textContent = '도서가격 ' + total +'원';
  if(total<50000) {
    $freeDelivery.classList.remove('deleteline');
    $delivery.textContent = ' + 배송비 2000원';
    total += 2000;
  }else{
    $freeDelivery.classList.add('deleteline');
    $preTotal.textContent = '';
    $delivery.textContent = '';
  }
  $totalPrice.textContent = total +'원';
  $quickTotal.textContent = total +'원';
}

calcFn();

$orderUp.addEventListener('click', ()=>{
  orderNum++;
  $orderNum.value = orderNum;
  calcFn();
});

$orderDown.addEventListener('click', ()=>{
  if(orderNum===1)orderNum=1;
  else orderNum--;
  $orderNum.value = orderNum;

  calcFn();
});


//이벤트 슬라이드
const $slideEvents = document.querySelector('.shop-product .slide-events');
const $firstDot = document.querySelector('.shop-product .page-dots>a:first-child');
const $secDot = $firstDot.nextElementSibling;

$firstDot.addEventListener('click', (evt)=>{
  evt.preventDefault();
  evt.currentTarget.classList.add('on');
  $secDot.classList.remove('on');
  $slideEvents.style.left = 0;
});

$secDot.addEventListener('click', (evt)=>{
  evt.preventDefault();
  evt.currentTarget.classList.add('on');
  $firstDot.classList.remove('on');
  $slideEvents.style.left = -1100 + 'px';
});


//스크롤 내리면 퀵 주문 보이게
const $descProduct = document.querySelector('.shop-product .headbook+ul');

const $quickFrm = document.querySelector('.shop-product form[name=quickFrm]');

window.addEventListener('scroll', ()=>{
  const scrollTop = Math.ceil(window.scrollY);

  if(scrollTop > $descProduct.offsetTop){
    $quickFrm.style.display = 'flex';
  }else{
    $quickFrm.style.display = 'none';
  }
});

//한줄평 아이콘 클릭시 입력폼 나타나게
const $reviewFrm = document.querySelector('.shop-product form[name=reviewFrm]');
const $pencil = document.querySelector('.fa-pencil');

$reviewFrm.addEventListener('submit', (evt)=>{
  evt.preventDefault();
})

$pencil.addEventListener('click', ()=>{
  $reviewFrm.classList.toggle('pencil');
});

