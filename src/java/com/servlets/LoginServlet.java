package com.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("user_name");
        String pass = request.getParameter("user_password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/loginInfo", "root", "Intimetec@16");

            PreparedStatement ps = con.prepareStatement("select * from login where name=? and password=?");
            ps.setString(1, name);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("uname", name);

                // Debug statement to check the value being set in the session
                System.out.println("Setting session attribute uname: " + name);

                // Create a cookie to store the username
                Cookie userCookie = new Cookie("username", name);
                userCookie.setMaxAge(60 * 60 * 24 * 365 * 10);  
                response.addCookie(userCookie);

                // Redirect to HomePage.jsp on successful login
                response.sendRedirect("HomePage.jsp");
            }
            else {
                request.setAttribute("errorMessage", "Incorrect username or password.");
                RequestDispatcher rd = request.getRequestDispatcher("/signup.jsp");
                rd.include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/signup.jsp");
            rd.include(request, response);
        }

    }
}
