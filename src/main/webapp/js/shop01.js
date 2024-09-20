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






