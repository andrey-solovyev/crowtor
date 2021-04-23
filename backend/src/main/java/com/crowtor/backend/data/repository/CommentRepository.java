package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.models.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment,Long> {
}
