<%@ page import="Classes.Professor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Classes.Schedule" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<Professor> professors = (List<Professor>) session.getAttribute("professors");
    Professor chosen_professor = null;
    if (professors != null) {
        int numberOfProfessors = professors.size();
        int columns = (int) Math.ceil(Math.sqrt(numberOfProfessors));
        int rows = (int) Math.ceil((double) numberOfProfessors / columns);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Professors</title>
    <link rel="stylesheet" href="CSS/makeappointment.css">
</head>
<body>
<div class="title">Choose a Professor</div>
<div class="grid-container" style="
        grid-template-columns: repeat(<%= columns %>, 1fr);
        grid-template-rows: repeat(<%= rows %>, 1fr);
        ">
    <%
        for (Professor professor : professors) {
    %>
    <div class="grid-item" onclick="showForm('<%= professor.getFirstName() %>', '<%= professor.getLastName() %>', '<%= professor.getUsername() %>')">
        <div class="avatar"></div>
        <div class="professor-name"><%= professor.getUsername() %></div>
    </div>
    <%
            }
        }
    %>
</div>

<div id="sliding-box" class="sliding-box">
    <form id="professor-form" method="POST">
        <h2 id="form-title"></h2>
        <input type="hidden" id="professor-user" name="professor-user" value="">
        <label for="dropdown">Choose a Date:</label>
        <select id="dropdown" name="dropdown">
            <option value="" name="date">Select a date</option>
        </select>
        <label for="textarea">Your message:</label>
        <textarea id="textarea" name="textarea" rows="4" cols="50" style="resize: both;"></textarea>
        <button type="submit">Submit</button>
    </form>
    <button class="close-btn" type="button" onclick="hideForm()">Close</button>
</div>

<script>
    // Embed the schedules in a JavaScript object
    const professorSchedules = {
        <% for (Professor professor : professors) { %>
        '<%= professor.getUsername() %>': [
            <% for (Schedule schedule : professor.getSchedule()) { %>
            <% if (schedule.isBusy()) {%>
            '<%= schedule.getDate() %>',
            <% } %>
            <% } %>
        ],
        <% } %>
    };

    function showForm(professor_fname, professor_lname, professor_user) {
        document.getElementById('form-title').innerText = 'Professor: ' + professor_fname + " " + professor_lname;
        document.getElementById('sliding-box').classList.add('visible');
        document.getElementById('professor-user').value = professor_user;

        // Clear previous options
        const dropdown = document.getElementById('dropdown');
        dropdown.innerHTML = '<option value="">Select a date</option>';

        // Get the schedules for the selected professor and populate the dropdown
        const schedules = professorSchedules[professor_user];
        if (schedules) {
            schedules.forEach(date => {
                const option = document.createElement('option');
                option.value = date;
                option.text = date;
                dropdown.appendChild(option);
            });
        }
    }

    function hideForm() {
        document.getElementById('sliding-box').classList.remove('visible');
    }
</script>

</body>
</html>