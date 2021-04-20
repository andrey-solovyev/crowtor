package com.crowtor.backend.data.models;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Set;

@Data
@Entity
@NoArgsConstructor
public class Comment {
    @Id
    @GeneratedValue
    @Column(insertable = false, updatable = false)
    private long id;
    @NotNull
    @NotBlank
    private String textComment;
    @ManyToOne
    @JoinColumn(name="person_id", nullable=false)
    private Person person;
}
