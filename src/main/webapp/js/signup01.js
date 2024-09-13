const $agreement = document.querySelector('.sign-up .agreement');
const $progress = $agreement.previousElementSibling;
const $enterInfo = $agreement.nextElementSibling;
const $finish = $enterInfo.nextElementSibling;

//모두 체크
const $allCheck = document.querySelector('.sign-up #allAgree');

const $agreeChks = document.querySelectorAll('.sign-up .agreement input');

//모두 동의 체크박스 - 클릭이벤트
$allCheck.addEventListener('click', ()=>{
  const allChecked = $allCheck.checked;
  console.log(allChecked);
  if(allChecked){
    $agreeChks.forEach($agreeChk =>{
      $agreeChk.checked = true;
    })
  }else{
    $agreeChks.forEach($agreeChk =>{
      $agreeChk.checked = false;
    })
  }
});


const $enterInfoPrev = document.querySelector('.sign-up .enterInfoPrev');

$enterInfoPrev.addEventListener('click', ()=>{
  if(confirm('입력하신 정보가 모두 지워집니다. 뒤로 가시겠습니까?')){
    $agreement.classList.remove('hide');
    $enterInfo.classList.remove('on');
    $progress.classList.remove('next-stage');
  }
});


//회원정보 입력시 게이지
if($enterInfo.classList.contains('on')){
  $progress.classList.add('next-stage');
}

//agreeFrm 유효성 검사
const $agreeFrm = $agreement.children[1];
const $agreementNext = document.querySelector('.sign-up form>.btns>button:last-child');

//약관동의 다음으로 버튼 - 클릭이벤트
$agreementNext.addEventListener('click', (evt)=>{
  evt.preventDefault();

  //클릭시 체크박스 상태 변수 저장
  const signupWant = document.getElementById('signupWant').checked;
  const signupLucky = document.getElementById('signupLucky').checked;

  //필수 약관 동의 체크박스 2개
  if(!signupWant || !signupLucky){
    alert('필수 체크 항목을 체크해 주세요~!');
    return;
  }else{
    $agreement.classList.add('hide');
    $enterInfo.classList.add('on');
    $progress.classList.add('next-stage');
  }

});

//signupFrm 유효성 검사
const $signupFrm = document.querySelector('.sign-up form[name=signupFrm]');
const $userId = document.getElementById('userId');
const $pwd = document.querySelector('.sign-up input[name=userPwd]');
const $repwd = document.querySelector('.sign-up input[name=userRepwd]');
const $userEmail = document.getElementById('userEmail');

const $remainSec = document.querySelector('.sign-up .finish>p>span');


//폼 submit 이벤트
$signupFrm.addEventListener('submit', (evt)=>{

  evt.preventDefault();

  //유효성 검사
  //아이디,이메일 @형식 확인
  const validText = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

   if(!validText.test($userId.value)){
    alert('아이디를 이메일 형식으로 입력해 주세요.\n ex) abdc77@naver.com');
    $userId.value = '';
    $userId.focus();
    return;
   }
   if($userEmail.value!=='' && !validText.test($userEmail.value)){
    alert('이메일 형식이 올바르지 않습니다.\n다시 확인해주세요.');
    $userEmail.value='';
    $userEmail.focus();
    return;
   }
  //비밀번호
  if($pwd.value !== $repwd.value){
    alert('비밀번호와 비밀번호 재확인 값이 다릅니다. 다시 확인해주세요.');
    $pwd.value = '';
    $repwd.value = '';
    $pwd.focus();
    return;
  }
  

  //회원가입 완료 화면 출력
  $progress.classList.add('complete');

  $enterInfo.classList.remove('on');
  $finish.classList.add('on');
  
  //5초 뒤 메인 페이지 이동
  let sec = 5;
  $remainSec.textContent = sec;
  const intervalKey = setInterval(()=>{
    sec--;
    $remainSec.textContent = sec;
    if(sec===0) {
      clearInterval(intervalKey);
      /***  메인화면 파일명으로 수정 필요! ***/
      location.href = 'shop01.html';
    }
  }, 1000);


});

//아이디 중복체크 함수
/***파일명에 따라 url수정 필요***/
const idCheck = () => {
  const url = "/signup/signup02";
  window.open(url, "IDCheck", "width=400, height=300");
}

//우편번호 검색 함수
/***파일명에 따라 url수정 필요***/
const zipSearch = () => {
  const url = "/signup/signup03";
		window.open(url, "ZipCodeSearch", "width=500, height=400");
}

//별명 중복체크 함수
const nicknameCheck = () => {
  const url = "/signup/signup04";
  window.open(url, "IDCheck", "width=400, height=300");
}

//이메일-아이디 동일 버튼
const $idEqual = $userEmail.nextElementSibling;

$idEqual.addEventListener('click', ()=>{
  $userEmail.value = $userId.value;
});




