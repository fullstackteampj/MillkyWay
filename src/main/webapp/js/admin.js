

// 표지사진 선택 시, 선택한 이미지 미리보기
function previewImage(evt) {
    const img = document.querySelector('.topContainer > img');
    img.src = URL.createObjectURL(evt.target.files[0]);
}

// 수정/삭제 페이지에서 도서검색 시, 클릭하면 비동기로 기존 도서정보 출력
async function bookInfoFn(bookid, event) {
	// 보낼 데이터 객체화
	const bookData = {
		bookid,
		event
	};
	
	await fetch('bookInfoForm', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(bookData)
	})
	
	.then(response => response.text())
	.then(data => {
		// form에 요소비우기
		 const $section = document.querySelector('section');
		 const $bookInfoFrm = document.querySelector('section > form');
		 while($bookInfoFrm.firstChild)  {
			$bookInfoFrm.removeChild($bookInfoFrm.firstChild);
	 }
		// section에 요소채우기
		$section.innerHTML = data;
	})
	.catch(error => {
		console.error(error);
	})
 	//console.log('document.updateBookFrm.updateBookid.value = ' + document.updateBookFrm.updateBookid.value);
}

// 삭제버튼 누를 시 되묻기
function deleteWarning(element) {
	alert("삭제한 상품은 복구할 수 없습니다.\n정말 삭제하시겠습니까?");
	document.updateBookFrm.submit();
}