const $progress = document.querySelector('.sign-up .progress');
const $enterInfo = $progress.nextElementSibling;

//signupFrm 유효성 검사
const $signupFrm = document.querySelector('.sign-up form[name=signupFrm]');
const $account = document.getElementById('account');
const $pwd = document.getElementById('pwd');
const $repwd = document.getElementById('repwd');
const $nickname = document.getElementById('nickname');
const $email = document.getElementById('email');

//아이디 중복체크 클릭시 팝업창 열어주는 함수
const idCheck = (account) => {

  //팝업창 오픈 함수
  const openPopup = () => {
    const url = '/signup/signup04?account=' + account;
    window.open(url, "IDCheck", "width=400, height=300");
  }

  if(!validText.test($account.value) && $account.value!==''){
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
    
  openPopup();
  
}//end of idCheck()


//아이디 중복 체크 버튼 - 클릭이벤트 -> 함수 호출
$account.nextElementSibling.addEventListener('click', ()=>{
  idCheck($account.value);
});


//별명 중복체크 함수
const nicknameCheck = (nickname) => {
  //입력값 유효성 검사
  if(nickname === '' || nickname === null){
    alert('별명을 입력해 주세요.');
    $nickname.focus();
    return;
  }

  const url = "/signup/signup05?nickname=" + nickname;
  window.open(url, "nicknameCheck", "width=400, height=300");
  
}//end of nicknameCheck()

//별명 중복 체크 버튼 - 클릭이벤트 -> 함수 호출
$nickname.nextElementSibling.addEventListener('click', ()=>{
  nicknameCheck($nickname.value);
});

//이메일-아이디 동일 버튼
const $idEqual = $email.nextElementSibling;

$idEqual.addEventListener('click', ()=>{
  if($account.value === '' || $account.value === null){
    alert('아이디 입력창에 입력된 값이 없습니다. \n아이디를 입력해주세요.');
    $account.focus();
  }
  $email.value = $account.value;
});

//약관동의 '뒤로 가기' 버튼
const $enterInfoPrev = document.querySelector('.sign-up .enterInfoPrev');

$enterInfoPrev.addEventListener('click', ()=>{
  if(confirm('입력하신 정보가 모두 지워집니다. 뒤로 가시겠습니까?')){
    history.back();
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
          document.getElementById("address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("detailAddress").focus();
      }
  }).open();
}//zipSearch()

//비밀번호 보안 체크
const $pwdSecutity = $pwd.nextElementSibling;


$pwd.addEventListener('input', ()=>{
  
  const pwd = $pwd.value; //입력값 변경할때마다 값 받아야함
  //.test(): 문자열을 전달하면 문자열이 정규 표현식의 패턴과 일치하는지 알려주는지 불리언을 반환하는 메서드
  const hasLetter = /[a-zA-Z]/.test(pwd); //문자 체크
  const hasNumber = /[0-9]/.test(pwd); //숫자 체크
  const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pwd); // 특수문자 체크
  let securityLevel = '';

  $pwd.parentElement.classList.add('sec');

  if(pwd === null || pwd === ''){
    $pwd.parentElement.classList.remove('sec');
  }else{
    if(pwd.length < 8){
      securityLevel = '비밀번호를 최소한 8자리 이상 입력해주세요.';
    }else if(hasLetter && hasNumber && hasSpecial){
      securityLevel = '비밀번호 보안 : 높음';
    }else if(hasLetter && hasNumber || hasNumber && hasSpecial || hasLetter && hasSpecial){
      securityLevel = '비밀번호 보안 : 보통';
    }else{
      securityLevel = '비밀번호 보안 : 낮음';
    }
  }

  $pwdSecutity.textContent = securityLevel;
  
});
