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
    @Autowired
    private TwittRepository twittRepository;
    @Autowired
    private PersonRepository personRepository;
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
}
