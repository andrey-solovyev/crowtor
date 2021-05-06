package com.crowtor.backend.data.dto;

import com.crowtor.backend.data.models.Comment;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Twitt;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;

@Data
public class PersonDto {
    private Calendar birthday;

    private LocalDateTime dateRegistration;

    private String firstName;

    private String lastName;

    private String nickName;

    private Boolean isDeleted = false;

    private Boolean isPremium = false;

    private Set<TwittFeedDto> twitts;

    private int subscription ;

    private int subscribers;
}
