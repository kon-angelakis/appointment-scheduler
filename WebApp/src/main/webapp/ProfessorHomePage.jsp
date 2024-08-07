<%@ page import="Classes.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  User user = (User) session.getAttribute("user"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="CSS/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="dark-theme">
<div class="container">
    <h1>Welcome, <%= user.getFirstName() + " " + user.getLastName() %></h1>
    <div class="card-container">
        <a href="EditAvailability">
            <div class="card">
                <i class="fas fa-calendar-alt icon"></i>
                <h2>Edit availability</h2>
                <p>View your schedule</p>
            </div>
        </a>
        <a href = "ViewAppointments">
            <div class="card">
                <i class="fas fa-tasks icon"></i>
                <h2>Your appointments</h2>
                <p>View your ongoing appointments</p>
            </div>
        </a>
        <a href = "AppointmentHistory">
            <div class="card">
                <i class="fas fa-history icon"></i>
                <h2>History</h2>
                <p>See your appointment history</p>
            </div>
        </a>
    </div>
</div>

<button class="floating-btn" onclick="toggleTheme()"><i class="fas fa-moon"></i></button>
<script src="JSScripts/ToggleViewMode.js"></script>

</body>
</html>
