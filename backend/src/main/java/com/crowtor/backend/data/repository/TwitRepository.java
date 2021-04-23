package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.dto.TwitFeedDto;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Twit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Repository
public interface TwitRepository extends JpaRepository<Twit,Long> {
    @Query("select t.id,t.textTwit,t.isPremium,Twit.personLikes.size,t.created from Twit t order by t.created")
    List<TwitFeedDto> findAllDto();
    @Query("select t.id,t.textTwit,t.isPremium,Twit.personLikes.size,t.created from Twit t where t.person.id in (select p.subscription.id from Person p where p.id=:personId) order by t.created")
    List<TwitFeedDto> findAllBySubscription(Long personId);
эластик серч
}
