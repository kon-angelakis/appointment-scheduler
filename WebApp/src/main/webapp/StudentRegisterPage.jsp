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
</head>
<body>
<div class="register-container">
    <div class="register-box">
        <h2>Student Register</h2>
        <form action="SRegister" method="post">
            <div class="input-box">
                <input type="text" name="firstName" required>
                <label>First Name</label>
            </div>
            <div class="input-box">
                <input type="text" name="lastName" required>
                <label>Last Name</label>
            </div>
            <div class="input-box">
                <input type="email" name="email" required>
                <label>Email</label>
            </div>
            <div class="input-box">
                <input type="text" name="am" pattern="[pP][0-9]{5}" maxlength="6" required>
                <label>AM (PXXXXX)</label>
            </div>
            <div class="input-box">
                <input type="password" name="password" required>
                <label>Password</label>
            </div>
            <button type="submit" class="register-btn">Register</button>
        </form>
        <p class="link-text">Are you a professor? Register <a href="Professor register">Here</a></p>
        <p class="link-text">Have an account? <a href="Login">Go back to login</a></p>
    </div>
</div>
</body>
</html>

