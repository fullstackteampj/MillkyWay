// 스크롤감지
let nowScr = document.documentElement.scrollTop;
window.addEventListener('scroll', ()=>{
	nowScr = document.documentElement.scrollTop;
});

// 댓글 페이징요청 시 댓글박스 상단으로 스크롤
function scrollFn(element) {
	const $commentBox = document.getElementById('commentBox');
	const $postBox = document.getElementById('postBox');
	
	const pageY = window.pageYOffset;
	const commentBoxRect = $commentBox.getBoundingClientRect();
	const commentBoxTop = pageY + commentBoxRect.top;
	
	const postBoxRect = $postBox.getBoundingClientRect();
	const postBoxTop = pageY + postBoxRect.top;
	
	// 스크롤감지 헤더 높이에 따라
	// 현재 스크롤높이를 기준으로 스크롤업 되어야할시 더 낮은값으로 스크롤
	const scrollValue = nowScr > commentBoxTop ? commentBoxTop-130 : commentBoxTop-60;
	
	// 댓글 바로가기 버튼/새댓글 작성/본문 바로가기 버튼/페이징
	if(element === 'button') {
		window.scrollTo({ top: scrollValue, behavior: 'smooth' });		
	} else if(element === 'newCom') {
		window.scrollTo(0, document.body.scrollHeight-1000);
	} else if(element === 'post') {
		window.scrollTo({ top: postBoxTop-130, behavior: 'smooth' });
	} else {
		window.scrollTo(0, scrollValue);
	}
}

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
	const now = new Date();
	let obj;
	if(thing == 'month')
		obj = now.getMonth()+1;
	if(thing == 'date')
		obj = now.getDate();
	if(thing == 'hours')
		obj = now.getHours();
	if(thing == 'minutes')
		obj = now.getMinutes();
	if(thing == 'seconds')
		obj = now.getSeconds();
	return obj < 10 ? '0'+obj : obj;
}

// 댓글 작성
async function comSubmit(userid, nickname, boardid, userip) {
	
	const nowPage = 1;
	const numPerPage = 10;
	const start = (nowPage-1)*numPerPage;
	const end = numPerPage;
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
		nowPage,
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
	
	// 스크롤 맨아래로
	// scrollFn("newCom");
}

// 답글 작성
async function replySubmit(commentid, userid, nickname, boardid, userip, parentid, depth, pos, end, nowBlock, nowPage, pagePerBlock, totalPage) {

	// 페이지 유지
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock) <= totalPage) ?  (pageStart + pagePerBlock) : totalPage+1;
	const start = (nowPage-1)*end;

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
		end,
		pageStart,
		pageEnd,
		nowBlock,
		nowPage
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
async function editSubmit(commentid, userid, nickname, boardid, userip, end, comUserid, nowBlock, nowPage, pagePerBlock, totalPage) {
	
	// 페이지 유지
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock) <= totalPage) ?  (pageStart + pagePerBlock) : totalPage+1;
	const start = (nowPage-1)*end;
	
	// 유효성 검사
	const comment = document.querySelector('.comid-'+commentid);
	const frm = comment.nextElementSibling;
	if(frm.inputComment.value == "" || frm.inputComment.value == null) {
		alert("내용을 입력해주세요.");
		frm.inputComment.focus();
		return;
	}
	
	// 권한 검사
	if(userid !== comUserid) {
		alert("권한이 없습니다.");
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
		end,
		pageStart,
		pageEnd,
		nowBlock,
		nowPage
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
	})
	.catch(error => {
		console.error(error);
	})
}

