package Servlets;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;

import Classes.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "MakeAppointmentServlet", value = "/MakeAppointment")
public class MakeAppointment extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        if(session.getAttribute("user") instanceof Student) {
            Student user = (Student) session.getAttribute("user");

            ArrayList<Professor> professors = new DatabaseGetLists().getProfessors();
            session.setAttribute("professors", professors);
            //session.setAttribute("calendar", professors);
            RequestDispatcher dispatcher = request.getRequestDispatcher("MakeAppointment.jsp");
            dispatcher.forward(request, response);

        }else{
            throw new ServletException("Access Denied");
        }

    }

    public void destroy() {
    }
}