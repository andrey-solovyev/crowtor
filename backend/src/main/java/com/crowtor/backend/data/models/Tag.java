package com.crowtor.backend.data.models;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Set;
@Entity
@Data
@NoArgsConstructor
public class Tag {
    @Id
    @GeneratedValue
    @Column(insertable = false, updatable = false)
    private long id;
    @NotNull
    @NotBlank
    private String textTag;
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name="twitt_tag",
            joinColumns = @JoinColumn(name = "tag_id"),
            inverseJoinColumns = @JoinColumn(name = "twit_id")
    )
    private Set<Twitt> twitts;
}
