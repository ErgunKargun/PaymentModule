
// Get the modal
var modal = document.getElementById('loginModal');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

// redirecting verify code
function formLoginSubmit() {
	document.getElementById("loginForm").submit();
}