package com.AttendanceManager.att_man.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Date {
    @JsonProperty("year")
    private String year;
    @JsonProperty("month")
    private String month;
    @JsonProperty("date")
    private String date;
    Date(){}
    Date(String year,String month,String date){
        this.year=year;
        this.month=month;
        this.date=date;
    }

    //Getter and setter for year
    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    //Getter and setter for month

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    //Getter and setter for date

    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }
}
