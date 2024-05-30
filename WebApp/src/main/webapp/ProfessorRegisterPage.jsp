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
        <h2>Professor Register</h2>
        <form action="PRegister" method="post">
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
                <input type="text" name="username" required>
                <label>Username</label>
            </div>
            <div class="input-box">
                <input type="password" name="password" required>
                <label>Password</label>
            </div>
            <div class="input-box">
                <select name="department" required>
                    <option value="" disabled selected>Select Department</option>
                    <option value="Mathematics">Mathematics</option>
                    <option value="Economics">Economics</option>
                    <option value="Comp. Science">Comp. Science</option>
                    <option value="Physics">Physics</option>
                    <option value="Biology">Biology</option>
                </select>
            </div>
            <button type="submit" class="register-btn">Register</button>
        </form>
        <p class="link-text">Are you a Student? Register <a href="Student register">Here</a></p>
        <p class="link-text">Have an account? <a href="Login">Go back to login</a></p>
    </div>
</div>
</body>
</html>