// 댓글삭제
async function commentDelete(commentid, userid, pos, boardid, end, comUserid, nowBlock, nowPage, pagePerBlock, totalPage) {

	// 페이지 유지
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock) <= totalPage) ?  (pageStart + pagePerBlock) : totalPage+1;
	const start = (nowPage-1)*end;
	
	const confirmtrue = confirm("삭제된 댓글은 복구할 수 없습니다.\n댓글을 삭제 하시겠습니까?");
		if(confirmtrue) {
			
			// 권한 검사
			if(userid !== comUserid) {
				alert("권한이 없습니다.");
				return;
			}
			
			// 날짜 데이터
			const deldate = new Date().getFullYear() + '-' + zeroDate('month') + '-' + zeroDate('date') + ' ' + zeroDate('hours') + ':' + zeroDate('minutes') + ':' + zeroDate('seconds');

			// 보낼 데이터를 객체로 묶음
			const commentData = {
				commentid,
				userid,
				pos,
				boardid,
				deldate,
				start,
				end,
				pageStart,
				pageEnd,
				nowBlock,
				nowPage
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
	// 다른 열려있는 폼 닫음
	const otherFrms = document.querySelectorAll('#commentCont form');
	otherFrms.forEach((otherFrm)=>{
		otherFrm.classList.add('off');
	})
	
	// 해당 댓글의 대댓폼 노출
	const $replyFrm = element.parentElement.parentElement.parentElement.parentElement.nextElementSibling.nextElementSibling;
	$replyFrm.classList.toggle('off');
	
	// 내용초기화 및 포커스
	$replyFrm.inputComment.value = '';
	$replyFrm.inputComment.focus();
	
}

// 수정버튼 클릭시 댓글수정 폼 노출
function toggleEdit(element) {
	// 다른 열려있는 폼 닫음
	const otherFrms = document.querySelectorAll('#commentCont form');
	otherFrms.forEach((otherFrm)=>{
		otherFrm.classList.add('off');
	})
	
	// 해당 댓글의 수정폼 노출
	const $editFrm = element.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
	$editFrm.classList.toggle('off');
	
	// 내용초기화 및 포커스
	$editFrm.inputComment.value = $editFrm.inputComment.textContent;
	$editFrm.inputComment.focus();
}

// 답댓글 들여쓰기
const replys = document.querySelectorAll('.depth');
replys.forEach((reply) => {
	const depthClass = reply.classList.item(4);
	const depth = depthClass.substring(6,depthClass.length+1);
	
	// 댓글창이 너무 작아지지 않도록 16번째 대댓부턴 들여쓰기 제한
	if(depth <= 16) {
		reply.style.marginLeft = '30'*depth+'px';      
	} else {
		reply.style.marginLeft = '30'*16+'px';
	}
})

// 댓글 페이징 비동기요청
async function goComPage(boardid, nowBlock, pagePerBlock, totalPage, nowPage, end) {

	// 댓글박스 상단으로 스크롤
	scrollFn();
	
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock) <= totalPage) ?  (pageStart + pagePerBlock) : totalPage+1;
	const start = (nowPage-1)*end;
	

	// 보낼 데이터를 객체로 묶음
	const commentData = {
		boardid,
		start,
		end,
		pageStart,
		pageEnd,
		nowBlock,
		nowPage
	}
	
	await fetch('commentPaging', {
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

// 댓글 페이징 다음 블럭으로 요청
async function goNextBlock(boardid, nowBlock, pagePerBlock, totalPage, end) {
	
	// 댓글박스 상단으로 스크롤
	scrollFn();
	
	nowBlock = nowBlock+1;
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
	const nowPage = pageStart;
	const start = (nowPage-1)*end;

	// 보낼 데이터를 객체로 묶음
	const commentData = {
		boardid,
		start,
		end,
		pageStart,
		pageEnd,
		nowBlock,
		nowPage
	}
	
	await fetch('commentGoBlock', {
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

// 댓글 페이징 이전 블럭으로 요청
async function goPrevBlock(boardid, nowBlock, pagePerBlock, totalPage, end) {

	// 댓글박스 상단으로 스크롤
	scrollFn();
	
	nowBlock = nowBlock-1;
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
	const nowPage = pageEnd-1;
	const start = (nowPage-1)*end;
	
	// 보낼 데이터를 객체로 묶음
	const commentData = {
		boardid,
		start,
		end,
		pageStart,
		pageEnd,
		nowBlock,
		nowPage
	}
	
	await fetch('commentGoBlock', {
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

// 댓글 페이징 마지막페이지로 요청
async function goLastPage(boardid, nowBlock, pagePerBlock, totalPage, end) {

	// 댓글박스 상단으로 스크롤
	scrollFn();
	
	const totalBlock = Math.ceil(totalPage / pagePerBlock);
	nowBlock = totalBlock;
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
	const nowPage = totalPage;
	const start = (nowPage-1)*end;
	
	// 보낼 데이터를 객체로 묶음
	const commentData = {
		boardid,
		start,
		end,
		pageStart,
		pageEnd,
		nowBlock,
		nowPage
	}
	
	await fetch('commentGoBlock', {
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

// 댓글 페이징 첫번째페이지로 요청
async function goFirstPage(boardid, nowBlock, pagePerBlock, totalPage, end) {

	// 댓글박스 상단으로 스크롤
	scrollFn();
	
	nowBlock = 1;
	const pageStart = (nowBlock-1)*pagePerBlock+1;
	const pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
	const nowPage = 1;
	const start = (nowPage-1)*end;
	
	// 보낼 데이터를 객체로 묶음
	const commentData = {
		boardid,
		start,
		end,
		pageStart,
		pageEnd,
		nowBlock,
		nowPage
	}
	
	await fetch('commentGoBlock', {
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

