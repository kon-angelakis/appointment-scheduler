package Servlets;

import java.io.*;
import java.time.LocalDate;

import Classes.Calendar;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "EditAvailabilityServlet", value = "/EditAvailability")
public class EditAvailability extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();

        int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : LocalDate.now().getYear();
        int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : LocalDate.now().getMonthValue();

        Calendar calendar = new Calendar(year, month);
        calendar.ChooseDimensions(1280, 720);

        session.setAttribute("calendar", calendar);
        RequestDispatcher dispatcher = request.getRequestDispatcher("EditAvailabilityPage.jsp");
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}