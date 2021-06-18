package com.crowtor.backend.data.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.List;
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

    private Boolean isSubscriber;

    private List<String> roles;

}
