package Classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class jdbc_connector {
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/UniAppointments";
    private static final String DB_USERNAME = "postgres";
    private static final String DB_PASSWORD = "kwstas123";

    private Connection connection;

    public jdbc_connector() {
        try {
            // Load the JDBC driver
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        if (connection == null) {
            try {
                // Establish the database connection
                connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }

    public void closeConnection() {
        if (connection != null) {
            try {
                // Close the database connection
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}