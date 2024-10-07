//가격에 따른 포인트 적립 출력
const $totalPrice = document.querySelector('.buy .buy-total .totalPrice');
const $point = document.querySelector('.buy .buy-total .point');
const $delivery = document.querySelector('.buy .buy-total>li:nth-of-type(2)');//배송비 li
const $usePointBtn = document.querySelector('.buy .buy-total .usePointBtn');
const $usePointInput = document.querySelector('.buy .buy-total input[name=usePoint]');
const $havePoint = document.querySelector('.buy .buy-total .havePoint');

const $orderNums = document.querySelectorAll('.buy .updown-qty>input');
const $orderUps = document.querySelectorAll('.buy .btn-updown>button:first-child');
const $orderDowns = document.querySelectorAll('.buy .btn-updown>button:last-child');

//도서별 권수
const $eachNums = document.querySelectorAll('.buy .payment-info .buy-products>li input[name=eachNum]'); 
const $totNum = document.querySelector('.buy .payment-info .totNum'); //총 ~권
 

//도서별 가격 계산
const $regularPrices = document.querySelectorAll('.buy .payment-info .buy-products>li>h4>span'); //정가

//오른쪽 사이드
//상품 금액
const $prodPrice = document.querySelector('.buy .buy-total .prodPrice');


let totPrice = 0;

//도서별 권수 합계 구하는 함수
const totalBooksCount = () => {
  let totNum = 0;
  for(let i=0; i<$eachNums.length; i++){
    totNum += parseInt($eachNums[i].value);
  }
  
  $totNum.textContent = totNum;
}//totalBooksCount()

//도서별 가격 계산 함수
const eachBooksPrice = () => {
  //도서별 각각의 권수에 따른 가격 - 배열 저장
  const $booksPrice = document.querySelectorAll('.buy .payment-info .buy-products>li .price');
  for(let i=0; i<$regularPrices.length; i++){
    $booksPrice[i].textContent = parseInt($regularPrices[i].textContent) * parseInt($eachNums[i].value); 
    //도서별 총금액 = 도서별 정가 * 도서별 권수 
  }//for
}//eachBooksPrice()

//총 도서 결제 금액 구하는 함수
const totalBooksPrice = () => {
  const $booksPrice = document.querySelectorAll('.buy .payment-info .buy-products>li .price');
  let totPrice = 0;
  for(let i=0; i<$booksPrice.length; i++){
    //총 도서 결제 금액 = 도서별 총금액 누적합계
    totPrice += parseInt($booksPrice[i].textContent);
  }

  $prodPrice.textContent = totPrice;
}//totalBooksPrice()

//배송비 유무에 따른 토탈 계산 함수
const calcFn = () => {
  totPrice = parseInt($prodPrice.textContent);
  if(totPrice<50000) {
    //상품금액이 50000원 미만인 경우
    $delivery.classList.remove('deleteline');
    totPrice += 2000; // +배송비
  }else{
    //상품금액이 50000원 이상인 경우 - 배송비 0원
    $delivery.classList.add('deleteline');
  }
  
  $totalPrice.textContent = totPrice;
  //포인트 적립(10% 계산)
  $point.textContent = parseInt($totalPrice.textContent)/10;
}//calcFn()

totalBooksCount();
eachBooksPrice();
totalBooksPrice();
calcFn();

//도서별 (+)버튼 - 클릭이벤트
$orderUps.forEach(($up, idx) => {
  $up.addEventListener('click', ()=>{
    let eachNum = parseInt($orderNums[idx].value);
    if(eachNum<20){
      eachNum++;
      $orderNums[idx].value = eachNum;
    }else{
      alert('1인당 최대 20권까지 구매 가능합니다.');
    }

    totalBooksCount();
    eachBooksPrice();
    totalBooksPrice();
    calcFn();
  });
});

//도서별 (-)버튼 - 클릭이벤트
$orderDowns.forEach(($down, idx) => {
  $down.addEventListener('click', ()=>{
    let eachNum = parseInt($orderNums[idx].value);
    if(eachNum === 1){
      $orderNums[idx].value = 1;
    }else{
      eachNum--;
      $orderNums[idx].value = eachNum;
    }

    totalBooksCount();
    eachBooksPrice();
    totalBooksPrice();
    calcFn();
  });
});


