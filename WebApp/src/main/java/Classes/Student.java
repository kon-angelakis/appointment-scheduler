package Classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


public class Student extends User{
    private List<Appointment> appointments = new ArrayList<>();
    private int year;
    private int semester;
    private jdbc_connector c;

    public Student() {
        super();
    }

    public boolean ScheduleAppointment(Appointment appointment){
        c = new jdbc_connector();
        try (Connection con = c.getConnection();
             PreparedStatement stmt = con.prepareStatement("INSERT INTO appointments(student_name, professor_name, sch_date, reason, status) " +
                     "VALUES(?, ?, ?, ?, ?)")) {
            stmt.setString(1, appointment.getStudent_username());
            stmt.setString(2, appointment.getProfessor_username());
            stmt.setDate(3, appointment.getSch_date());
            stmt.setString(4, appointment.getReason());
            stmt.setBoolean(5, appointment.getStatus());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        c.closeConnection();
        return true;
    }

    public boolean CancelAppointment(Appointment appointment){
        return false;
    }


    public ArrayList<Appointment> ViewAppointments(){
        ArrayList<Appointment> appointments = new ArrayList<>();
        jdbc_connector c = new jdbc_connector();
        Connection conn = c.getConnection();

        try {
            String query = "SELECT * FROM appointments WHERE student_name = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, this.username);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                appointments.add(new Appointment(rs.getString(2), rs.getString(3), rs.getDate(4), rs.getString(5), rs.getBoolean(6)));
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

        return appointments;
    }

    public boolean Register(String fname, String lname, String email, String am, String password, String usertype){
        super.Register(fname, lname, email, am, password, usertype);
        c = new jdbc_connector();

        //Determine student year based on provided AM
        String firstTwoDigits = am.substring(1, 3);
        int firstTwoDigitsInt= Integer.parseInt(firstTwoDigits);
        //Do current year - the 2 digits to figure out student year
        int year = Calendar.getInstance().get(Calendar.YEAR) % 100 - firstTwoDigitsInt;

        try (Connection con = c.getConnection();
             PreparedStatement stmt = con.prepareStatement("INSERT INTO students VALUES(?, ?)")) {
            stmt.setString(1, am);
            stmt.setInt(2, year);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        c.closeConnection();
        return true;
    }

    @Override
    public User Login(String AM, String password) throws SQLException {
        c = new jdbc_connector();
        try (Connection conn = c.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT users.*, students.year  FROM users JOIN students ON users.username = students.username WHERE users.username ILIKE ? AND users.password = ?")) {

            statement.setString(1, AM);
            statement.setString(2, password);

            try (ResultSet results = statement.executeQuery()) {
                if (results.next()) {
                    this.firstName = results.getString("firstname");
                    this.lastName = results.getString("lastname");
                    this.email = results.getString("email");
                    this.username = results.getString("username");
                    this.password = results.getString("password");
                    this.year = results.getInt("year");
                    return this;
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    @Override
    public Student Preview(String username) throws SQLException {
        c = new jdbc_connector();
        try (Connection conn = c.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT users.*, students.year  FROM users JOIN students ON users.username = students.username WHERE users.username ILIKE ?")) {

            statement.setString(1, username);

            try (ResultSet results = statement.executeQuery()) {
                if (results.next()) {
                    this.firstName = results.getString("firstname");
                    this.lastName = results.getString("lastname");
                    this.email = results.getString("email");
                    this.username = results.getString("username");
                    this.year = results.getInt("year");
                    return this;
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }


}
