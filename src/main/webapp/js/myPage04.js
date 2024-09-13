

const $boardDowns = document.querySelectorAll(".controls>.fa-chevron-down");
const $boardUps = document.querySelectorAll(".controls>.fa-chevron-up");
const $contents = document.querySelectorAll(".boardContainer>.content");

//화살표 누를시 게시글 확장 표시 / 숨김
$boardDowns.forEach(($boardDown,idx)=>{
    $boardDown.addEventListener('click',()=>{
        $boardDowns[idx].classList.remove('on');
        $boardUps[idx].classList.add('on');
        $contents[idx].style.overflow = "initial";
        $contents[idx].style.whiteSpace = "initial";
        $contents[idx].style.textOverflow = "initial";
        $contents[idx].style.wordBreak = "initial";
    });
});

$boardUps.forEach(($boardUp,idx)=>{
    $boardUp.addEventListener('click',()=>{
        $boardUps[idx].classList.remove('on');
        $boardDowns[idx].classList.add('on');
        $contents[idx].style.overflow = "hidden";
        $contents[idx].style.whiteSpace = "nowrap";
        $contents[idx].style.textOverflow = "ellipsis";
        $contents[idx].style.wordBreak = "break-all";
    });
});