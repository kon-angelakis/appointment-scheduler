package Classes;

import java.sql.Date;

public class Schedule {
    private int scheduleID;
    private Date date;
    private Boolean isBusy;

    public Schedule(Date date, boolean isBusy) {
        this.date = date;
        this.isBusy = isBusy;
    }

    public Date getDate() { return date; }
    public Boolean isBusy() { return isBusy; }
}
