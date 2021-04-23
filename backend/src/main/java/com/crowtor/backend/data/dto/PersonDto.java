package com.crowtor.backend.data.dto;

import com.crowtor.backend.data.models.Comment;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Twit;
import lombok.Data;

import javax.persistence.*;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;

@Data
public class PersonDto {
    private Calendar birthday;

    private String firstName;

    private String lastName;

    private String nickName;

    private Boolean isDeleted = false;

    private Boolean isPremium = false;

    private Set<Twit> twits;

    private Set<Twit> likes;

    private Set<Comment> comments;

    private Set<Person> subscription = new HashSet<>();

    private Set<Person> subscribers = new HashSet<>();
}
