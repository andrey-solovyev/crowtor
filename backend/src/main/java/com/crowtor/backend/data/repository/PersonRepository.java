package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.models.Person;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PersonRepository extends JpaRepository<Person,Long> {
}
