package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Twitt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
@EnableJpaRepositories
public interface TwittRepository extends JpaRepository<Twitt,Long> {

    @Query(value = "select new com.crowtor.backend.data.dto.TwittFeedDto" +
            "(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName)" +
            " from Twitt t order by t.created")
    List<TwittFeedDto> findAllDto();

    @Query(value = "select new com.crowtor.backend.data.dto.TwittFeedDto" +
            "(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName," +
            "(case when :person = li then true else false end),(case when :person = dis then true else false end))" +
            " from Twitt t join t.personLikes li join t.personDisLikes dis order by t.created")
    List<TwittFeedDto> findAllDtoAuth(@Param("person") Person person);
//(select new com.crowtor.backend.data.dto.CommentFeedDto(c.textComment,c.person.nickName) from Comment c where c.twitt.id = t.id)
    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto" +
            "(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName," +
            "(case when :personId in (t.personLikes) then true else false end),(case when :personId in (t.personDisLikes) then true else false end))" +
            " from Twitt t where t.author in :person " +
            " order by t.created")
    List<TwittFeedDto> findAllBySubscription(@Param("person")Set<Person> person,@Param("personId") long personId);

    @Query(value = "select new com.crowtor.backend.data.dto.TwittFeedDto" +
            "(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName," +
            "(case when :current = li then true else false end),(case when :current = dis then true else false end))" +
            " from Twitt t join t.personLikes li join t.personDisLikes dis where t.author.id=:personId order by t.created")
    Set<TwittFeedDto> findAllDtoForCurrentAndAuthor(@Param("current") Person current,@Param("personId") long personId);

    List<Twitt> findTwittByAuthorIn(Set<Person> personSet);
//select * from Twitt t JOIN user_subscriptions us on t.person_id = us.subscriber_id and us.person_id = 2;
    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto" +
            "(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName)" +
            " from Twitt t where t.author.id=:personId")
    Set<TwittFeedDto> findAllTwittsFromUser(Long personId);

    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto" +
            "(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName)" +
            " from Twitt t where :textSearch IN (t.textTwit)")
    List<TwittFeedDto> findAllTwittsByText(String textSearch);

    @Query("select new com.crowtor.backend.data.dto.TwittFeedDto" +
            "(t.id,t.textTwit,t.isPremium,t.personLikes.size,t.personDisLikes.size,t.created,t.author.nickName,t.author.firstName,t.author.lastName)" +
            " from Twitt t where t.isModerate = false")
    List<TwittFeedDto> findAllTwittWithoutModerate();

}
