package com.crowtor.backend.controller;

import com.crowtor.backend.data.dto.CommentDto;
import com.crowtor.backend.data.dto.CreateTwittDto;
import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.models.Twitt;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import com.crowtor.backend.service.TwittService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

@RestController
@RequestMapping("/api/v1/twitt")
@Slf4j
public class TwittController {
    //eyJhbGciOiJIUzM4NCJ9.eyJleHAiOjE2Mjc5MzgwMDAsInN1YiI6ImFuZHJleV9zb2xvdnlldiIsImlkIjoyLCJyb2xlcyI6IlJPTEVfVVNFUiJ9.53rslR0T0-IhEDb4IQADCxo11dW4nKlozEemoAeKaaN4fXTv-padrySWYBhBJ4yx
    private static Logger logger = LoggerFactory.getLogger(SecurityController.class);
    private TwittService twittService;

    public TwittController(TwittService twittService) {
        this.twittService = twittService;
    }

    @RequestMapping(method = POST, path = "/createTwit")
    @ResponseStatus(HttpStatus.CREATED)
    public void createTwitt(Authentication authentication, @RequestBody CreateTwittDto createTwittDto) throws EntityNotFoundException {
        if (authentication.isAuthenticated()) twittService.createTwitt(authentication.getName(), createTwittDto);
    }

    @RequestMapping(method = POST, path = "/reTwitt")
    @ResponseStatus(HttpStatus.CREATED)
    public void reTwitt(Authentication authentication, @RequestBody CreateTwittDto createTwittDto,@RequestParam long originalTwitt) throws EntityNotFoundException {
        if (authentication.isAuthenticated()) twittService.reTwitt(authentication.getName(), createTwittDto,originalTwitt);
    }

    @RequestMapping(method = POST, path = "/like")
    @ResponseStatus(HttpStatus.CREATED)
    public void likeTwitt(Authentication authentication, @RequestParam long twittId) throws EntityNotFoundException {
        if (authentication.isAuthenticated()) twittService.likeTwitt(authentication.getName(), twittId);
    }

    @RequestMapping(method = POST, path = "/dislike")
    @ResponseStatus(HttpStatus.CREATED)
    public void dislikeTwitt(Authentication authentication, @RequestParam long twittId) throws EntityNotFoundException {
        if (authentication.isAuthenticated()) twittService.dislikeTwitt(authentication.getName(), twittId);
    }

    @RequestMapping(method = POST, path = "/findAllTwitt")
    public ResponseEntity<List<TwittFeedDto>> findAll(Authentication authentication) {
        return authentication!=null && authentication.isAuthenticated()
                ? new ResponseEntity<>(twittService.findAllSubc(authentication.getName()), HttpStatus.OK)
                : new ResponseEntity<>(twittService.findAll(), HttpStatus.OK);
    }

    @RequestMapping(method = GET, path = "/searchTwittsByText")
    public ResponseEntity<List<TwittFeedDto>> searchTwittsByText(@RequestParam String text) {
        return new ResponseEntity<>(twittService.searchTextTwitts(text), HttpStatus.OK);
    }
    @RequestMapping(method = GET, path = "/{id}")
    public ResponseEntity<TwittFeedDto> searchTwittsByText(@PathVariable("id") long id) {
        return new ResponseEntity<>(twittService.findById(id), HttpStatus.OK);
    }

    @RequestMapping(method = POST, path = "/comment")
    @ResponseStatus(HttpStatus.CREATED)
    public void commentTwitt(Authentication authentication, @RequestBody CommentDto commentDto) {
        if (authentication.isAuthenticated()) {
            twittService.addComment(authentication.getName(), commentDto);
        }
    }

    @RequestMapping(method = DELETE, path = "/delete")
    public void deleteTwitt(Authentication authentication, @RequestParam long twittId) {
        if (authentication.isAuthenticated()) {
            twittService.deleteById(authentication.getName(), twittId);
        }
    }

    @RequestMapping(method = PUT, path = "/edit")
    public void editTwitt(Authentication authentication,@RequestBody CreateTwittDto createTwittDto ,@RequestParam long twittId) {
        if (authentication.isAuthenticated()) {
            twittService.editTwittById(createTwittDto,authentication.getName(),twittId);
        }
    }
    @RequestMapping(method = POST, path = "/saveTwitt")
    public void saveTwittForUser(Authentication authentication,@RequestParam long twittId) {
        if (authentication.isAuthenticated()) {
            twittService.saveTwittForUser(authentication.getName(),twittId);
        }
    }
    @RequestMapping(method = DELETE, path = "/deleteSaveTwitt")
    public void deleteTwittForUser(Authentication authentication,@RequestParam long twittId) {
        if (authentication.isAuthenticated()) {
            twittService.deleteTwittForUser(authentication.getName(),twittId);
        }
    }

    @RequestMapping(method = POST, path = "/getSaveTwitt")
    public ResponseEntity<List<TwittFeedDto>> editTwitt(Authentication authentication) {
        if (!authentication.isAuthenticated()) return null;
        return new ResponseEntity<>(twittService.getSaveTwitt(authentication.getName()), HttpStatus.OK);
    }


    @RequestMapping(method = POST, path = "/getLikeTwitt")
    public ResponseEntity<List<TwittFeedDto>> getLikeTwitt(Authentication authentication) {
        if (!authentication.isAuthenticated()) return null;
        return new ResponseEntity<>(twittService.getLikeTwitt(authentication.getName()), HttpStatus.OK);
    }

    @RequestMapping(method = POST, path = "/moderate")
    public ResponseEntity<List<TwittFeedDto>> moderate(Authentication authentication) {
        if (!authentication.isAuthenticated()) return null;
        return new ResponseEntity<>(twittService.getModerateTwitts(authentication.getName()), HttpStatus.OK);
    }
    @RequestMapping(method = POST, path = "/accessTwitt")
    public void accessTwitt(Authentication authentication,@RequestParam long twittId) {
        if (!authentication.isAuthenticated()) return;
        twittService.accessTwitt(authentication.getName(),twittId);
    }
    @RequestMapping(method = POST, path = "/disAccessTwitt")
    public void disAccessTwitt(Authentication authentication,@RequestParam long twittId) {
        if (!authentication.isAuthenticated()) return;
        twittService.disAccessTwitt(authentication.getName(),twittId);
    }
}
