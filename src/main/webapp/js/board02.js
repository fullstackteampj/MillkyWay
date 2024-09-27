// 비로그인 상태일 때 글쓰기 제한
function goLogin() {
	const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?");
	if(result) {
		location.href = "../login/login01";
	}
}

// 페이지버튼 href로 실행되는 함수 : 현재 글페이지값, 글검색값 등의 값을 전송하는 폼 submit
function goPageFn(page) {
	document.pageFrm.nowPage.value = page;
	document.pageFrm.submit();
}

// 시각데이터 가공('10'미만일시 '06'와 같은 형태)
function zeroDate(thing) {
	let obj;
	if(thing == 'month') {
		obj = new Date().getMonth()+1;
	}
	if(thing == 'date') {
		obj = new Date().getDate();
	}
	if(thing == 'hours') {
		obj = new Date().getHours();
	}
	if(thing == 'minutes') {
		obj = new Date().getMinutes();
	}
	if(thing == 'seconds') {
		obj = new Date().getSeconds();
	}
	return obj < 10 ? '0'+obj : obj;
}

// 댓글 작성
async function comSubmit(userid, nickname, boardid, userip, start, end) {
	// 댓글작성 유효성 검사
	const frm = document.commentFrm;
	if(frm.inputComment.value == "" || frm.inputComment.value == null) {
		alert("내용을 입력해주세요.");
		frm.inputComment.focus();
		return;
	}
	
	// 댓글 줄바꿈 처리
	const commentMsg = frm.inputComment.value.replace(/\n/g, '<br>');
	
	// 날짜 데이터
	const regdate = new Date().getFullYear() + '-' + zeroDate('month') + '-' + zeroDate('date') + ' ' + zeroDate('hours') + ':' + zeroDate('minutes') + ':' + zeroDate('seconds');

	// 보낼 데이터를 객체로 묶음
	const commentData = {
		userid,
		nickname,
		boardid,
		userip,
		commentMsg,
		regdate,
		start,
		end
	}
	
	// 댓글 비동기 요청
	await fetch('boardComment', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(commentData)
	})
	
	.then(response => response.text())
	.then(data => {
		// commentCont에 요소비우기
		 const $commentBox = document.getElementById('commentBox');
		 const $commentCont = document.getElementById('commentCont');
		 while($commentCont.firstChild)  {
			$commentCont.removeChild($commentCont.firstChild);
		}
		
		// contentbox에 요소채우기
		$commentBox.innerHTML = data;
		// console.log(data);
	})
	.catch(error => {
		console.error(error);
	})
}

// 답글 작성
async function replySubmit(commentid, userid, nickname, boardid, userip, parentid, depth, pos, start, end) {
	// 유효성 검사
	const comment = document.querySelector('.comid-'+commentid);
	const frm = comment.nextElementSibling.nextElementSibling;
	if(frm.inputComment.value == "" || frm.inputComment.value == null) {
		alert("내용을 입력해주세요.");
		frm.inputComment.focus();
		return;
	}

	// 댓글 줄바꿈 처리
	const commentMsg = frm.inputComment.value.replace(/\n/g, '<br>');

	// 날짜 데이터
	const regdate = new Date().getFullYear() + '-' + zeroDate('month') + '-' + zeroDate('date') + ' ' + zeroDate('hours') + ':' + zeroDate('minutes') + ':' + zeroDate('seconds');

	// 보낼 데이터를 객체로 묶음
	const commentData = {
		userid,
		nickname,
		boardid,
		userip,
		commentMsg,
		regdate,
		parentid,
		depth,
		pos,
		start,
		end
	}

	// 답글 비동기 요청
	await fetch('boardCommentReply', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(commentData)
	})

	.then(response => response.text())
	.then(data => {
		// commentCont에 요소비우기
		 const $commentBox = document.getElementById('commentBox');
		 const $commentCont = document.getElementById('commentCont');
		 while($commentCont.firstChild)  {
			$commentCont.removeChild($commentCont.firstChild);
		}
		
		// contentbox에 요소채우기
		$commentBox.innerHTML = data;
	})
	.catch(error => {
		console.error(error);
	})
	
}

