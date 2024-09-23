//넓은 카테고리 클릭 이벤트
const $broadCategoryAs = document.querySelectorAll('.shop-list .book-broadCategory>li>a');

const toggleFn = () => {
  
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
      let oldIdx = nowIdx;
      nowIdx = idx;

      evt.currentTarget.parentElement.classList.add('on');
      $containerTapAs[oldIdx].parentElement.classList.remove('on');
    });
  });
})();








