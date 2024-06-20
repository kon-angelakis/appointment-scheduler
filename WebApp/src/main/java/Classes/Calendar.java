package Classes;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

public class Calendar {

    private int width, height;
    private int year, month;
    private YearMonth fulldate;
    private LocalDate firstdate, lastdate, today = LocalDate.now();

    private List<Integer> Unavailabledays = new ArrayList<>();

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



    public Integer[][] CalculateCalendar() {
        int rows = 6;
        int cols = 7;
        Integer[][] calendarArray = new Integer[rows][cols];

        int firstday = firstdate.getDayOfWeek().getValue() % 7; //return index of first day
        int totaldays = fulldate.lengthOfMonth();
        //Get other 2 months days to fill the empty calendar spots
        int prevmonth_days = YearMonth.of(firstdate.minusMonths(1).getYear(), firstdate.minusMonths(1).getMonthValue()).lengthOfMonth() - firstday + 1;
        int nextmonth_days = 1;

        int dayIndex = 1, generalIndex = 0;
        for (int week = 0; week < rows; week++) {
            for (int day = 0; day < cols; day++) {

                if (week == 0 && day < firstday){ //If first week and the first day not yet reached fill with previous months dates
                    calendarArray[week][day] = prevmonth_days++;
                    Unavailabledays.add(generalIndex);
                }
                else if (dayIndex <= totaldays){
                    calendarArray[week][day] = dayIndex++;
                }
                else{ //After this month fills the rest of the cells with the next months
                    calendarArray[week][day] = nextmonth_days++;
                    Unavailabledays.add(generalIndex);
                }
                generalIndex++;

            }
        }
        return calendarArray;
    }

    public String getMonth(){
        return fulldate.getMonth().toString();
    }
    public String getYear(){
        return String.valueOf(fulldate.getYear());
    }
    public int getHeight() {
        return height;
    }
    public int getWidth() {
        return width;
    }
    public LocalDate getDate(){
        return firstdate;
    }
    public List<Integer> getUnavailabledays(){
        return Unavailabledays;
    }
}





