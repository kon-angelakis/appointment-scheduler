package Classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Professor extends User{
    private List<Schedule> calendar = new ArrayList<>();
    private List<Appointment> appointments = new ArrayList<>();
    private String department;
    private jdbc_connector c;

    public Professor() {
        super();
    }

    public List<Schedule> getSchedule() {
        return calendar;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public boolean CancelAppointment(Appointment appointment) {
        return false;
    }

    public boolean Register(String fname, String lname, String email, String username, String password, String department, String usertype){
        super.Register(fname, lname, email, username, password, usertype);
        c = new jdbc_connector();
        try (Connection con = c.getConnection();
             PreparedStatement stmt = con.prepareStatement("INSERT INTO professors VALUES(?, ?)")) {
            stmt.setString(1, username);
            stmt.setString(2, department);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        c.closeConnection();
        return true;
    }

    @Override
    public User Login(String username, String password) throws SQLException {
        c = new jdbc_connector();
        try (Connection conn = c.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT users.*, professors.department  FROM users JOIN professors ON users.username = professors.username WHERE users.username ILIKE ? AND users.password = ?")) {

            statement.setString(1, username);
            statement.setString(2, password);

            try (ResultSet results = statement.executeQuery()) {
                if (results.next()) {
                    this.firstName = results.getString("firstname");
                    this.lastName = results.getString("lastname");
                    this.email = results.getString("email");
                    this.username = results.getString("username");
                    this.password = results.getString("password");
                    this.department = results.getString("department");
                    return this;
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }


}
