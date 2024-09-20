function goLogin() {
	const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?");
	if(result) {
		location.href = "../login/login01";
	}
}
	
function commentChk() {
	const frm = document.commentFrm;
	if(frm.inputComment.value == "" || frm.inputComment.value == null) {
		alert("내용을 입력해주세요.");
		frm.inputComment.focus();
		return;
	}
	
	frm.submit();
}

function uplike(boardid, element) {
	fetch('uplike', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: 'num=' + boardid
	})
	.then(response => response.json())
	.then(data => {
		const likeCountElement = element.firstElementChild;
		likeCountElement.textContent = data.liked;
	})
	.catch(error => {
		console.error("오류발생: ", error);
		alert("오류가 발생했습니다.");
	})
}