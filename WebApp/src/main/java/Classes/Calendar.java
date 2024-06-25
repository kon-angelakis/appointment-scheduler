package Classes;

import java.time.LocalDate;
import java.time.YearMonth;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Calendar {

    private int width, height;
    private int year, month, today = LocalDate.now().getDayOfMonth();
    private int firstday;
    private YearMonth fulldate;
    private LocalDate firstdate, lastdate;

    private List<Date> Unavailabledates = new ArrayList<>();

    public Calendar(int year, int month) {
        this.year = year;
        this.month = month;
        fulldate = YearMonth.of(year, month);
        firstdate = fulldate.atDay(1);
        lastdate = fulldate.atEndOfMonth();
    }

    public void ChooseDimensions(int width, int height) {
        this.width = width;
        this.height = height;
    }

    public Date[][] CalculateCalendar() {
        int rows = 6;
        int cols = 7;
        Date[][] calendarArray = new Date[rows][cols];

        firstday = firstdate.getDayOfWeek().getValue() % 7; // return index of first day
        int totaldays = fulldate.lengthOfMonth();

        // Get other 2 months days to fill the empty calendar spots
        YearMonth prevMonth = fulldate.minusMonths(1);
        int prevmonth_days = prevMonth.lengthOfMonth() - firstday + 1;
        YearMonth nextMonth = fulldate.plusMonths(1);
        int nextmonth_days = 1;

        int dayIndex = 1, generalIndex = 0;
        for (int week = 0; week < rows; week++) {
            for (int day = 0; day < cols; day++) {

                if (week == 0 && day < firstday) { // If first week and the first day not yet reached fill with previous months dates
                    LocalDate date = LocalDate.of(prevMonth.getYear(), prevMonth.getMonth(), prevmonth_days++);
                    calendarArray[week][day] = Date.valueOf(date);
                    Unavailabledates.add(Date.valueOf(date));
                } else if (dayIndex <= totaldays) {
                    calendarArray[week][day] = Date.valueOf(LocalDate.of(year, month, dayIndex++));
                } else { // After this month fills the rest of the cells with the next months
                    LocalDate date = LocalDate.of(nextMonth.getYear(), nextMonth.getMonth(), nextmonth_days++);
                    calendarArray[week][day] = Date.valueOf(date);
                    Unavailabledates.add(Date.valueOf(date));
                }
                generalIndex++;
            }
        }
        return calendarArray;
    }

    public String getDay(Date date){
        return String.valueOf(Date.valueOf(date.toString()).toLocalDate().getDayOfMonth());
    }

    public String getMonth() {
        return String.valueOf(fulldate.getMonth());
    }

    public String getYear() {
        return String.valueOf(fulldate.getYear());
    }

    public int getHeight() {
        return height;
    }

    public int getWidth() {
        return width;
    }

    public LocalDate getDate() {
        return firstdate;
    }

    public List<Date> getUnavailabledates() {
        return Unavailabledates;
    }

    // If calendars date(month and year) not synced with today's date then return 0 as today's day index
    public Date getToday() {
        return Date.valueOf(LocalDate.now());
    }
}
