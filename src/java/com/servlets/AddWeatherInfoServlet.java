package com.servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AddWeatherInfoServlet", urlPatterns = {"/addWeatherInfo"})
public class AddWeatherInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String place = request.getParameter("place");
        String latitudeStr = request.getParameter("latitude");
        String longitudeStr = request.getParameter("longitude");
        String temperatureStr = request.getParameter("temperature");
        String userName = request.getParameter("userName");

        Connection conn = null;
        PreparedStatement stmt = null;
        try {
       
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Get the connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loginInfo", "root", "Intimetec@16");
            String sql = "INSERT INTO weatherInfo (place, latitude, longitude, temperature, user_name) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, place);
            stmt.setDouble(2, latitudeStr != null ? Double.parseDouble(latitudeStr.trim()) : 0);
            stmt.setDouble(3, longitudeStr != null ? Double.parseDouble(longitudeStr.trim()) : 0);
            stmt.setDouble(4, temperatureStr != null ? Double.parseDouble(temperatureStr.trim()) : 0);
            stmt.setString(5, userName);
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().print("Weather info added successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().print("Failed to add weather info");
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("Database error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("JDBC Driver not found: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
