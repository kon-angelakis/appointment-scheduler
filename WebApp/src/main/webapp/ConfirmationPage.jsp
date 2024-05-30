<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Entry Confirmed</title>
    <link rel="stylesheet" href="CSS/login.css">
</head>
<script type="text/javascript">
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
</script>
<body onload="redirectToLogin()">
<div class="login-container">
    <div class="login-box">
        <h2>Entry Confirmed</h2>
        <h4 id="countdown">Redirecting in: </h4>
    </div>
</div>
</body>
</html>
