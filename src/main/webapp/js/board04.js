// 첨부파일 선택했을 때 선택된 파일 표시
const $uploadFile = document.getElementById('uploadFile');
const $uploadNameBox = document.getElementById('uploadName')

// input:file change이벤트
$uploadFile.addEventListener('change', ()=>{

  // 우선 기존선택파일 표시항목이 존재하면 전부지움(input:file은 파일 재선택 시 초기화됨)
  while($uploadNameBox.childElementCount > 0) {
    $uploadNameBox.removeChild($uploadNameBox.firstElementChild);
  }
  
  // input:file의 files마다 li생성 > 파일명삽입 반복문
  for(let i=0; i<$uploadFile.files.length; i++) {
    const $li = document.createElement('li');
    $li.textContent = $uploadFile.files[i].name;
    $uploadNameBox.append($li);
  }
})

// 도서검색 비동기요청
async function postBookSearchFn() {
	const bookSearchInput = document.querySelector('#postBookSearch');

	const searchVal = bookSearchInput.value;
	const sendData = {searchVal}
	await fetch('postBookSearch', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => response.text())
	.then(data => {
		// commentCont에 요소비우기
		 const $postBookFrm = document.getElementById('postBookFrm');
		 const $bookSearchList = document.getElementById('bookSearchList');
		 while($bookSearchList.firstChild)  {
			$bookSearchList.removeChild($bookSearchList.firstChild);
		}
		
		// contentbox에 요소채우기
		$postBookFrm.innerHTML = data;
	})
	.catch(error => {
		console.error(error);
	})

	// 인풋에 다시 focus
	const $searchInput = document.querySelector('#postBookSearch');
	$searchInput.focus();
}

