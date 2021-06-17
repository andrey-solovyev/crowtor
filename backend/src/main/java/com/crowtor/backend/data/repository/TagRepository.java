package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.models.Tag;
import com.crowtor.backend.data.models.Twitt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Set;

public interface TagRepository  extends JpaRepository<Tag,Long> {
    boolean existsByTextTag(String name);
    Tag getByTextTag(String name);
    @Query("select t from Tag t where :twitt in (t.twitts)")
    Set<String> findTagByTwittId(Twitt twitt);
}
