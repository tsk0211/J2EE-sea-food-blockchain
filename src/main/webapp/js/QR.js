var imgL= document.getElementById("uploadedImage")

// Function to handle file drop event
function dropHandler(event) {
    event.preventDefault();
    var file = event.dataTransfer.files[0];
    handleFile(file);
}

// Function to handle file drag over event
function dragOverHandler(event) {
    event.preventDefault();
    imgL.classList.add("imgOpen")
}

// Function to handle file input change event
function fileInputChangeHandler(event) {
    var file = event.target.files[0];
    handleFile(file);
    imgL.classList.add("imgOpen")
}

// Function to handle uploaded file
function handleFile(file) {
    var reader = new FileReader();
    reader.onload = function(event) {
    var img = document.getElementById('uploadedImage');
    img.src = event.target.result;
    }
    imgL.classList.add("imgOpen")
    reader.readAsDataURL(file);
}