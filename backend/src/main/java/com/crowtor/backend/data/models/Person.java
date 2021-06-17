package com.crowtor.backend.data.models;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.*;

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
    private String email;
    private Boolean isDeleted = false;
    private Boolean isPremium = false;
    @Column(insertable = true, updatable = false)
    private LocalDateTime dateRegistration;
    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "author")
    private Set<Twitt> twitts;
    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
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

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "user_role",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id")
    )
    private List<Role> roles;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "save_twitt",
            joinColumns = @JoinColumn(name = "person_id"),
            inverseJoinColumns = @JoinColumn(name = "twitt_id")
    )
    private Set<Twitt> saveTwitts;

    @PrePersist
    void onCreate() {
        this.setDateRegistration(LocalDateTime.now());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return id == person.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", birthday=" + birthday +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", nickName='" + nickName + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", isDeleted=" + isDeleted +
                ", isPremium=" + isPremium +
                '}';
    }
}
