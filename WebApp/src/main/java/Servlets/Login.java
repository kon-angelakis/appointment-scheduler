package Servlets;

import java.io.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import Classes.Professor;
import Classes.Student;
import Classes.User;
import Classes.jdbc_connector;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "LoginPageServlet", value = "/Login")
public class Login extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        //Add page handling here
        RequestDispatcher dispatcher = request.getRequestDispatcher("LoginPage.jsp");
        dispatcher.forward(request, response);

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;

        User user = null;
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String regex = "^[pP]\\d{5}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(username);

        try {
            if (matcher.matches())  //User is student else professor
                user = new Student().Login(username, password);
            else
                user = new Professor().Login(username, password);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Keep the user object in the session when switching pages
        session.setAttribute("user", user);

        //After successful login redirect to home servlet for dynamic page handling based on usertype
        if(user != null)
            response.sendRedirect("/Home");
        else
            response.sendRedirect("/Login");

    }

    public void destroy() {
    }

}