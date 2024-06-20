<%@ page import="Classes.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    Calendar calendar = (Calendar) session.getAttribute("calendar");
    Integer[][] calendarMatrix = calendar.CalculateCalendar();
    List<Integer> unavailable = calendar.getUnavailabledays();

%>

<html>
<head>
    <title>Manage your availability</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="CSS/calendar.css">
</head>
<body>

<h1>Calendar for <%= calendar.getMonth() %> <%= calendar.getYear() %></h1>

<div class="calendar-container">
    <table>
        <thead>
        <tr>
            <th>Sun</th>
            <th>Mon</th>
            <th>Tue</th>
            <th>Wed</th>
            <th>Thu</th>
            <th>Fri</th>
            <th>Sat</th>
        </tr>
        </thead>
        <tbody>
        <% int dayIndex = 0; %>
        <% for (Integer[] week : calendarMatrix) { %>
        <tr>

            <% for (Integer day : week) { %>
                <% if (!unavailable.contains(dayIndex++)) { %>
                    <td class="available"><%= day %></td>
                <% } else { %>
                    <td class="unavailable"><%= day %></td>
                <% } %>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<div class="d-flex justify-content-between">
    <a href="?month=<%= calendar.getDate().minusMonths(1).getMonthValue() % 13 %>&year=<%= calendar.getDate().minusMonths(1).getYear() %>"
       class="btn btn-success btn-lg">
        <i class="fas fa-arrow-left"></i>
    </a>
    <a href="?month=<%= calendar.getDate().plusMonths(1).getMonthValue() % 13 %>&year=<%= calendar.getDate().plusMonths(1).getYear() %>"
       class="btn btn-success btn-lg">
        <i class="fas fa-arrow-right"></i>
    </a>
</div>

</body>
</html>
