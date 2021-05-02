package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.CreateTwittDto;
import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Twitt;
import com.crowtor.backend.data.repository.PersonRepository;
import com.crowtor.backend.data.repository.TwittRepository;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TwittService {
    private TwittRepository twittRepository;

    private PersonRepository personRepository;

    public TwittService(TwittRepository twittRepository, PersonRepository personRepository) {
        this.twittRepository = twittRepository;
        this.personRepository = personRepository;
    }

    public void createTwitt(CreateTwittDto createTwittDto) throws EntityNotFoundException {
        var twit=new Twitt();
        twit.setTextTwit(createTwittDto.getTextTwit());
        var person = personRepository.findById(createTwittDto.getPersonId());
        person.ifPresent(twit::setPerson);
        if (!person.isPresent()) throw new EntityNotFoundException(createTwittDto.getPersonId(),"person");
        twit.setPremium(createTwittDto.isPremium());
        twit.setTags(createTwittDto.getTagSet());
        twittRepository.save(twit);
    }
    public void likeTwitt(long currentUserId,long twittId) throws EntityNotFoundException {
        var twitt=twittRepository.findById(twittId);
        var person=personRepository.findById(currentUserId);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId,Twitt.class.toString());
        if (!person.isPresent()) throw new EntityNotFoundException(currentUserId,"person");
        twitt.get().getPersonLikes().add(person.get());
    }
    public void dislikeTwitt(long currentUserId,long twittId) throws EntityNotFoundException {
        var twitt=twittRepository.findById(twittId);
        var person=personRepository.findById(currentUserId);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId,Twitt.class.toString());
        if (!person.isPresent()) throw new EntityNotFoundException(currentUserId,"person");
        twitt.get().getPersonLikes().remove(person.get());
    }
}
