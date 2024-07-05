import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;

@WebServlet(name = "FetchPinnedWeatherServlet", urlPatterns = {"/fetchPinnedWeather"})
public class FetchPinnedWeatherServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("uname");

        // Fetch pinned weather data for the given userName
        List<JsonObject> pinnedWeatherData = fetchDataFromDatabase(userName);

        // Convert pinnedWeatherData to JSON and send as response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(pinnedWeatherData));
    }

    // Method to fetch pinned weather data from the database
    private List<JsonObject> fetchDataFromDatabase(String userName) {
        List<JsonObject> pinnedWeatherData = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to MySQL database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loginInfo", "root", "Intimetec@16");

            // Prepare SQL query to fetch pinned weather data for the given userName
            String sql = "SELECT place, latitude, longitude, temperature FROM weatherInfo WHERE user_name = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);

            // Execute the query
            rs = stmt.executeQuery();

            // Iterate through the result set and construct the pinned weather data list
            while (rs.next()) {
                String place = rs.getString("place");
                double latitude = rs.getDouble("latitude");
                double longitude = rs.getDouble("longitude");
                double temperature = rs.getDouble("temperature");

                // Create a JSON object for each weather data entry
                JsonObject weatherData = new JsonObject();
                weatherData.addProperty("place", place);
                weatherData.addProperty("latitude", latitude);
                weatherData.addProperty("longitude", longitude);
                weatherData.addProperty("temperature", temperature);

                pinnedWeatherData.add(weatherData);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle any errors
        } finally {
            // Close ResultSet, PreparedStatement, and Connection
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return pinnedWeatherData;
    }
}
