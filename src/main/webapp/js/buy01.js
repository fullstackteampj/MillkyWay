//가격에 따른 포인트 적립 출력
const $totalPrice = document.querySelector('.buy .buy-total .totalPrice');
const $point = document.querySelector('.buy .buy-total .point');
const $delivery = document.querySelector('.buy .buy-total>li:nth-of-type(2)');//배송비 li

/*
도서 종류가 여러개 일 경우 합치는데... 바로 구매에선 필요없는..?
//도서별 권수
const $eachNums = document.querySelectorAll('.buy .payment-info .buy-products>li .eachNum'); 
const $totNum = document.querySelector('.buy .payment-info .totNum'); 

let totNum = 0;

//도서별 권수 합계
for(let i=0; i<$eachNums.length; i++){
  totNum += parseInt($eachNums[i].textContent);
}

$totNum.textContent = totNum;



//도서별 각각의 가격
const $booksPrice = document.querySelectorAll('.buy .payment-info .buy-products>li .price'); 

//도서별 가격 계산
const $regularPrices = document.querySelectorAll('.buy .payment-info .buy-products>li>h4>span'); 

for(let i=0; i<$regularPrices.length; i++){
  $booksPrice[i].textContent = parseInt($regularPrices[i].textContent) * parseInt($eachNums[i].textContent);
}

//도서 결제 금액
let totPrice = 0;
for(let i=0; i<$booksPrice.length; i++){
  totPrice += parseInt($booksPrice[i].textContent);
}
*/

const $orderNum = document.querySelector('.buy .payment-info .buy-products>li .orderNum'); 
const $regularPrice = document.querySelector('.buy .payment-info .buy-products>li .regularPrice');
const $price = document.querySelector('.buy .payment-info .buy-products>li .price');


const $prodPrice = document.querySelector('.buy .buy-total .prodPrice');

let totPrice = parseInt($regularPrice.textContent) * parseInt($orderNum.textContent);

$price.textContent = totPrice;
$prodPrice.textContent = totPrice;


//토탈 계산 함수
const calcFn = () => {
  
  if(totPrice<50000) {
    $delivery.classList.remove('deleteline');
    totPrice += 2000;
  }else{
    $delivery.classList.add('deleteline');
  }
  
  $totalPrice.textContent = totPrice;
}

calcFn();

//포인트 적립
$point.textContent = parseInt($totalPrice.textContent)/10;

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
