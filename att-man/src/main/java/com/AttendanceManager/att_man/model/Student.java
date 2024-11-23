package com.AttendanceManager.att_man.model;

import com.AttendanceManager.att_man.Utils.PasswordUtils;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@JsonIgnoreProperties(ignoreUnknown = true)
@Document(collection = "StudentDetails")
public class Student {
    @Id
    @JsonProperty("regno")
    private long regno;

    @NotNull
    @Size(max = 50)
    @JsonProperty("studentName")
    private String name;

    @NotNull
    @Size(min=6,max=20)
    @JsonProperty("password")
    private String password;
    @JsonProperty("subjectList")
    private List<Subject> subjectList;
    @JsonProperty("profilePic")
    private byte[] profilePic;

    public Student(){}

    public Student(long regno,String name,String password,List<Subject> subjectList,byte[] profilePic){
        this.regno=regno;
        this.name=name;
        this.password=password;
        this.subjectList=subjectList;
        this.profilePic=profilePic;
    }


    //Getter and setter for regno
    public long getRegno() {
        return regno;
    }

    public void setRegno(long regno) {
        this.regno = regno;
    }

    //Getter and setter for name

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    //Getter and setter for password

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = PasswordUtils.encodePassword(password);
    }


    //Getter and setter for subject list
    public List<Subject> getSubjectList() {
        return subjectList;
    }

    public void setSubjectList(List<Subject> subjectList) {
        this.subjectList = subjectList;
    }

    //Getter and setter for profilePic

    public byte[] getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(byte[] profilePic) {
        this.profilePic = profilePic;
    }
}
