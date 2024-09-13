const $mainH3s = document.querySelectorAll(".mainContainer>h3");
const $mainLists = document.querySelectorAll(".mainContainer>.list");
const $listSeletors = document.querySelectorAll(".mainContainer > .listSeletor");

// 장바구니/관심목록 클릭시 화면에 표시/숨김
$mainH3s.forEach(($mainH3, idx) => {
    $mainH3.addEventListener('click', () => {
        if ($mainH3.classList.contains('visible')) {
            return;
        } else {
            $mainH3s[0].classList.remove('visible');
            $mainH3s[1].classList.remove('visible');
            $mainH3.classList.add('visible');

            $mainLists[0].classList.remove('visible');
            $mainLists[1].classList.remove('visible');
            $mainLists[idx].classList.add('visible');
			
			$listSeletors[0].classList.remove('visible');
			$listSeletors[1].classList.remove('visible');
			$listSeletors[idx].classList.add('visible');
        }
    });
});


// 장바구니/관심목록 페이지에서 보여줄 목록을 확인
const url = new URL(window.location.href);
const params = new URLSearchParams(url.search);
const pageVisible = params.get('pageVisible');

if(pageVisible==="cart"){
	$mainH3s[0].classList.remove('visible');
	$mainH3s[1].classList.remove('visible');
	$mainH3s[0].classList.add('visible');

	$mainLists[0].classList.remove('visible');
	$mainLists[1].classList.remove('visible');
	$mainLists[0].classList.add('visible');

	$listSeletors[0].classList.remove('visible');
	$listSeletors[1].classList.remove('visible');
	$listSeletors[0].classList.add('visible');
}else if(pageVisible==="wish"){
	$mainH3s[0].classList.remove('visible');
	$mainH3s[1].classList.remove('visible');
	$mainH3s[1].classList.add('visible');

	$mainLists[0].classList.remove('visible');
	$mainLists[1].classList.remove('visible');
	$mainLists[1].classList.add('visible');

	$listSeletors[0].classList.remove('visible');
	$listSeletors[1].classList.remove('visible');
	$listSeletors[1].classList.add('visible');
}



const $cartChkBoxs = document.querySelectorAll('.shoppingCart input[type=checkbox]');
const $cartChkPrinter = document.querySelector('.shoppingCart>.chkPrinter');
const $cartTotalPrice = document.querySelector('.shoppingCart>.chkPrinter>.totalPrice');

//장바구니 체크박스 선택시 선택된 모든 가격의 합 화면에 표시
$cartChkBoxs.forEach(($cartChkBox)=>{
    $cartChkBox.addEventListener('click',()=>{
        let totalprice = 0;
        let checked = false;
        for($cartChkBox of $cartChkBoxs) {
            if($cartChkBox.checked) {
                totalprice += parseInt($cartChkBox.nextElementSibling.nextElementSibling.lastElementChild.textContent);
                checked = true;
            }
        }

        //체크박스가 하나라도 체크되어 있다면 총금액목록 화면에 표시
        if(checked) {
            $cartChkPrinter.classList.add("checked");
        }
        //체크박스가 하나도 체크되어 있지않다면 총금액목록 화면에서 숨김
        if(!checked) {
            $cartChkPrinter.classList.remove("checked");
        }

        $cartTotalPrice.textContent = totalprice + "원";
    });
});


const $wishChkBoxs = document.querySelectorAll('.wishList input[type=checkbox]');
const $wishChkPrinter = document.querySelector('.wishList>.chkPrinter');
const $widhTotalPrice = document.querySelector('.wishList>.chkPrinter>.totalPrice');

//관심목록 체크박스 선택시 선택된 모든 가격의 합 화면에 표시
$wishChkBoxs.forEach(($wishChkBox)=>{
    $wishChkBox.addEventListener('click',()=>{
        let totalprice = 0;
        let checked = false;
        for($wishChkBox of $wishChkBoxs) {
            if($wishChkBox.checked) {
                totalprice += parseInt($wishChkBox.nextElementSibling.nextElementSibling.lastElementChild.textContent);
                checked = true;
            }
        }

        //체크박스가 하나라도 체크되어 있다면 총금액목록 화면에 표시
        if(checked) {
            $wishChkPrinter.classList.add("checked");
        }
        //체크박스가 하나도 체크되어 있지않다면 총금액목록 화면에서 숨김
        if(!checked) {
            $wishChkPrinter.classList.remove("checked");
        }

        $widhTotalPrice.textContent = totalprice + "원";
    });
});