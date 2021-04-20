package com.crowtor.backend.data.models;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Calendar;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
public class Person {
    @Id
    @GeneratedValue
    @Column(insertable = false, updatable = false)
    private long id;
    @NotNull
    private Calendar birthday;
    @NotNull
    @NotBlank
    private String firstName;
    @NotNull
    @NotBlank
    private String lastName;
    @NotNull
    @NotBlank
    private String nickName;
    private Boolean isDeleted=false;
    private Boolean isPremium = false;
    @OneToMany(fetch = FetchType.LAZY,mappedBy="person")
    private Set<Twit> twits;
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name="like_twit",
            joinColumns = @JoinColumn(name = "person_id"),
            inverseJoinColumns = @JoinColumn(name = "twit_id")
    )
    private Set<Twit> likes;
    @OneToMany(fetch = FetchType.LAZY,mappedBy="person")
    private Set<Comment> comments;
}
