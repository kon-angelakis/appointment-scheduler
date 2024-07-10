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
    <div class="grid-item" onclick="showForm('<%= professor %>'), <% chosen_professor = professor; %>">
        <div class="avatar"></div>
        <div class="professor-object"><%= professor %></div>
    </div>
    <%
            }
        }
    %>
</div>

<div id="sliding-box" class="sliding-box">
    <form id="professor-form" method="POST">
        <h2 id="form-title"></h2>
        <label for="dropdown">Choose a Date:</label>
        <label for="dropdown">Choose a Date:</label>
        <select id="dropdown" name="dropdown">
            <% for (Schedule schedule : chosen_professor.getSchedule()) { %>
            <option value="<%= schedule.getDate() %>"><%= schedule.getDate() %></option>
            <% } %>
        </select>
        <label for="textarea">Your message:</label>
        <textarea id="textarea" name="textarea" rows="4" cols="50" style="resize: both;"></textarea>
        <button type="submit">Submit</button>
    </form>
    <button class="close-btn" type="button" onclick="hideForm()">Close</button>
</div>

<script>
    function showForm(professor) {
        document.getElementById('form-title').innerText = 'Form for ' + professor;
        document.getElementById('sliding-box').classList.add('visible');
    }

    function hideForm() {
        document.getElementById('sliding-box').classList.remove('visible');
    }
</script>

</body>
</html>

