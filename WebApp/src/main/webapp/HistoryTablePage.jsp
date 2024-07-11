<%@ page import="static com.sun.org.apache.xerces.internal.impl.XMLScanner.NameType.DOCTYPE" %>
<%@ page import="Classes.Student" %>
<%@ page import="Classes.Appointment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Classes.User" %><%--
  Created by IntelliJ IDEA.
  User: kagge
  Date: 7/10/2024
  Time: 6:58 PM
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
  <link rel="stylesheet" href="CSS/historytable.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="table-container">
  <table>
    <thead>
    <tr>
      <th>Date</th>
      <th>Cause</th>
      <th>Professor</th>
      <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <% for (Appointment appointment : appointments) { %>
    <tr>
        <td><%= appointment.getSch_date() %></td>
        <td><%= appointment.getReason() %></td>
        <td><%= appointment.getProfessor_username() %></td>
        <td><%= appointment.getStatus() ? "Ongoing" : "Complete" %></td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div><button class="floating-btn" onclick="toggleTheme()"><i class="fas fa-moon"></i></button>
<script src="JSScripts/ToggleViewMode.js"></script>
</body>
</html>