package Classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Professor extends User{
    private ArrayList<Schedule> schedule;
    private ArrayList<Appointment> appointments;
    private String department;
    private jdbc_connector c;

    public Professor() {
        super();
    }

    public boolean EditSchedule(Schedule schedule) {
        //Handle an if where if schedule (prof.user and date) exist on db alter them else add new
        c = new jdbc_connector();
        int existing_record_id = -1;
        //If the record exists update its status availability
        try (Connection conn = c.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT schedule_id FROM schedule WHERE professor_username = ? AND date = ?")) {

            statement.setString(1, this.username);
            statement.setDate(2, schedule.getDate());

            try (ResultSet results = statement.executeQuery()) {
                if (results.next()) {
                    existing_record_id = results.getInt("schedule_id");
                    try (PreparedStatement stmtUpdate = conn.prepareStatement("UPDATE schedule SET available = ? WHERE schedule_id = ?")) {
                        stmtUpdate.setBoolean(1, schedule.isBusy());
                        stmtUpdate.setInt(2, existing_record_id);
                        stmtUpdate.executeUpdate();
                    }
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        c = new jdbc_connector();
        //If record doesnt exist insert it
        if(existing_record_id == -1) {
            try (Connection con = c.getConnection();
                 PreparedStatement stmt = con.prepareStatement("INSERT INTO schedule (professor_username, date, available) VALUES(?, ?, ?)")) {
                stmt.setString(1, this.username);
                stmt.setDate(2, schedule.getDate());
                stmt.setBoolean(3, schedule.isBusy());
                stmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }
        c.closeConnection();
        return true;
    }

    public ArrayList<Schedule> getSchedule() {
        ArrayList<Schedule> schedule = new ArrayList<>();
        jdbc_connector c = new jdbc_connector();
        Connection conn = c.getConnection();

        try {
            String query = "SELECT date, available FROM schedule WHERE professor_username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);

            // Assuming professor is an object with a getUsername() method
            stmt.setString(1, this.getUsername());  // Set the username parameter

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                schedule.add(new Schedule(rs.getDate("date"), rs.getBoolean("available")));
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return schedule;
    }

    public ArrayList<Appointment> ViewAppointments() {
        appointments = new ArrayList<>();

        c = new jdbc_connector();
        Connection conn = c.getConnection();
        try {
            // Use a prepared statement to safely set the parameter
            String query = "SELECT student_name, professor_name, sch_date, reason, status FROM appointments WHERE professor_name = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, this.username);

            ResultSet rs = stmt.executeQuery();
            while(rs.next()) {
                appointments.add(new Appointment(
                        rs.getString("student_name"),
                        rs.getString("professor_name"),
                        rs.getDate("sch_date"),
                        rs.getString("reason"),
                        rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

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

    @Override
    public Professor Preview(String username) throws SQLException {
        c = new jdbc_connector();
        try (Connection conn = c.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT users.*, professors.department  FROM users JOIN professors ON users.username = professors.username WHERE users.username ILIKE ?")) {

            statement.setString(1, username);

            try (ResultSet results = statement.executeQuery()) {
                if (results.next()) {
                    this.firstName = results.getString("firstname");
                    this.lastName = results.getString("lastname");
                    this.email = results.getString("email");
                    this.username = results.getString("username");
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
