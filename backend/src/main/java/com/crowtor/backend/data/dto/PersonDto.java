package com.crowtor.backend.data.dto;

import com.crowtor.backend.data.models.Comment;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Twitt;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PersonDto {
    private long id;

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
