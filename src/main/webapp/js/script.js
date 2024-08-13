var pass= document.getElementById("p1");
var cnfpass= document.getElementById("p2");
var sec= document.getElementById("passSec");
var submitBtn= document.getElementById("submitBtn");


function visibilityFunc1(x) {
    if (x.innerHTML === "visibility") {
        x.innerHTML = "visibility_off";
        document.getElementById("p1").type = "password";
    } else {
        x.innerHTML = "visibility";
        document.getElementById("p1").type = "text";
    }
}

function visibilityFunc2(x) {
    if (x.innerHTML === "visibility") {
        x.innerHTML = "visibility_off";
        document.getElementById("p2").type = "password";
    } else {
        x.innerHTML = "visibility";
        document.getElementById("p2").type = "text";
    }
}

function check() {
    if (pass.value === cnfpass.value) {
        sec.style.border = "3px solid #39FF14";
        submitBtn
    } else {
        sec.style.border = "3px solid #FF2400";
    }
}