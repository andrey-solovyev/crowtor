package com.crowtor.backend.data.dto;

import lombok.Data;

import java.util.Calendar;
@Data
public class RegistPersonDto {
    private Calendar birthday;

    private String firstName;

    private String lastName;

    private String nickName;

}
