package Servlets;

import java.io.*;

import Classes.Student;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "HistoryTableServlet", value = "/HistoryTable")
public class HistoryTable extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        Student user = (Student) session.getAttribute("user");

        // Placeholder: add any necessary session or request attributes here
        // session.setAttribute("attribute_name", attribute_value);

        RequestDispatcher dispatcher = request.getRequestDispatcher("HistoryTablePage.jsp");
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}