package com.crowtor.backend.data.models;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
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
    private String password;
    private Boolean isDeleted = false;
    private Boolean isPremium = false;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "person")
    private Set<Twitt> twitts;
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "like_twit",
            joinColumns = @JoinColumn(name = "person_id"),
            inverseJoinColumns = @JoinColumn(name = "twit_id")
    )
    private Set<Twitt> likes;
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "dislike_twit",
            joinColumns = @JoinColumn(name = "person_id"),
            inverseJoinColumns = @JoinColumn(name = "twit_id")
    )
    private Set<Twitt> dislikes;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "person")
    private Set<Comment> comments;
    @ManyToMany
    @JoinTable(
            name = "user_subscriptions",
            joinColumns = {@JoinColumn(name = "subscriber_id")},
            inverseJoinColumns = {@JoinColumn(name = "person_id")}
    )
    private Set<Person> subscription = new HashSet<>();
    @ManyToMany
    @JoinTable(
            name = "user_subscriptions",
            joinColumns = {@JoinColumn(name = "person_id")},
            inverseJoinColumns = {@JoinColumn(name = "subscriber_id")}
    )
    private Set<Person> subscribers = new HashSet<>();

    @ManyToMany()
    @JoinTable(
            name = "user_role",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id")
    )
    private List<Role> roles;

}
