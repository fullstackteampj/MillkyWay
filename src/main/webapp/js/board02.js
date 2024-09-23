
// 비로그인 상태일 때 글쓰기 제한
function goLogin() {
	const result = confirm("로그인이 필요한 서비스 입니다.\n로그인 하시겠습니까?");
	if(result) {
		location.href = "../login/login01";
	}
}

// 시각데이터 가공('10'미만일시 '06'와 같은 형태)
function zeroDate(thing) {
	let obj;
	if(thing == 'month') {
		obj = new Date().getMonth();
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

// 댓글작성
async function comSubmit(userid, nickname, ref, userip, postuser) {
	// 댓글작성 유효성 검사
	const frm = document.commentFrm;
	if(frm.inputComment.value == "" || frm.inputComment.value == null) {
		alert("내용을 입력해주세요.");
		frm.inputComment.focus();
		return;
	}
	
	// 댓글작성 비동기 요청
	const commentMsg = frm.inputComment.value;
	
	const regdate = new Date().getFullYear() + '-' + zeroDate('month') + '-' + zeroDate('date') + ' ' + zeroDate('hours') + ':' + zeroDate('minutes') + ':' + zeroDate('seconds');
	const response = await fetch('boardComment', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded;'
		},
		body: 'userid='+userid+'&nickname='+nickname+'&ref='+ref+'&userip='+userip+'&commentMsg='+commentMsg+'&regdate='+regdate
	});
	
	if(response.ok) {
		const result = await response.json();
		const $commentCont = document.getElementById('commentCont');
		
		// 댓글 노드 생성
		const $comment = document.createElement('div');
		$comment.setAttribute('class','comment comment-'+ref);
		const $commentInfo = document.createElement('div');
		$commentInfo.setAttribute('class','commentInfo');
		const $author = document.createElement('span');
		if(userid == postuser) {
			$author.setAttribute('class','author same');	
		} else {
			$author.setAttribute('class','author');			
		}
		const $commentAdd = document.createElement('div');
		$commentAdd.setAttribute('class','commentAdd');
		const $commentDate = document.createElement('span');
		$commentDate.setAttribute('class','commentDate');
		const $authorAddOns = document.createElement('div');
		$authorAddOns.setAttribute('class','author-addOns');
		const $replyBtn = document.createElement('span');
		$replyBtn.setAttribute('onclick', 'toggleReply(this);');
		const $replyIcon = document.createElement('i');
		$replyIcon.setAttribute('class', 'fa-solid fa-reply');
		$replyIcon.setAttribute('title', '답글');
		const $editBtn = document.createElement('span');
		$editBtn.setAttribute('onclick', 'toggleEdit(this);');
		const $editIcon = document.createElement('i');
		$editIcon.setAttribute('class', 'fa-solid fa-pencil');
		$editIcon.setAttribute('title', '댓글수정');
		const $delBtn = document.createElement('span');
		const $delIcon = document.createElement('i');
		$delIcon.setAttribute('class', 'fa-solid fa-trash-can');
		$delIcon.setAttribute('title', '댓글삭제');
		
		const $commentMsg = document.createElement('div');
		$commentMsg.setAttribute('class', 'commentMsg');
		const $text = document.createElement('p');
		$text.setAttribute('class', 'text');
		
		// 댓글 노드 결합
		$commentCont.append($comment);
		$comment.append($commentInfo);
		$commentInfo.append($author);
		$author.textContent = nickname;
		$commentInfo.append($commentAdd);
		$commentAdd.append($commentDate);
		$commentDate.textContent = regdate;
		$commentAdd.append($authorAddOns);
		$authorAddOns.append($replyBtn);
		$replyBtn.append($replyIcon);
		$authorAddOns.append($editBtn);
		$editBtn.append($editIcon);
		$authorAddOns.append($delBtn);
		$delBtn.append($delIcon);
		
		$comment.append($commentMsg);
		$commentMsg.append($text);
		$text.textContent = result.commentMsg;

		// 수정폼 노드 생성
		const $editFrm = document.createElement('form');
		$editFrm.setAttribute('action', 'commentEdit');
		$editFrm.setAttribute('name', 'comEditFrm');
		$editFrm.setAttribute('id', 'comEditFrm');
		$editFrm.setAttribute('method', 'post');
		$editFrm.setAttribute('autocomplete', 'off');
		$editFrm.setAttribute('class', 'off');
		const $writeComment = document.createElement('div');
		$writeComment.setAttribute('id', 'writeComment');
		const $commentAuthor = document.createElement('p');
		$commentAuthor.setAttribute('class', 'commentAuthor');
		const $span = document.createElement('span');
		const $inputComment = document.createElement('textarea');
		$inputComment.setAttribute('name', 'inputComment');
		$inputComment.setAttribute('placeholder', '댓글을 작성해보세요!');
		const $replySubmit = document.createElement('button');
		$replySubmit.setAttribute('type', 'button');
		$replySubmit.setAttribute('onclick', 'replySubmit()');
		
		// 결합
		$commentCont.append($editFrm);
		$editFrm.append($writeComment);
		$writeComment.append($commentAuthor);
		$commentAuthor.append($span, nickname);
		$span.textContent = '수정';
		$writeComment.append($inputComment);
		$inputComment.textContent = result.commentMsg;
		$writeComment.append($replySubmit);
		$replySubmit.textContent = '수정';

		// 답글폼 노드 생성
		const $replyFrm = document.createElement('form');
		$replyFrm.setAttribute('action', 'commentReply');
		$replyFrm.setAttribute('name', 'replyFrm');
		$replyFrm.setAttribute('id', 'replyFrm');
		$replyFrm.setAttribute('method', 'post');
		$replyFrm.setAttribute('autocomplete', 'off');
		$replyFrm.setAttribute('class', 'off');
		const $rewriteComment = document.createElement('div');
		$rewriteComment.setAttribute('id', 'writeComment');
		const $recommentAuthor = document.createElement('p');
		$recommentAuthor.setAttribute('class', 'commentAuthor');
		const $respan = document.createElement('span');
		const $reinputComment = document.createElement('textarea');
		$reinputComment.setAttribute('name', 'inputComment');
		$reinputComment.setAttribute('placeholder', '답글을 작성해보세요!');
		const $editSubmit = document.createElement('button');
		$editSubmit.setAttribute('type', 'button');
		$editSubmit.setAttribute('onclick', 'replySubmit()');

		// 결합
		$commentCont.append($replyFrm);
		$replyFrm.append($rewriteComment);
		$rewriteComment.append($recommentAuthor);
		$recommentAuthor.append($respan, nickname);
		$respan.textContent = '답글';
		$rewriteComment.append($reinputComment);
		$rewriteComment.append($editSubmit);
		$editSubmit.textContent = '작성';
		
		frm.inputComment.value = '';
	} else {
		alert("댓글 작성에 실패했습니다.");
	}
}

