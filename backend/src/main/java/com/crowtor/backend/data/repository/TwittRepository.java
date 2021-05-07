package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.models.Twitt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository

public interface TwittRepository extends JpaRepository<Twitt,Long> {
    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName) from Twitt t order by t.created")
    List<TwittFeedDto> findAllDto();
    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName) from Twitt t where t.author.id in (select p.subscription from Person p where p.id=:personId) order by t.created")
    List<TwittFeedDto> findAllBySubscription(Long personId);

    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName) from Twitt t where t.author.id=:personId")
    Set<TwittFeedDto> findAllTwittsFromUser(Long personId);

    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName) from Twitt t where :textSearch IN (t.textTwit)")
    List<TwittFeedDto> findAllTwittsByText(String textSearch);


}
