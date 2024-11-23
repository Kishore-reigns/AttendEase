package com.AttendanceManager.att_man.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AttendHr {
    @JsonProperty("attend")
    boolean attend;
    @JsonProperty("hours")
    Integer hours;
    AttendHr(boolean attend,Integer hours){
        this.attend=attend;
        this.hours=hours;
    }
    AttendHr(){}
    //Getter and setter for attend

    public boolean isAttend() {
        return attend;
    }

    public void setAttend(boolean attend) {
        this.attend = attend;
    }

    //Getter and setter for hours

    public Integer getHours() {
        return hours;
    }

    public void setHours(Integer hours) {
        this.hours = hours;
    }

}