//보유 포인트, 포인트 입력값 숫자화 
const havePointNum = parseInt($havePoint.textContent);


//포인트 사용버튼 - 클릭 이벤트
$usePointBtn.addEventListener('click', ()=>{
  //버튼 클릭시점의 input 값 가져와야함 - 내부에 선언
  const usePointInputNum =  parseInt($usePointInput.value);
 
  //사용포인트가 빈 값일 경우(유효성검사)
  if($usePointInput.value === null || $usePointInput.value === '' ){
    alert('사용하려는 포인트를 입력해 주세요.');
    $usePointInput.focus();
    return;
  }//if

  $usePointBtn.classList.toggle('active');

  totPrice = parseInt($prodPrice.textContent);

  //보유포인트가 사용포인트보다 작을 때
  if(havePointNum < usePointInputNum){
    //포인트 사용버튼 활성화 되어있는 경우
    if($usePointBtn.classList.contains('active')){
      alert('보유한 포인트가 부족합니다. 다시 입력해 주세요.');
      $usePointInput.value = '';
      $usePointInput.focus();
      $usePointBtn.classList.remove('active');
      return;
    }
  }else{
    //사용버튼 활성화 상태
    if( $usePointBtn.classList.contains('active')){
      //보유포인트가 사용포인트보다 클 경우 - 포인트 사용 가능 상태
      let minusPoint = totPrice - parseInt($usePointInput.value);
      $havePoint.textContent = havePointNum - parseInt($usePointInput.value);
      
      if(totPrice<50000) {
        //상품금액이 50000원 미만인 경우
        $delivery.classList.remove('deleteline');
        minusPoint += 2000; // +배송비
      }else{
        //상품금액이 50000원 이상인 경우 - 배송비 0원
        $delivery.classList.add('deleteline');
      }
      
      $totalPrice.textContent = minusPoint;
      //포인트 적립(10% 계산)
      $point.textContent = parseInt($totalPrice.textContent)/10;
    }else{
      $havePoint.textContent = havePointNum;
      totalBooksPrice();
      calcFn();
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

//결제 수단 버튼들
const $payBtns = document.querySelectorAll('.buy .payment-info .btns-pay>button');
let payment = null;

$payBtns.forEach($payBtn => {
  //처음 기본 설정값 세팅
  if($payBtn.classList.contains('on')) {
    payment = $payBtn.textContent;

    const $input = document.createElement('input');
      $input.setAttribute('type', 'hidden');
      $input.setAttribute('name', 'payMethod');
      $input.setAttribute('class', 'payMethod');
      $input.setAttribute('value', payment);
      document.buyFrm.appendChild($input);
  }
  //버튼 - 클릭 이벤트
  $payBtn.addEventListener('click', ()=>{
      //다른 테두리 모두 지우기
      for(let i=0; i<$payBtns.length; i++){
        $payBtns[i].classList.remove('on');
      }

      $payBtn.classList.add('on');

      if(document.querySelector('.payMethod') !== null){
        //이미 존재하는 .payMethod가 있다면 - 전부 삭제
        document.querySelector('.payMethod').remove();
      }

      //결제 수단 버튼 값 - input:hidden 태그 생성해서 데이터 전달
      payment = $payBtn.textContent;

      const $input = document.createElement('input');
      $input.setAttribute('type', 'hidden');
      $input.setAttribute('name', 'payMethod');
      $input.setAttribute('class', 'payMethod');
      $input.setAttribute('value', payment);
      document.buyFrm.appendChild($input);

  });
});



//buyFrm - submit 이벤트(required 활용 가능)
document.buyFrm.addEventListener('submit', (evt)=>{
  evt.preventDefault(); 
  //api로 구현한 결제 수단
  if(payment === '카카오페이') reqKakaoPay();
  if(payment === '네이버페이') reqNaverPay();
});

