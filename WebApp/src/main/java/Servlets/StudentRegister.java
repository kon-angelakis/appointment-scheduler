package Servlets;

import java.io.*;

import Classes.Student;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "StudentRegisterServlet", value = "/Student register")
public class StudentRegister extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        RequestDispatcher dispatcher = request.getRequestDispatcher("StudentRegisterPage.jsp");
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");


        String fname = request.getParameter("firstName");
        String lname = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("am").toUpperCase();
        String pass = request.getParameter("password");

        //If new user then entry confirmed else error page
        if (new Student().Register(fname, lname, email, username, pass, "Student"))
            response.sendRedirect("ConfirmationPage.jsp");
        else
            response.sendRedirect("ErrorPage.jsp");

    }

    public void destroy() {
    }
}