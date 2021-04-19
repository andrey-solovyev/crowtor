package com.crowtor.backend.data.models;

import com.sun.istack.NotNull;
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
public class User {
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
    @OneToMany(fetch = FetchType.LAZY,mappedBy="user")
    private Set<Twit> twits;
}
