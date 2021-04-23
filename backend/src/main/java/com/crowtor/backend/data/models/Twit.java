package com.crowtor.backend.data.models;

import com.sun.istack.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.util.Set;

@Data
@Entity
@NoArgsConstructor
public class Twit {
    @Id
    @GeneratedValue
    @Column(insertable = false, updatable = false)
    private long id;
    @NotNull
    @NotBlank
    private String textTwit;
    @ManyToOne
    @JoinColumn(name="person_id", nullable=false)
    private Person person;
    private boolean isPremium=false;
    @Column(insertable = true, updatable = false)
    private LocalDateTime created;
    @PrePersist
    void onCreate() {
        this.setCreated(LocalDateTime.now());
    }
    @ManyToMany(mappedBy = "twits")
    private Set<Tag> tags;
    @ManyToMany(mappedBy = "likes")
    private Set<Person> personLikes;
    @OneToMany(fetch = FetchType.LAZY,mappedBy="twit")
    private Set<Comment> comments;

}
