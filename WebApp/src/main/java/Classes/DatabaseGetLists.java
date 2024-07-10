package Classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DatabaseGetLists {
    private jdbc_connector c;

    public ArrayList<Professor> getProfessors(){
        ArrayList<Professor> professors = new ArrayList<>();
        c = new jdbc_connector();
        try (Connection conn = c.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT * FROM professors")) {

            try (ResultSet results = statement.executeQuery()) {
                while (results.next()) {
                    professors.add(new Professor().Preview(results.getString(1)));
                }
                return professors;

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Student> getStudents(){
        ArrayList<Student> students = new ArrayList<>();
        c = new jdbc_connector();
        try (Connection conn = c.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT * FROM students")) {

            try (ResultSet results = statement.executeQuery()) {
                while (results.next()) {
                    students.add(new Student().Preview(results.getString(1)));
                }
                return students;

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
