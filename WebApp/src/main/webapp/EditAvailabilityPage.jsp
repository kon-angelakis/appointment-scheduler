<%@ page import="Classes.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    Calendar calendar = (Calendar) session.getAttribute("calendar");
    Integer[][] calendarMatrix = calendar.CalculateCalendar();
    List<Integer> unavailable = calendar.getUnavailabledays();
    int todaysIndex = calendar.getToday();

%>

<html>
<head>
    <title>Manage your availability</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="CSS/calendar.css">
    <style>
        .calendar-container table {
            width: <%= calendar.getWidth()%>px;
            height: <%= calendar.getHeight()%>px;
        }
        .header-container h1 {
            flex-grow: 1;
            text-align: center;
            margin: 0;
        }

        .move-left {
            transform: translateX(-50%);
            transition: transform 1.2s ease;
        }

    </style>
    <script>
        function moveLeft() {
            document.querySelector('.general-container').classList.add('move-left');
        }

    </script>
</head>
<body>
<div class="general-container">
    <div class="header-container">
        <a href="?month=<%= calendar.getDate().minusMonths(1).getMonthValue() % 13 %>&year=<%= calendar.getDate().minusMonths(1).getYear() %>"
           class="btn btn-success btn-lg">
            <i class="fas fa-arrow-left"></i>
        </a>
        <h1><%= calendar.getMonth() %> <%= calendar.getYear() %></h1>
        <a href="?month=<%= calendar.getDate().plusMonths(1).getMonthValue() % 13 %>&year=<%= calendar.getDate().plusMonths(1).getYear() %>"
           class="btn btn-success btn-lg">
            <i class="fas fa-arrow-right"></i>
        </a>
    </div>

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
                        <% if (dayIndex == todaysIndex) { %>

                            <td class="today available"
                                onclick="moveLeft();" >
                                <%= day %>
                            </td>

                        <% } else { %>

                            <td class="available"
                                onclick="moveLeft();" >
                                <%= day %>
                                <div class="event-grid">
                                    <div class="dot"></div>
                                </div>
                            </td>

                        <% } %>
                    <% } else { %>
                    <td class="unavailable"><%= day %></td>
                    <% } %>
                <% } %>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>


</body>
</html>
