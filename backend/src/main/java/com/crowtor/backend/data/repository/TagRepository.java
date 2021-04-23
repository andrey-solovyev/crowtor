package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.models.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TagRepository  extends JpaRepository<Tag,Long> {
}
