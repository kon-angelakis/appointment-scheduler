package Classes;

import java.sql.Date;

public class Appointment {
    private int appointmentID;
    private int priority;
    private String student_username;
    private String professor_username;
    private Date sch_date;

    public String getStudent_username() {
        return student_username;
    }

    public String getProfessor_username() {
        return professor_username;
    }

    public Date getSch_date() {
        return sch_date;
    }

    public String getReason() {
        return reason;
    }

    public Boolean getStatus() {
        return status;
    }

    private String reason;
    private Boolean status;


    public Appointment(String student_username, String professor_username, Date sch_date, String reason, Boolean status) {
        this.student_username = student_username;
        this.professor_username = professor_username;
        this.sch_date = sch_date;
        this.reason = reason;
        this.status = status;
    }

    public void Cancel(){}
}