// 댓글 수정
async function editSubmit(commentid, userid, nickname, boardid, userip, start, end) {
	
	// 유효성 검사
	const comment = document.querySelector('.comid-'+commentid);
		const frm = comment.nextElementSibling;
		if(frm.inputComment.value == "" || frm.inputComment.value == null) {
			alert("내용을 입력해주세요.");
			frm.inputComment.focus();
			return;
		}
	
	// 댓글 줄바꿈 처리
	const commentMsg = frm.inputComment.value.replace(/\n/g, '<br>');

	// 날짜 데이터
	const updatedate = new Date().getFullYear() + '-' + zeroDate('month') + '-' + zeroDate('date') + ' ' + zeroDate('hours') + ':' + zeroDate('minutes') + ':' + zeroDate('seconds');

	// 보낼 데이터를 객체로 묶음
	const commentData = {
		commentid,
		userid,
		nickname,
		boardid,
		userip,
		commentMsg,
		updatedate,
		start,
		end
	}

	// 수정 비동기 요청
	await fetch('boardCommentEdit', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(commentData)
	})

	.then(response => response.text())
	.then(data => {
		// commentCont에 요소비우기
		 const $commentBox = document.getElementById('commentBox');
		 const $commentCont = document.getElementById('commentCont');
		 while($commentCont.firstChild)  {
			$commentCont.removeChild($commentCont.firstChild);
		}
		
		// contentbox에 요소채우기
		$commentBox.innerHTML = data;
		// console.log(data);
	})
	.catch(error => {
		console.error(error);
	})
}

// 댓글삭제
async function commentDelete(commentid, userid, boardid, start, end) {
	const confirmtrue = confirm("삭제된 댓글은 복구할 수 없습니다.\n댓글을 삭제 하시겠습니까?");
	
		if(confirmtrue) {
			// 날짜 데이터
			const deldate = new Date().getFullYear() + '-' + zeroDate('month') + '-' + zeroDate('date') + ' ' + zeroDate('hours') + ':' + zeroDate('minutes') + ':' + zeroDate('seconds');

			// 보낼 데이터를 객체로 묶음
			const commentData = {
				commentid,
				userid,
				boardid,
				deldate,
				start,
				end
			}
			
			// 삭제 비동기 요청
			await fetch('boardCommentDel', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(commentData)
			})

			.then(response => response.text())
			.then(data => {
				// commentCont에 요소비우기
				 const $commentBox = document.getElementById('commentBox');
				 const $commentCont = document.getElementById('commentCont');
				 while($commentCont.firstChild)  {
					$commentCont.removeChild($commentCont.firstChild);
				}
				
				// contentbox에 요소채우기
				$commentBox.innerHTML = data;
				// console.log(data);
			})
			.catch(error => {
				console.error(error);
			})
		}
}

// 글 추천 비동기요청
async function uplike(boardid, userid, element) {
	const response = await fetch('uplike', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: 'ref=' + boardid + '&userid=' + userid
	});
	
	if(response.ok) {
		const result = await response.json();
		const likeCountElement = element.firstElementChild;
		likeCountElement.textContent = result.liked;
	} else {
		alert("추천은 한 게시물에 한 번만 가능합니다.");
	}
}

// 답글버튼 클릭시 대댓글 폼 노출
function toggleReply(element) {
	const $replyFrm = element.parentElement.parentElement.parentElement.parentElement.nextElementSibling.nextElementSibling;
	$replyFrm.classList.toggle('off');
	$replyFrm.inputComment.value = '';
	$replyFrm.inputComment.focus();
}

// 수정버튼 클릭시 댓글수정 폼 노출
function toggleEdit(element) {
	const $editFrm = element.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
	$editFrm.classList.toggle('off');
	$editFrm.inputComment.value = $editFrm.inputComment.textContent;
	$editFrm.inputComment.focus();
}

// 답댓글 들여쓰기
const replys = document.querySelectorAll('.depth');
replys.forEach((reply) => {
	const depthClass = reply.classList.item(4);
	const depth = depthClass.substring(6,depthClass.length+1);
	console.log(depth)
	
	// 댓글창이 너무 작아지지 않도록 16번째 대댓부턴 들여쓰기 제한
	if(depth <= 16) {
		reply.style.marginLeft = '30'*depth+'px';      
	} else {
		reply.style.marginLeft = '30'*16+'px';
	}
})
	


