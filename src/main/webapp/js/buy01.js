//가격에 따른 포인트 적립 출력
const $totalPrice = document.querySelector('.buy .buy-total .totalPrice');
const $point = document.querySelector('.buy .buy-total .point');
const $delivery = document.querySelector('.buy .buy-total>li:nth-of-type(2)');//배송비 li
const $usePointBtn = document.querySelector('.buy .buy-total .usePointBtn');
const $usePointInput = $usePointBtn.previousElementSibling;
const $havePoint = $usePointBtn.nextElementSibling;



//도서별 권수
const $eachNums = document.querySelectorAll('.buy .payment-info .buy-products>li .eachNum'); 
const $totNum = document.querySelector('.buy .payment-info .totNum'); //총 ~권

let totNum = 0;

//도서별 권수 합계
for(let i=0; i<$eachNums.length; i++){
  totNum += parseInt($eachNums[i].textContent);
}

$totNum.textContent = totNum;


//도서별 각각의 권수에 따른 가격 - 배열 저장
const $booksPrice = document.querySelectorAll('.buy .payment-info .buy-products>li .price'); 

//도서별 가격 계산
const $regularPrices = document.querySelectorAll('.buy .payment-info .buy-products>li>h4>span'); //정가

for(let i=0; i<$regularPrices.length; i++){
  $booksPrice[i].textContent = parseInt($regularPrices[i].textContent) * parseInt($eachNums[i].textContent); 
  //도서별 총금액 = 도서별 정가 * 도서별 권수 
}

//총 도서 결제 금액
let totPrice = 0;
for(let i=0; i<$booksPrice.length; i++){
  //총 도서 결제 금액 = 도서별 총금액 누적합계
  totPrice += parseInt($booksPrice[i].textContent);
}

/*
const $orderNum = document.querySelector('.buy .payment-info .buy-products>li .orderNum'); 
const $regularPrice = document.querySelector('.buy .payment-info .buy-products>li .regularPrice');
const $price = document.querySelector('.buy .payment-info .buy-products>li .price');

totPrice = parseInt($regularPrice.textContent) * parseInt($orderNum.textContent);

$price.textContent = totPrice;
*/

//오른쪽 사이드
//상품 금액
const $prodPrice = document.querySelector('.buy .buy-total .prodPrice');
$prodPrice.textContent = totPrice;

//배송비 유무에 따른 토탈 계산 함수
const calcFn = () => {
  
  if(totPrice<50000) {
    //상품금액이 50000원 미만인 경우
    $delivery.classList.remove('deleteline');
    totPrice += 2000; // +배송비
  }else{
    //상품금액이 50000원 이상인 경우 - 배송비 0원
    $delivery.classList.add('deleteline');
  }
  
  $totalPrice.textContent = totPrice;
}

calcFn();

//포인트 적립(10% 계산)
$point.textContent = parseInt($totalPrice.textContent)/10;

//보유 포인트, 포인트 입력값 숫자화 
const $havePointNum = parseInt($havePoint.textContent);
const $usePointInputNum =  parseInt($usePointInput.value);

//포인트 사용버튼 - 클릭 이벤트
$usePointBtn.addEventListener('click', ()=>{
  //사용포인트가 빈 값일 경우
  if($usePointInput.value === null || $usePointInput.value === '' ){
    alert('사용하려는 포인트를 입력해 주세요.');
    $usePointInput.focus();
    return;
  }
  
  $usePointBtn.classList.toggle('active');

  //포인트 사용버튼 활성화 되어있을 때
  if($usePointBtn.classList.contains('active')){
    if($havePointNum < $usePointInputNum){
    //보유포인트가 사용포인트보다 작을 경우
    alert('보유한 포인트가 부족합니다. 다시 입력해 주세요.');
    $usePointInput.value = '';
    $usePointInput.focus();
    $usePointBtn.classList.remove('active');
    }else{
      //보유포인트가 사용포인트보다 클 경우
      $totalPrice.textContent = totPrice - parseInt($usePointInput.value);
    }
  }
});

//우편번호 API 이용 함수
function zipSearch() {
  new daum.Postcode({
      oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          let addr = ''; // 주소 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
          }
         
          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById('zipcode').value = data.zonecode;
          document.getElementById("basicAddress").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("address").focus();
      }
  }).open();
}

//결제 수단 - 클릭 이벤트
const $payBtns = document.querySelectorAll('.buy .payment-info .btns-pay>button');

let payNum = 0;

$payBtns.forEach(($payBtn, idx) => {
  $payBtn.addEventListener('click', ()=>{
      //다른 테두리 모두 지우기
      for(let i=0; i<$payBtns.length; i++){
        $payBtns[i].classList.remove('on');
      }
      $payBtn.classList.add('on');
      payNum = idx; //결제 페이지 액션 설정시 쿼리스트링으로 넣어주기
  });
});
