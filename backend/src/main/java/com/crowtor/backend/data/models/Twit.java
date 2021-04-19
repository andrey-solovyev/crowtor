package com.crowtor.backend.data.models;

import com.sun.istack.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;

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
    @JoinColumn(name="user_id", nullable=false)
    private User user;
    @Column(insertable = true, updatable = false)
    private LocalDateTime created;
    @PrePersist
    void onCreate() {
        this.setCreated(LocalDateTime.now());
    }
}
