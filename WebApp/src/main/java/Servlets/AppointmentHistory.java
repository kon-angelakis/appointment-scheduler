package Servlets;

import java.io.*;

import Classes.Professor;
import Classes.Student;
import Classes.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "AppointmentHistoryServlet", value = "/AppointmentHistory")
public class AppointmentHistory extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        //Set 3rd column in jsp either to professor or student depending on user type
        if (user instanceof Student){
            session.setAttribute("target-user", "Professor");
        } else if (user instanceof Professor){
            session.setAttribute("target-user", "Student");
        }else{
            throw new ServletException("Access Denied");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("AppointmentHistoryPage.jsp");
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}