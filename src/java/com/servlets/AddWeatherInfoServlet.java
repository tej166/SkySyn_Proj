package com.servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "AddWeatherInfoServlet", urlPatterns = {"/addWeatherInfo"})
public class AddWeatherInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String place = request.getParameter("place");
        String latitudeStr = request.getParameter("latitude");
        String longitudeStr = request.getParameter("longitude");
        String temperatureStr = request.getParameter("temperature");
        String userName = request.getParameter("userName");

        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Get the connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loginInfo", "root", "Intimetec@16");

            // Check if the place already exists for the user
            String checkSql = "SELECT COUNT(*) FROM weatherInfo WHERE place = ? AND user_name = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, place);
            checkStmt.setString(2, userName);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                response.getWriter().print("Weather info for this place is already present");
            } else {
                // Insert the new weather info
                String insertSql = "INSERT INTO weatherInfo (place, latitude, longitude, temperature, user_name) VALUES (?, ?, ?, ?, ?)";
                insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, place);
                insertStmt.setDouble(2, latitudeStr != null ? Double.parseDouble(latitudeStr.trim()) : 0);
                insertStmt.setDouble(3, longitudeStr != null ? Double.parseDouble(longitudeStr.trim()) : 0);
                insertStmt.setDouble(4, temperatureStr != null ? Double.parseDouble(temperatureStr.trim()) : 0);
                insertStmt.setString(5, userName);

                int rowsInserted = insertStmt.executeUpdate();
                if (rowsInserted > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().print("Weather info added successfully");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().print("Failed to add weather info");
                }
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("Database error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("JDBC Driver not found: " + e.getMessage());
        } finally {
            try {
                if (checkStmt != null) {
                    checkStmt.close();
                }
                if (insertStmt != null) {
                    insertStmt.close();
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
