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
                <input type="email" name="email" id="email" required>
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
                <span class="error-icon" id="error-password"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-password">Invalid password</span>
            </div>
            <button type="submit" class="register-btn" id="submitButton" disabled>Register</button>
        </form>
        <p class="link-text">Are you a professor? Register <a href="Professor register">Here</a></p>
        <p class="link-text">Have an account? <a href="Login">Go back to login</a></p>
    </div>
</div>
<script>
    const fields = ['firstName', 'lastName', 'email', 'am', 'password'];
    const submitButton = document.getElementById('submitButton');

    fields.forEach(field => {
        document.getElementById(field).addEventListener('input', validateForm);
    });

    function validateForm() {
        let isValid = true;
        isValid &= validateField('firstName', /^[A-Za-z\s-]+$/, 'Invalid first name');
        isValid &= validateField('lastName', /^[A-Za-z\s-]+$/, 'Invalid last name');
        isValid &= validateField('email', /^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Invalid email address');
        isValid &= validateField('am', /^[pP]\d{5}$/, 'Invalid username');
        isValid &= validateField('password', /^(?=.*[A-Z])(?=.*[0-9!@#$%^&*(),.?":{}|<>]).{8,}$/, 'Invalid password');
        toggleSubmitButton(isValid);
    }

    function validateField(fieldId, regex, errorMessage) {
        const input = document.getElementById(fieldId);
        const errorIcon = document.getElementById('error-' + fieldId);
        const tooltip = document.getElementById('tooltip-' + fieldId);

        const isValid = regex.test(input.value);
        if (!isValid && input.value !== '') {
            errorIcon.style.display = 'inline';
            tooltip.innerText = errorMessage;
        } else {
            errorIcon.style.display = 'none';
        }
        return isValid;
    }

    function toggleSubmitButton(isValid) {
        if (isValid) {
            submitButton.disabled = false;
            submitButton.classList.remove('disabled');
        } else {
            submitButton.disabled = true;
            submitButton.classList.add('disabled');
        }
    }

    document.addEventListener('DOMContentLoaded', validateForm);
</script>
</body>
</html>

