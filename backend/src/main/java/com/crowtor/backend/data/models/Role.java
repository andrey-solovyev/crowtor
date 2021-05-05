package com.crowtor.backend.data.models;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "role", schema = "public")
@Data
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;

    @ManyToMany(mappedBy = "roles")
    private List<Person> persons;
}
