
const $gnbMenus = document.querySelectorAll('.gnb>li>a');
const $slides = document.querySelectorAll('section>div');
const $h1 = document.querySelector('h1');

let nowIdx = 0;
let oldIdx = nowIdx;
$gnbMenus.forEach(($gnbMenu, idx) => {
    $gnbMenu.addEventListener('click', (evt) => {
        evt.preventDefault();

        oldIdx = nowIdx;
        nowIdx = idx;
        $gnbMenus[oldIdx].classList.remove('on');
        $gnbMenus[nowIdx].classList.add('on');

    });
});

const $recommendFrame = document.querySelector('.recommendSlide>.frame');
const $recommendPrev = document.querySelector('.recommendSlide>.prev');
const $recommendNext = document.querySelector('.recommendSlide>.next');

$recommendPrev.addEventListener('click', (evt) => {
    evt.preventDefault();

    $recommendFrame.style.marginLeft = 0 + 'px';
});

$recommendNext.addEventListener('click', (evt) => {
    evt.preventDefault();

    $recommendFrame.style.marginLeft = -1200 + 'px';
});

const $pointers = document.querySelectorAll('.bookCard .pointer');
const $addCartContainers = document.querySelectorAll('.bookCard .addCartContainer');

$pointers.forEach(($pointer,idx)=>{
    $pointer.firstElementChild.addEventListener('click',()=>{
        $pointer.firstElementChild.style.display = "none";
        $pointer.lastElementChild.style.display = "block";
        $addCartContainers[idx].style.display = "block";
    });
});

$pointers.forEach(($pointer,idx)=>{
    $pointer.lastElementChild.addEventListener('click',()=>{
        $pointer.lastElementChild.style.display = "none";
        $pointer.firstElementChild.style.display = "block";
        $addCartContainers[idx].style.display = "none";
    });
});