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

    public Student() {
        super();
    }

    public boolean ScheduleAppointment(Appointment appointment){
        return false;
    }

    public boolean CancelAppointment(Appointment appointment){
        return false;
    }

    public void ChooseProfessor(){}

    public List<Appointment> ViewAppointments(){
        return appointments;
    }

    public boolean Register(String fname, String lname, String email, String am, String password, String usertype){
        super.Register(fname, lname, email, am, password, usertype);
        jdbc_connector c = new jdbc_connector();

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
        jdbc_connector connection = new jdbc_connector();
        PreparedStatement statement = connection.getConnection().prepareStatement("SELECT users.*, students.year  FROM users, students WHERE users.username ILIKE ? AND users.password = ?");
        statement.setString(1, AM);
        statement.setString(2, password);
        ResultSet results = statement.executeQuery();
        try {

            while(results.next()){
                this.firstName = results.getString("firstname");
                this.lastName = results.getString("lastname");
                this.email = results.getString("email");
                this.username = results.getString("username");
                this.password = results.getString("password");
                this.year = results.getInt("year");

            }
            return this;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void Logout(){}
}
