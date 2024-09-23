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
  const essential1 = document.getElementById('essential1').checked;
  const essential2 = document.getElementById('essential2').checked;

  //필수 약관 동의 체크박스 2개
  if(!essential1 || !essential2){
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
const $account = document.getElementById('account');
const $pwd = document.querySelector('.sign-up input[name=pwd]');
const $repwd = document.querySelector('.sign-up input[name=repwd]');
const $nickname = document.getElementById('nickname');
const $email = document.getElementById('email');



//아이디,이메일 @형식 확인
const validText = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

//아이디 유효성 검사 함수
const idValidation = () => {
  if($account.value!=='' && !validText.test($account.value)){
    alert('아이디를 이메일 형식으로 입력해 주세요.\n ex) abdc77@naver.com');
    $account.value = '';
    $account.focus();
    return;
  }

  if($account.value === '' || $account.value === null){
    alert('아이디를 입력해 주세요.');
    $account.focus();
    return;
  }
}


//아이디 중복체크 함수
/***파일명에 따라 url수정 필요***/
const idCheck = (idKey) => {

  const frm = document.signupFrm;

  if($account.value!=='' && !validText.test($account.value)){
    alert('아이디를 이메일 형식으로 입력해 주세요.\n ex) abdc77@naver.com');
    $account.value = '';
    $account.focus();
    return;
  }

  if($account.value === '' || $account.value === null){
    alert('아이디를 입력해 주세요.');
    $account.focus();
    return;
  }
  

  //팝업창 오픈
  const url = '/signup/signup02?idKey=' + idKey;
  window.open(url, "IDCheck", "width=400, height=300");
}

//아이디 중복 체크 버튼 - 클릭이벤트
$account.nextElementSibling.addEventListener('click', ()=>{
  idCheck($account.value);
});

//우편번호 검색 함수
/***파일명에 따라 url수정 필요***/
// const zipSearch = () => {
//   const url = "/signup/signup03";
// 		window.open(url, "ZipCodeSearch", "width=500, height=400");
// }

//별명 중복체크 함수
const nicknameCheck = (nickname) => {
  //입력값 유효성 검사
  if(nickname === '' || nickname === null){
    alert('별명을 입력해 주세요.');
    $nickname.focus();
    return;
  }

  const url = "/signup/signup04?nickname=" + nickname;
  window.open(url, "IDCheck", "width=400, height=300");
}

//별명 중복 체크 버튼 - 클릭이벤트
$nickname.nextElementSibling.addEventListener('click', ()=>{
  nicknameCheck($nickname.value);
});

//이메일-아이디 동일 버튼
const $idEqual = $email.nextElementSibling;

$idEqual.addEventListener('click', ()=>{
  $email.value = $account.value;
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

/*************** 회원가입 DB 연결 시작 *******************/





