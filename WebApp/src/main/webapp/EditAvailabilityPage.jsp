<%@ page import="Classes.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="Classes.Professor" %>
<%@ page import="Classes.Schedule" %>
<%@ page import="java.sql.Date" %>
<%@ page import="Classes.Appointment" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Used for date formatting
    DecimalFormat formatter = new DecimalFormat("00");
    Calendar calendar = (Calendar) session.getAttribute("calendar");
    Date[][] calendarMatrix = calendar.CalculateCalendar();
    List<Date> unavailable = calendar.getUnavailabledates();
    Date today = calendar.getToday();
    Professor professor = (Professor) session.getAttribute("user");
    List<Appointment> prof_appointments = professor.getAppointments();
    List<Schedule> prof_schedule = professor.getSchedule();

    // These 2 are used for availability dot placement in the calendar
    List<Date> sch_dates = new ArrayList<>();
    List<Boolean> sch_avail = new ArrayList<>();
    for (Schedule schedule : prof_schedule) {
        sch_dates.add(schedule.getDate());
        sch_avail.add(schedule.isBusy());
    }
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
            width: <%= calendar.getWidth() %>px;
            height: <%= calendar.getHeight() %>px;
        }

        .move-left {
            transform: translateX(-50%);
            transition: transform 1.2s ease;
        }

        .show-container {
            flex-direction: column;
            opacity: 1;
        }

        .selected {
            background-color: #f0ad4e;
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

        function changeDateSelection(day) {
            const tds = document.querySelectorAll('.calendar-container table tbody td');

            // Change all but the selected tds class and so the color as well via css
            tds.forEach(td => {
                td.classList.remove('selected');
            });

            event.target.classList.add('selected');

            // Set the hidden field to the date selected in sql.date notation YYYY-MM-dd
            const year = "<%= calendar.getDate().getYear() %>";
            const month = "<%= formatter.format(calendar.getDate().getMonthValue()) %>";
            const selectedDate = year + "-" + month + "-" + ("0" + day).slice(-2);
            document.getElementById("selectedDateInput").value = selectedDate;

            // Fetch appointments for the selected date and update the table
            fetchAppointments(selectedDate);

            console.log(document.getElementById("selectedDateInput").value);
        }

        function fetchAppointments(selectedDate) {
            const appointments = [
                <% for (Appointment appointment : prof_appointments) { %>
                {
                    sch_date: '<%= appointment.getSch_date() %>',
                    student_username: '<%= appointment.getStudent_username() %>',
                    reason: '<%= appointment.getReason() %>'
                },
                <% } %>
            ];

            const appointmentTableBody = document.getElementById('appointmentTableBody');
            appointmentTableBody.innerHTML = '';

            appointments.forEach(appointment => {
                if (appointment.sch_date === selectedDate) {
                    const row = document.createElement('tr');
                    const studentCell = document.createElement('td');
                    studentCell.innerText = appointment.student_username;
                    const reasonCell = document.createElement('td');
                    reasonCell.innerText = appointment.reason;
                    row.appendChild(studentCell);
                    row.appendChild(reasonCell);
                    appointmentTableBody.appendChild(row);
                }
            });
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
                <% for (Date[] week : calendarMatrix) { %>
                <tr>
                    <% for (Date date : week) { %>
                    <% boolean isToday = date.equals(today); %>
                    <% boolean isUnavailable = unavailable.contains(date); %>
                    <% boolean isAvailable = sch_dates.contains(date) && sch_avail.get(sch_dates.indexOf(date)); %>
                    <% boolean isBusy = false; %>
                    <% for (Appointment appointment : prof_appointments) {
                        if (appointment.getSch_date().equals(date)) {
                            isBusy = true;
                            break;
                        }
                    } %>
                    <% if (isUnavailable) { %>
                    <td class="unavailable">
                        <%= calendar.getDay(date) %>
                    </td>
                    <% } else { %>
                    <td class="<%= isToday ? "today available" : "available" %>"
                        onclick="moveLeft(); changeDateSelection(<%= calendar.getDay(date) %>);">
                        <%= calendar.getDay(date) %>
                        <div class="event-grid">
                            <% if (isAvailable) { %>
                            <div class="dot <%= isBusy ? "busy" : "available" %>"></div>
                            <% } else if (sch_dates.contains(date) && !sch_avail.get(sch_dates.indexOf(date))) { %>
                            <div class="dot unavailable"></div>
                            <% } %>
                        </div>
                    </td>
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
                    <th>Student</th>
                    <th>About Appointment</th>
                </tr>
                </thead>
                <tbody id="appointmentTableBody">
                </tbody>
            </table>
        </div>
        <form id="availabilityForm" action="EditAvailability">
            <div class="form-box form-section">
                <h2>Change Availability for
                    <input class="selectedDateInput" id="selectedDateInput" name="selectedDateInput" readonly>
                </h2>
                <select name="selectedAvailability">
                    <option value="true">Available</option>
                    <option value="false">Unavailable</option>
                </select>
            </div>
            <div class="form-buttons">
                <button class="btn-cancel" onclick="window.location.reload(); return false;">Cancel</button>
                <button class="btn-submit" formmethod="POST" type="submit">Submit</button>
            </div>
        </form>
    </div>
</div>
<button class="floating-btn" onclick="toggleTheme()"><i class="fas fa-moon"></i></button>
<script src="JSScripts/ToggleViewMode.js"></script>
</body>
</html>
