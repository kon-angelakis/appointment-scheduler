package Classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public abstract class User {
    protected String firstName;
    protected String lastName;
    protected String email;
    protected String username;
    protected String password;
    private jdbc_connector c;

    public User() {

    }

    //If there were errors return false and redirect accordingly
    public boolean Register(String fname, String lname, String email, String username, String password, String usertype){
        c = new jdbc_connector();
        try (Connection con = c.getConnection();
             PreparedStatement stmt = con.prepareStatement("INSERT INTO users VALUES(?, ?, ?, ?, ?, ?)")) {
            stmt.setString(1, fname);
            stmt.setString(2, lname);
            stmt.setString(3, email);
            stmt.setString(4, username);
            stmt.setString(5, password);
            stmt.setString(6, usertype);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        c.closeConnection();
        return true;
    }

    public abstract User Login(String username, String password) throws SQLException; //If user exists return him otherwise return null
    public void Logout(){}

    // Getters
    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

}
