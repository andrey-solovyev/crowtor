package com.crowtor.backend.data.models;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "role", schema = "public")
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;

    @ManyToMany(mappedBy = "roles")
    private List<Person> persons;
}
