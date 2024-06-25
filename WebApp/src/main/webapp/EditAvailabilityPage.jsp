<%@ page import="Classes.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%

    DecimalFormat formatter = new DecimalFormat("00");
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
    <link rel="stylesheet" href="CSS/editavailabilityform.css">
    <style>
        .calendar-container table {
            width: <%= calendar.getWidth()%>px;
            height: <%= calendar.getHeight()%>px;
        }

        .move-left {
            transform: translateX(-50%);
            transition: transform 1.2s ease;
        }

        .show-container {
            flex-direction: column;
            opacity: 1;
        }

    </style>
    <script>
        function moveLeft() {
            const calendarContainer = document.querySelector('.calendar-container');
            const formContainer = document.querySelector('.form-container');

            calendarContainer.classList.add('move-left');

            // Wait for 1.2 seconds before showing the form div
            setTimeout(() => {
                formContainer.style.display = 'flex';
                formContainer.classList.add('show-container');
            }, 1200);
        }

        function changeDateSelection(day){
            const tds = document.querySelectorAll('.calendar-container table tbody td');

            //Change all but the selected tds class and so the color as well via css
            tds.forEach(td => {
                td.classList.remove('selected');
            });

            event.target.classList.add('selected');

            //set the hidden field to the date selected in sql.date notation YYYY-MM-dd
            document.getElementById("selectedDateInput").value = "<%= calendar.getDate().getYear() %>-" +
                "<%= formatter.format(calendar.getDate().getMonthValue()) %>-" +
                ("0" + day).slice(-2);  //Day as 2 digits


            console.log(document.getElementById("selectedDateInput").value)
        }
    </script>

</head>
<body>

<div class="general-container">

    <div class="calendar-container">
        <div class="table-header-container">
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

        <div class="table-container">
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
                                    onclick="moveLeft(); changeDateSelection(<%=day%>);" >
                                    <%= day %>
                                </td>

                            <% } else { %>

                                <td class="available"
                                    onclick="moveLeft(); changeDateSelection(<%=day%>);" >
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

    <div class="form-container">
        <div class="form-box form-section">
            <h2>Day's Log</h2>
            <table>
                <thead>
                <tr>
                    <th>Date</th>
                    <th>Student</th>
                    <th>About Appointment</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <form id="availabilityForm" action="EditAvailability">
            <div class="form-box form-section">
                <h2>Change Availability for
                    <input class="selectedDateInput" id="selectedDateInput" name="selectedDateInput">
                </h2>
                <select name="selectedAvailability">
                    <option value="true">Available</option>
                    <option value="false">Unavailable</option>
                </select>
            </div>
            <div class="form-buttons">
                <button class="btn-cancel" onclick="window.location.reload();">Cancel</button>
                <button class="btn-submit" formmethod="POST" type="submit" >Submit</button>
            </div>
        </form>

    </div>

</div>
<button class="floating-btn" onclick="toggleTheme()">🌓</button>
<script src="JSScripts/ToggleViewMode.js"></script>
</body>
</html>
