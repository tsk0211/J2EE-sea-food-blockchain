var visibilityBtn= document.getElementById("visibilityBtn");

function visibilityFunc(x) {
    if (x.innerHTML === "visibility") {
        x.innerHTML = "visibility_off";
        document.getElementById("pw1").type = "password";
    } else {
        x.innerHTML = "visibility";
        document.getElementById("pw1").type = "text";
    }
}