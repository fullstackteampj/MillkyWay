//넓은 카테고리 클릭 이벤트
const $broadCategoryAs = document.querySelectorAll('.shop-list .book-broadCategory>li>a');

const toggleFn = (evt) => {
  
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
const $containerTapAs = document.querySelectorAll('.shop-list .container>.content>nav>ul>li>a');

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


//쿼리스트링 가져오기
urlSearch = new URLSearchParams(location.search);
const category = urlSearch.get('category');
const genre = urlSearch.get('genre');
const tap = urlSearch.get('tap');

//페이지 로드 이벤트
window.addEventListener('load', ()=>{

  //카테고리
  $broadCategoryAs.forEach($broadCategoryA => {
    //만약 쿼리스트링 값과 nav 이름이 같다면 해당 카테고리 on상태 유지
    if($broadCategoryA.textContent.trim() === category){
      $broadCategoryA.firstElementChild.classList.add('fa-minus');
      $broadCategoryA.nextElementSibling.classList.add('on');
    }
  });

  //장르
  $genreCategoryAs.forEach($genreCategoryA => {
    if($genreCategoryA.textContent.trim() === genre){
      $genreCategoryA.firstElementChild.classList.add('fa-minus');
      $genreCategoryA.nextElementSibling.classList.add('on');

      //해당 카테고리도 on상태
      $genreCategoryA.parentElement.parentElement.previousElementSibling.firstElementChild.classList.add('fa-minus');
      $genreCategoryA.parentElement.parentElement.classList.add('on');
    }
  })

  //탭 
  $containerTapAs.forEach($containerTapA => {
    //만약 쿼리스트링 값과 tap 이름이 같다면 해당 tap on상태 유지
    if($containerTapA.textContent.trim() === tap){
      //모든 tap에서 on 삭제
      for(let i=0; i<$containerTapAs.length; i++){
        $containerTapAs[i].parentElement.classList.remove('on');
      }
      //해당 tap만 on 상태 
      $containerTapA.parentElement.classList.add('on');
    }
  });
});

//폼 요소안에 submit 요소 있는 경우 form.submit() 방식 불가능!









