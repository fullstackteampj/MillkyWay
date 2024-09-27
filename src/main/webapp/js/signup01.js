const $agreement = document.querySelector('.sign-up .agreement');

//모두 체크
const $allCheck = document.querySelector('.sign-up #allAgree');

//약관 동의 안에 모든 체크박스들
const $agreeChks = document.querySelectorAll('.sign-up .agreement input');

//모두 동의 체크박스 - 클릭이벤트
$allCheck.addEventListener('click', ()=>{
  
  const allChecked = $allCheck.checked;

  if(allChecked){
    //모두동의 체크된 경우
    $agreeChks.forEach($agreeChk =>{
      $agreeChk.checked = true;
    })
  }else{
    //모두동의 체크되지 않은 경우
    $agreeChks.forEach($agreeChk =>{
      $agreeChk.checked = false;
    })
  }
});

//agreeFrm 유효성 검사
const $agreeFrm = $agreement.children[1];
const $agreementNext = document.querySelector('.sign-up .agreementNext');


//약관동의 '다음으로' 버튼 - 클릭이벤트
$agreementNext.addEventListener('click', ()=>{

  //클릭시 체크박스 상태 변수 저장
  const essential1 = document.getElementById('essential1').checked;
  const essential2 = document.getElementById('essential2').checked;

  //필수 약관 동의 체크박스 2개
  if(!essential1 || !essential2){
    alert('필수 체크 항목을 체크해 주세요~!');
    return;
  }
});
