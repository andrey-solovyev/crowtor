package com.crowtor.backend.data.repository;

import com.crowtor.backend.data.models.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Repository
public interface PersonRepository extends JpaRepository<Person, Long> {
    @Query("select p from Person p where lower(p.nickName)=lower(:nickName)")
    Person findByNickName(@Param("nickName") String nickName);

    @Query("select p from Person p where lower(p.nickName) LIKE lower(?1)")
    List<Person> findByNickNameAll(@Param("nickName") String nickname);

    @Query("select p from Person p where p.email=:email")
    Person findByEmail(@Param("email")String email);

    boolean existsByEmail(String email);

    boolean existsByNickName(String nickName);
}
