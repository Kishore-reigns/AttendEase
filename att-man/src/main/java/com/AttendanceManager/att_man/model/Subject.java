package com.AttendanceManager.att_man.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.HashMap;
import java.util.Map;
@JsonIgnoreProperties(ignoreUnknown = true)
public class Subject {
    @JsonProperty("subjectCode")
    private String subjectCode;
    @JsonProperty("subjectName")
    private String subjectName;
    @JsonProperty("contactHours")
    private int contactHours;
    @JsonProperty("hoursAttended")
    private int hoursAttended;
    @JsonProperty("classMap")
    HashMap<Date,AttendHr> classMap=new HashMap<>();

    public Subject(){}
    public Subject(String subjectCode,String subjectName,int contactHours,int hoursAttended){
        this.subjectCode=subjectCode;
        this.subjectName=subjectName;
        this.contactHours=contactHours;
        this.hoursAttended=hoursAttended;

    }

    //Getter and setter for subjectcode

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    //Getter and setter for subject name

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    //Getter and setter for contact hours

    public int getContactHours() {
        return contactHours;
    }

    public void setContactHours(int contactHours) {
        this.contactHours = contactHours;
    }
    //Getter abd setter gor hours attended

    public void setHoursAttended(int hoursAttended) {
        this.hoursAttended = hoursAttended;
    }

    public int getHoursAttended() {
        return hoursAttended;
    }
    //Getter and setter for class map
    public Map<Date, AttendHr> getClassMap() {
        return classMap;
    }

    public void setClassMap(Map<Date, AttendHr> classMap) {
        this.classMap = (HashMap<Date, AttendHr>) classMap;
    }

    // Optional: Method to add attendance
    public void addClassAttendance(Date date, AttendHr attendObj) {
        this.classMap.put(date, attendObj);
    }
}
