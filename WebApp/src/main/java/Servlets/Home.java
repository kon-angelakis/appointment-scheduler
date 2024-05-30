package Servlets;

import java.io.*;

import Classes.Professor;
import Classes.Student;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.swing.*;

@WebServlet(name = "HomeServlet", value = "/Home")
public class Home extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        if (session.getAttribute("user") instanceof Student)
            dispatcher = request.getRequestDispatcher("StudentHomePage.jsp");
        else if (session.getAttribute("user") instanceof Professor)
            dispatcher = request.getRequestDispatcher("ProfessorHomePage.jsp");

        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}