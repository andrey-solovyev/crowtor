package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.dto.CommentFeedDto;
import com.crowtor.backend.data.models.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Set;

public interface CommentRepository extends JpaRepository<Comment,Long> {
    @Query("select new com.crowtor.backend.data.dto.CommentFeedDto(c.id,c.textComment,c.person.nickName) from Comment c where c.twitt.id = :twittId")
    Set<CommentFeedDto> findByTwittId(long twittId);
}
