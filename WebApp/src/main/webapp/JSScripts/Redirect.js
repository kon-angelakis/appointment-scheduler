function redirectToPrevious() {
    let countdownElement = document.getElementById('countdown');
    let countdown = 3;

    let countdownInterval = setInterval(function() {
        if (countdown > 0) {
            countdownElement.textContent = "Redirecting in: " + countdown.toString();
            countdown--;
        } else {
            clearInterval(countdownInterval);
            //TODO: If from Register forms return to login else go to homepage
            //This redirects to the previous page
            window.location.href = document.referrer;
        }
    }, 1000); //1 second
}