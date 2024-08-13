const btn= document.querySelector(".menuIcon");
const menu= document.querySelector(".dropdown_menu");
var isOpen= false;

btn.onclick = function() {
    menu.classList.toggle("open");
    isOpen= menu.classList.contains("open")
    btn.innerHTML= isOpen ? "close" : "menu";
}