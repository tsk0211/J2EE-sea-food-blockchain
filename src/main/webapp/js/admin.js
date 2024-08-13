let nameTag= document.getElementById("nameTag");
let mob_no= document.getElementById("mob_no");
let email= document.getElementById("email");
let address= document.getElementById("address");

var isEditable= true;

function editCheck() {
    if (isEditable) {
        isEditable= false;
        nameTag.disabled= false;
        mob_no.disabled= false;
        email.disabled= false;
        address.disabled= false;
    } else {
        isEditable= true;
        nameTag.disabled= true;
        mob_no.disabled= true;
        email.disabled= true;
        address.disabled= true;
    }
}