// 답글버튼 클릭시 대댓글 폼 노출
function toggleReply(element) {
	console.log(element);
	const $replyFrm = element.parentElement.parentElement.parentElement.parentElement.nextElementSibling.nextElementSibling;
	$replyFrm.classList.toggle('off');
	$replyFrm.inputComment.focus();
}

// 답글 유효성검사 후 비동기요청
function replySubmit() {
	
}

// 수정버튼 클릭시 댓글수정 폼 노출
function toggleEdit(element) {
	const $editFrm = element.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
	$editFrm.classList.toggle('off');
	$editFrm.inputComment.focus();
}

// 수정 유효성검사 후 비동기요청
function editSubmit() {
	
}

// 댓글삭제 비동기요청
async function commentDelete(commentId, element) {
	const confirmtrue = confirm("삭제된 댓글은 복구할 수 없습니다.\n댓글을 삭제 하시겠습니까?");
		if(confirmtrue) {
			const response = await fetch('boardCommentDel', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded;'
				},
				body: 'commentId=' + commentId
			});
				
			if(response.ok) {
				//const deleteComment = element.parentElement.parentElement.parentElement.parentElement.lastElementChild;
				//deleteComment.textContent = '삭제된 댓글입니다.';
				const deleteComment = element.parentElement.parentElement.parentElement.parentElement;
				deleteComment.remove();
			}
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




