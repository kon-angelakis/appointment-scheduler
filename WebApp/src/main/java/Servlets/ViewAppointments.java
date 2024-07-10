package Servlets;

import java.io.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "ViewAppointmentsPage", value = "/ViewAppointments")
public class ViewAppointments extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();

        // Placeholder: add any necessary session or request attributes here
        // session.setAttribute("attribute_name", attribute_value);

        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewAppointmentsPage.jsp");
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}