package com.crowtor.backend.data.models;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

public class Tag {
    @Id
    @GeneratedValue
    @Column(insertable = false, updatable = false)
    private long id;

}
