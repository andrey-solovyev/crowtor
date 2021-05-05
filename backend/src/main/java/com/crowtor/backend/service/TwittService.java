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

import java.util.List;
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
        person.ifPresent(twit::setAuthor);
        if (!person.isPresent()) throw new EntityNotFoundException(createTwittDto.getPersonId(),"person");
        twit.setPremium(createTwittDto.isPremium());
        twit.setTags(createTwittDto.getTagSet());
        twittRepository.save(twit);
    }
    public void likeTwitt(String nickName,long twittId) throws EntityNotFoundException {
        var twitt=twittRepository.findById(twittId);
        var person=personRepository.findByNickName(nickName);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId,Twitt.class.toString());
        if (person == null) throw new EntityNotFoundException("person not found!");
        var t = twitt.get();
        if (person.getLikes().contains(twitt.get())) person.getLikes().remove(t);
        else person.getLikes().add(t);
        //t.getPersonLikes().add(person);
        //twitt.get().setPersonLikes(twitt.get().getPersonLikes().add(person));
        //twittRepository.saveAndFlush(t);
        personRepository.save(person);
    }
    public void dislikeTwitt(String nickName,long twittId) throws EntityNotFoundException {
        var twitt=twittRepository.findById(twittId);
        var person=personRepository.findByNickName(nickName);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId,Twitt.class.toString());
        if (person == null) throw new EntityNotFoundException("person not found!");
        if ( person.getLikes().contains(twitt.get())) person.getLikes().remove(twitt.get());
        person.getDislikes().add(twitt.get());
        personRepository.save(person);
    }
    public List<TwittFeedDto> findAll(){
        return twittRepository.findAllDto();
    }
}
