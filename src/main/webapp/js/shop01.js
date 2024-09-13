//넓은 카테고리 클릭 이벤트
const $broadCategoryAs = document.querySelectorAll('.shop-list .book-broadCategory>li>a');

const toggleFn = (evt) => {
  evt.preventDefault();
  evt.currentTarget.firstElementChild.classList.toggle('fa-plus');
  evt.currentTarget.firstElementChild.classList.toggle('fa-minus');
  evt.currentTarget.nextElementSibling.classList.toggle('on');
}

$broadCategoryAs.forEach($broadCategoryA =>{
  $broadCategoryA.addEventListener('click', (evt)=>{
    toggleFn(evt);
  });
});

//분야별 카테고리 클릭 이벤트
const $genreCategoryAs = document.querySelectorAll('.shop-list .book-genreCategory>li>a');

$genreCategoryAs.forEach($genreCategoryA => {
  $genreCategoryA.addEventListener('click', (evt)=>{
    toggleFn(evt);
  });
});

let nowIdx = 0;
//목록 위 탭 네비게이션 클릭 이벤트
const $containerTapAs = document.querySelectorAll('.shop-list .container>nav>ul>li>a');

(function(){
  $containerTapAs.forEach(($containerTapA, idx) => {
    $containerTapA.addEventListener('click', (evt)=>{
      evt.preventDefault();
      let oldIdx = nowIdx;
      nowIdx = idx;

      evt.currentTarget.parentElement.classList.add('on');
      $containerTapAs[oldIdx].parentElement.classList.remove('on');
    });
  });
})();


const $paginationCont = document.querySelector('.shop-list .pagination-container');
const $paginationSlide = document.querySelector('.shop-list .pagination-container>.pagenation-frame>.pagenation-slide');
const $paginationFrame = $paginationSlide.parentElement;

//목록 아래 페이지 번호
const totalCount = 60;//총 데이터 개수
const limit = 5; //한페이지당 나타낼 글 개수
const pageCount = 5; // 화면에 나타낼 페이지 개수
const currentPage = 1;//현재 페이지

//총 페이지 개수 계산
let totalPage = Math.ceil(totalCount / limit);

//화면에 보여질 페이지 그룹
let displayPage = Math.ceil(currentPage / limit);

//현재 페이지 그룹 계산
let pageGroup = Math.ceil(currentPage / pageCount);

//현재 페이지 그룹의 첫번째/마지막 숫자 구하기
let lastNumber = pageGroup * pageCount
if(lastNumber > totalPage) lastNumber = totalPage;

let firstNumber = lastNumber - (pageCount -1)

const next = lastNumber + 1;
const prev = firstNumber -1;

//페이지수 5이상일 경우 이전 다음 버튼 생성
if(totalPage>5) {
  const $prev = document.createElement('i');
  $prev.classList.add('fa-solid', 'fa-caret-left');
  $prev.style.left = '30px';
  const $next = document.createElement('i');
  $next.classList.add('fa-solid', 'fa-caret-right');
  $next.style.right = '30px';
  $paginationCont.append($prev, $next);


  $prev.addEventListener('click', ()=>{
    if(pageGroup !== 1){
      $paginationSlide.style.left = -200 * (pageGroup-2) + 'px';
      pageGroup--;
    }
  });

  $next.addEventListener('click', ()=>{
    if(pageGroup < Math.ceil(totalPage/limit)){
      $paginationSlide.style.left = -200 * pageGroup + 'px';
      pageGroup++;
    }
   
  });

}

const $ol = document.querySelector('.shop-list .book-frame>ol');

//데이터 샘플
const sample = {
  tit: '자바의 정석',
  name: '남궁성',
  price: 27000,
  info: '자바 프로그래머로써 반드시 알아야하는 것을 모두 담은책. 저자는 자바를 소개하는데 그치지 않고 프로그래머로써 꼭 알아야하는 내용들을 체계적으로 정리하였다.'
}

//데이터 수만큼 li 동적생성
for(let i=0; i<totalCount; i++){
  const $li = document.createElement('li');
  const $a = document.createElement('a');
  $a.href = "#";
  const $cover = document.createElement('div');
  $cover.classList.add('cover');
  const $text = document.createElement('div');
  $text.classList.add('text');
  const $h3 = document.createElement('h3');
  const $pAuthor = document.createElement('p');
  const $pPrice = document.createElement('p');
  $pPrice.textContent = '가격 :';
  const $span = document.createElement('span');
  const $br = document.createElement('br');
  const $pInfo = document.createElement('p');
  const $form = document.createElement('form');
  $form.method = 'post';
  $form.name = 'listFrm';
  const $input = document.createElement
  ('input');
  $input.type = 'hidden';
  const $cart = document.createElement('button');
  const $order = document.createElement('button');

  $h3.textContent = sample.tit + (i+1);
  $pAuthor.textContent = sample.name + (i+1);
  $span.textContent = sample.price + '원';
  $pInfo.textContent= sample.info;
  $cart.textContent = '장바구니';
  $order.textContent = '바로구매';

  $form.append($input, $cart, $order);
  $pPrice.append($span);
  $text.append($h3, $pAuthor, $pPrice, $br, $pInfo);
  $a.append($cover, $text, $form);
  $li.append($a);
  $ol.append($li);

}

//페이지 수만큼 버튼 동적 생성
for(let i=0; i<totalPage; i++){
  const $button = document.createElement('button');
  $button.textContent = i+1;
  if(i === 0) $button.classList.add('on');
  $paginationSlide.append($button);
  
  //페이지 버튼 클릭 이벤트
  $button.addEventListener('click', ()=>{
    let oldIdx = nowIdx;
    nowIdx = i;
    $button.classList.add('on');
    $paginationSlide.children[oldIdx].classList.remove('on');

    $ol.style.top = -1305 * i + 'px';
    
  });
}







