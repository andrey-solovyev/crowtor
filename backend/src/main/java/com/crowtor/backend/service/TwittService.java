package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.CommentDto;
import com.crowtor.backend.data.dto.CreateTwittDto;
import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Tag;
import com.crowtor.backend.data.models.Twitt;
import com.crowtor.backend.data.repository.PersonRepository;
import com.crowtor.backend.data.repository.TagRepository;
import com.crowtor.backend.data.repository.TwittRepository;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;

@Service
public class TwittService {
    private TwittRepository twittRepository;

    private PersonRepository personRepository;

    private TagRepository tagRepository;

    public TwittService(TwittRepository twittRepository, PersonRepository personRepository, TagRepository tagRepository) {
        this.twittRepository = twittRepository;
        this.personRepository = personRepository;
        this.tagRepository = tagRepository;
    }

    public void createTwitt(String nickName, CreateTwittDto createTwittDto) throws EntityNotFoundException {
        var twit = new Twitt();
        twit.setTextTwit(createTwittDto.getTextTwit());
        var person = personRepository.findByNickName(nickName);
        if (person != null) twit.setAuthor(person);
        else throw new EntityNotFoundException("Person with nickname not found!!!");
        twit.setPremium(person.getIsPremium());
        if (createTwittDto.getTagSet()!=null && createTwittDto.getTagSet().size()>0){
            twit.setTags(new HashSet<Tag>());
            for (String tag: createTwittDto.getTagSet()){
                Tag t;
                if (tagRepository.existsByTextTag(tag)){
                    t = tagRepository.getByTextTag(tag);
                } else {
                    t = new Tag();
                    t.setTextTag(tag);
                    tagRepository.save(t);
                }
                twit.getTags().add(t);
            }
        }
        twittRepository.save(twit);
    }
    public List<TwittFeedDto> searchTextTwitts(String text){
        List<TwittFeedDto> twittFeedDtos=twittRepository.findAllTwittsByText(text);
        return twittFeedDtos;
    }
    public void likeTwitt(String nickName, long twittId) throws EntityNotFoundException {
        var twitt = twittRepository.findById(twittId);
        var person = personRepository.findByNickName(nickName);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId, Twitt.class.toString());
        if (person == null) throw new EntityNotFoundException("person not found!");
        var t = twitt.get();
        if (person.getLikes().contains(twitt.get())) person.getLikes().remove(t);
        else person.getLikes().add(t);
        personRepository.save(person);
    }

    public void dislikeTwitt(String nickName, long twittId) throws EntityNotFoundException {
        var twitt = twittRepository.findById(twittId);
        var person = personRepository.findByNickName(nickName);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId, Twitt.class.toString());
        if (person == null) throw new EntityNotFoundException("person not found!");
        if (person.getLikes().contains(twitt.get())) person.getLikes().remove(twitt.get());
        person.getDislikes().add(twitt.get());
        personRepository.save(person);
    }

    public List<TwittFeedDto> findAll() {
        return twittRepository.findAllDto();
    }

    public List<TwittFeedDto> findAllSubc(String nickName) {
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        return findAll();
//                ? twittRepository.findAllBySubscription(person.getId())
//                : ;
    }

    public void addComment(String nickName,CommentDto commentDto) {
        var twitt = twittRepository.findById(commentDto.getTwittId());
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        if (!twitt.isPresent()) throw new EntityNotFoundException(commentDto.getTwittId(), Twitt.class.toString());
        twitt.get().getPersonLikes().add(person);
        twittRepository.save(twitt.get());

    }

    public void deleteById(String nickName, long twittId) {
        var twitt = twittRepository.findById(twittId);
        var person = personRepository.findByNickName(nickName);
        twittRepository.delete(twitt.get());
    }
    public void editTwittById(CreateTwittDto createTwittDto,String nickName, long twittId) {
        var twitt = twittRepository.findById(twittId);
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId, Twitt.class.toString());
        twitt.get().setTextTwit(createTwittDto.getTextTwit());
        twittRepository.save(twitt.get());
    }
}
