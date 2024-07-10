<%@ page import="Classes.Student" %>
<%@ page import="Classes.Appointment" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: kagge
  Date: 7/10/2024
  Time: 7:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% Student user = (Student) session.getAttribute("user");
    ArrayList<Appointment> appointments = user.ViewAppointments();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>History Table</title>
    <link rel="stylesheet" href="CSS/viewappointments.css">
</head>
<body>
<div class="table-container">
    <table>
        <thead>
        <tr>
            <th>Date</th>
            <th>Cause</th>
            <th>Professor</th>
        </tr>
        </thead>
        <tbody>
        <% for (Appointment appointment : appointments) { %>
        <tr>
            <!-- if appointment is ongoing -->
            <% if (appointment.getStatus()) { %>
                <td><%= appointment.getSch_date() %></td>
                <td><%= appointment.getReason() %></td>
                <td><%= appointment.getProfessor_username() %></td>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>