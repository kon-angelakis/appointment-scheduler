package Servlets;

import java.io.*;

import Classes.Professor;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "ProfessorRegisterServlet", value = "/Professor register")
public class ProfessorRegister extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        RequestDispatcher dispatcher = request.getRequestDispatcher("ProfessorRegisterPage.jsp");
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String fname = request.getParameter("firstName");
        String lname = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String department = request.getParameter("department");

        if (new Professor().Register(fname, lname, email, username, pass, department, "Professor"))
            response.sendRedirect("ConfirmationPage.jsp");
        else
            response.sendRedirect("ErrorPage.jsp");

    }

    public void destroy() {
    }
}