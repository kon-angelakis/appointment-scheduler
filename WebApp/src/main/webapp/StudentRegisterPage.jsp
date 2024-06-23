<%--
  Created by IntelliJ IDEA.
  User: kagge
  Date: 5/24/2024
  Time: 11:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration Page</title>
    <link rel="stylesheet" href="CSS/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>
<body>
<div class="register-container">
    <div class="register-box">
        <h2>Student Register</h2>
        <form action="Student register" method="post">
            <div class="input-box">
                <input type="text" name="firstName" id="firstName" required>
                <label>First Name</label>
                <span class="error-icon" id="error-firstName"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-firstName">Invalid first name</span>
            </div>
            <div class="input-box">
                <input type="text" name="lastName" id="lastName" required>
                <label>Last Name</label>
                <span class="error-icon" id="error-lastName"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-lastName">Invalid last name</span>
            </div>
            <div class="input-box">
                <input type="text" name="email" id="email" required>
                <label>Email</label>
                <span class="error-icon" id="error-email"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-email">Invalid email address</span>
            </div>
            <div class="input-box">
                <input type="text" name="am" id="am" maxlength="6" required>
                <label>AM (PXXXXX)</label>
                <span class="error-icon" id="error-am"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-am">Invalid username</span>
            </div>
            <div class="input-box">
                <input type="password" name="password" id="password" required>
                <label>Password</label>
                <span id="togglePassword" class="toggle-password"><i class="fas fa-eye-slash"></i></span>
                <span class="error-icon" id="error-password"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-password">Invalid password</span>
            </div>
            <button type="submit" class="register-btn" id="submitButton" disabled>Register</button>
        </form>
        <p class="link-text">Are you a professor? Register <a href="Professor register">Here</a></p>
        <p class="link-text">Have an account? <a href="Login">Go back to login</a></p>
    </div>
</div>
<script src="JSScripts/TogglePassword.js"></script>
<script src="JSScripts/StudValidateForm.js"></script>
<script src="JSScripts/RegFormValidateFields.js"></script>
</body>
</html>

