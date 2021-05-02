package com.crowtor.backend.data.dto.securutyDto;

import lombok.Data;

import java.util.Calendar;
@Data
public class RegistPersonDto {
    private Calendar birthday;

    private String firstName;

    private String lastName;

    private String nickName;

    private String password;

}
