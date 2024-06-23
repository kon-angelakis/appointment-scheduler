function redirectToLogin() {
    let countdownElement = document.getElementById('countdown');
    let countdown = 3;

    let countdownInterval = setInterval(function() {
        if (countdown > 0) {
            countdownElement.textContent = "Redirecting in: " + countdown.toString();
            countdown--;
        } else {
            clearInterval(countdownInterval);
            window.location.href = 'Login';
        }
    }, 1000); //1 second
}