<%@ page import="Classes.Student" %>
<%@ page import="Classes.Appointment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Classes.User" %>
<%@ page import="Classes.Professor" %><%--
  Created by IntelliJ IDEA.
  User: kagge
  Date: 7/10/2024
  Time: 7:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    ArrayList<Appointment> appointments;
    if (session.getAttribute("user") instanceof Student){
        Student user = (Student) session.getAttribute("user");
        appointments = user.ViewAppointments();
    }else{
        Professor user = (Professor) session.getAttribute("user");
        appointments = user.ViewAppointments();
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>History Table</title>
    <link rel="stylesheet" href="CSS/viewappointments.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="table-container">
    <table>
        <thead>
        <tr>
            <th>Date</th>
            <th>Cause</th>
            <th><%= session.getAttribute("target-user")%></th>
        </tr>
        </thead>
        <tbody>
        <% for (Appointment appointment : appointments) { %>
        <tr>
            <!-- if appointment is ongoing -->
            <% if (appointment.getStatus()) { %>
                <td><%= appointment.getSch_date() %></td>
                <td><%= appointment.getReason() %></td>
                <% if (session.getAttribute("user") instanceof Student) { %>
                    <td><%= appointment.getProfessor_username() %></td>
                <% } else { %>
                    <td><%= appointment.getStudent_username() %></td>
                <% } %>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<button class="floating-btn" onclick="toggleTheme()"><i class="fas fa-moon"></i></button>
<script src="JSScripts/ToggleViewMode.js"></script>
</body>
</html>