package com.crowtor.backend.data.models;

import com.sun.istack.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Null;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Set;

@Data
@Entity
@NoArgsConstructor
public class Twitt {
    @Id
    @GeneratedValue
    @Column(insertable = false, updatable = false)
    private long id;
    @NotNull
    @NotBlank
    private String textTwit;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "person_id", nullable = false)
    private Person author;
    private boolean isPremium = false;
//    private boolean isModerate;
//    private boolean isDeleted;
    @Column(insertable = true, updatable = false)
    private LocalDateTime created;
    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "twitts")
    private Set<Tag> tags;
    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "likes")
    private Set<Person> personLikes;
    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "dislikes")
    private Set<Person> personDisLikes;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "twitt")
    private Set<Comment> comments;
    @ManyToMany(fetch = FetchType.LAZY, mappedBy = "saveTwitts")
    private Set<Person> personsSave;

    @PrePersist
    void onCreate() {
        this.setCreated(LocalDateTime.now());
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Twitt twitt = (Twitt) o;
        return id == twitt.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Twitt{" +
                "id=" + id +
                ", textTwit='" + textTwit + '\'' +
                ", isPremium=" + isPremium +
                ", created=" + created +
                ", tags=" + tags +
                ", personLikes=" + personLikes +
                ", personDisLikes=" + personDisLikes +
                ", comments=" + comments +
                '}';
    }
}
