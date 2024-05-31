<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professor Registration Page</title>
    <link rel="stylesheet" href="CSS/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="register-container">
    <div class="register-box">
        <h2>Professor Register</h2>
        <form id="registerForm" action="Professor register" method="post">
            <div class="input-box">
                <input type="text" id="firstName" name="firstName" required>
                <label>First Name</label>
                <span class="error-icon" id="error-firstName"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-firstName">Invalid first name</span>
            </div>
            <div class="input-box">
                <input type="text" id="lastName" name="lastName" required>
                <label>Last Name</label>
                <span class="error-icon" id="error-lastName"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-lastName">Invalid last name</span>
            </div>
            <div class="input-box">
                <input type="text" id="email" name="email" required>
                <label>Email</label>
                <span class="error-icon" id="error-email"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-email">Invalid email address</span>
            </div>
            <div class="input-box">
                <input type="text" id="username" name="username" required>
                <label>Username</label>
                <span class="error-icon" id="error-username"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-username">Invalid username</span>
            </div>
            <div class="input-box">
                <input type="password" id="password" name="password" required>
                <label>Password</label>
                <span class="error-icon" id="error-password"><i class="fas fa-exclamation-circle"></i></span>
                <span class="error-tooltip" id="tooltip-password">Invalid password</span>
            </div>
            <div class="input-box">
                <select id="department" name="department" required>
                    <option value="" disabled selected>Select Department</option>
                    <option value="Mathematics">Mathematics</option>
                    <option value="Economics">Economics</option>
                    <option value="Comp. Science">Comp. Science</option>
                    <option value="Physics">Physics</option>
                    <option value="Biology">Biology</option>
                </select>
            </div>
            <button type="submit" class="register-btn" id="submitButton" disabled>Register</button>
        </form>
        <p class="link-text">Are you a Student? Register <a href="Student register">Here</a></p>
        <p class="link-text">Have an account? <a href="Login">Go back to login</a></p>
    </div>
</div>
<script>
    const fields = ['firstName', 'lastName', 'email', 'username', 'password', 'department'];
    const submitButton = document.getElementById('submitButton');

    fields.forEach(field => {
        document.getElementById(field).addEventListener('input', validateForm);
    });

    function validateForm() {
        let isValid = true;
        isValid &= validateField('firstName', /^[A-Za-z\s-]+$/, 'Invalid first name');
        isValid &= validateField('lastName', /^[A-Za-z\s-]+$/, 'Invalid last name');
        isValid &= validateField('email', /^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Invalid email address');
        isValid &= validateField('username', /^[a-z0-9._]+$/, 'Invalid username');
        isValid &= validateField('password', /^(?=.*[A-Z])(?=.*[0-9!@#$%^&*(),.?":{}|<>]).{8,}$/, 'Invalid password');
        isValid &= document.getElementById('department').value !== '';
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
