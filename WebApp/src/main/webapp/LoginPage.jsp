<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="CSS/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h2>Login</h2>
        <form id="loginForm" action="Login" method="post">
            <div class="input-box">
                <input type="text" name="username" required>
                <label>Username</label>
            </div>
            <div class="input-box password-box">
                <input type="password" id="password" name="password" required>
                <label>Password</label>
                <span id="togglePassword" class="toggle-password"><i class="fas fa-eye-slash"></i></span>
            </div>
            <button type="submit" class="login-btn">Login</button>
        </form>
        <p class="register-text">Don't have an account? <a href="Student register">Register now</a></p>
    </div>
</div>
<button class="floating-btn" onclick="toggleTheme()"><i class="fas fa-moon"></i></button>
<script src="JSScripts/ToggleViewMode.js"></script>
<script src="JSScripts/TogglePassword.js"></script>
</body>
</html>