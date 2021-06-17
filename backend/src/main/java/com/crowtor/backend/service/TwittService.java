package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.CommentDto;
import com.crowtor.backend.data.dto.CreateTwittDto;
import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.mappers.Impl.TwittToTwittFeedDtoObjectMapper;
import com.crowtor.backend.data.mappers.Mapper;
import com.crowtor.backend.data.models.Comment;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Tag;
import com.crowtor.backend.data.models.Twitt;
import com.crowtor.backend.data.repository.CommentRepository;
import com.crowtor.backend.data.repository.PersonRepository;
import com.crowtor.backend.data.repository.TagRepository;
import com.crowtor.backend.data.repository.TwittRepository;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;

@Service
public class TwittService {
    private TwittRepository twittRepository;

    private PersonRepository personRepository;

    private TagRepository tagRepository;

    private CommentRepository commentRepository;

    private TwittToTwittFeedDtoObjectMapper mapper;

    public TwittService(TwittRepository twittRepository, PersonRepository personRepository, TagRepository tagRepository, CommentRepository commentRepository, TwittToTwittFeedDtoObjectMapper mapper) {
        this.twittRepository = twittRepository;
        this.personRepository = personRepository;
        this.tagRepository = tagRepository;
        this.commentRepository = commentRepository;
        this.mapper = mapper;
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
        twit.setModerate(false);
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

    private List<TwittFeedDto> setTagsAndComments( List<TwittFeedDto> twitts){
        for (TwittFeedDto twittFeedDto:twitts){
            var t = twittRepository.findById(twittFeedDto.getId()).get();
            twittFeedDto.setTags(t.getTags());
            twittFeedDto.setCommentSet(commentRepository.findByTwittId(twittFeedDto.getId()));
        }
        return twitts;
    }

    public List<TwittFeedDto> findAll() {
        var twitts =  twittRepository.findAllDto();
        return setTagsAndComments(twitts);
    }

    public List<TwittFeedDto> findAllSubc(String nickName) {
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("Person not found!");
        List<TwittFeedDto> result = new ArrayList<>();
        if (person.getSubscription().size()> 0){
            var t = twittRepository.findTwittByAuthorIn(person.getSubscription());
            if (t.size() != 0){
                for (Twitt twitt:t){
                    var twittDto = mapper.convert(twitt);
                    if (twitt.getPersonLikes().contains(person)){
                        twittDto.setLike(true);
                    }else if (twitt.getPersonDisLikes().contains(person)){
                        twittDto.setDislike(true);
                    }
                    result.add(twittDto);
                }
            }
        } else{
            result = twittRepository.findAllDtoAuth(person);
        }
        return setTagsAndComments(result);
    }


    public void addComment(String nickName,CommentDto commentDto) {
        var twitt = twittRepository.findById(commentDto.getTwittId());
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        if (!twitt.isPresent()) throw new EntityNotFoundException(commentDto.getTwittId(), Twitt.class.toString());
        var comments = new Comment();
        comments.setTextComment(commentDto.getComment());
        comments.setPerson(person);
        comments.setTwitt(twitt.get());
        commentRepository.save(comments);
    }

    public TwittFeedDto findById(long id){
        var twitt = twittRepository.findById(id);
        if (!twitt.isPresent()) throw new EntityNotFoundException("Twitt not found!");
        var twittDto = mapper.convert(twitt.get());
        twittDto.setCommentSet(commentRepository.findByTwittId(twitt.get().getId()));
        twittDto.setTags(twitt.get().getTags());
        return twittDto;
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

    public void saveTwittForUser(String nickName, long twittId) {
        var twitt = twittRepository.findById(twittId);
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId, Twitt.class.toString());
        person.getSaveTwitts().add(twitt.get());
        personRepository.save(person);
    }
    public void deleteTwittForUser(String nickName, long twittId) {
        var twitt = twittRepository.findById(twittId);
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId, Twitt.class.toString());
        twitt.get().setDeleted(true);
        twittRepository.save(twitt.get());
    }

    public List<TwittFeedDto> getSaveTwitt(String nickName) {
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        List<TwittFeedDto> result = new ArrayList<>();
        for (Twitt twitt:person.getSaveTwitts()){
            var twittDto = mapper.convert(twitt);
            if (twitt.getPersonLikes().contains(person)){
                twittDto.setLike(true);
            }else if (twitt.getPersonDisLikes().contains(person)){
                twittDto.setDislike(true);
            }
            result.add(twittDto);
        }
        return result;
    }

    public List<TwittFeedDto> getModerateTwitts(String nickName) {
        var person = personRepository.findByNickName(nickName);
        if (person == null || person.getRoles().contains("USER_ROLE")) throw new EntityNotFoundException("person not found!");
        return twittRepository.findAllTwittWithoutModerate();
    }

    public void accessTwitt(String nickName,long twittId) {
        var person = personRepository.findByNickName(nickName);
        if (person == null || person.getRoles().contains("USER_ROLE")) throw new EntityNotFoundException("person not found!");
        var twitt = twittRepository.findById(twittId);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId, Twitt.class.toString());
        twitt.get().setModerate(true);
    }

    public void disAccessTwitt(String nickName, long twittId) {
        var person = personRepository.findByNickName(nickName);
        if (person == null || person.getRoles().contains("USER_ROLE")) throw new EntityNotFoundException("person not found!");
        var twitt = twittRepository.findById(twittId);
        if (!twitt.isPresent()) throw new EntityNotFoundException(twittId, Twitt.class.toString());
        twitt.get().setModerate(false);
    }

    public List<TwittFeedDto> getLikeTwitt(String nickName) {
        var person = personRepository.findByNickName(nickName);
        if (person == null) throw new EntityNotFoundException("person not found!");
        List<TwittFeedDto> result = new ArrayList<>();
        for (Twitt twitt:person.getLikes()){
            var twittDto = mapper.convert(twitt);
            if (twitt.getPersonLikes().contains(person)){
                twittDto.setLike(true);
            }
            result.add(twittDto);
        }
        return result;
    }
}
