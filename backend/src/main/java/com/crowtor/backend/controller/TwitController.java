package com.crowtor.backend.controller;

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
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
@RequestMapping("/api/v1/twitt")
@Slf4j
public class TwitController {
    //eyJhbGciOiJIUzM4NCJ9.eyJleHAiOjE2Mjc5MzgwMDAsInN1YiI6ImFuZHJleV9zb2xvdnlldiIsImlkIjoyLCJyb2xlcyI6IlJPTEVfVVNFUiJ9.53rslR0T0-IhEDb4IQADCxo11dW4nKlozEemoAeKaaN4fXTv-padrySWYBhBJ4yx
    private static Logger logger = LoggerFactory.getLogger(SecurityController.class);
    private TwittService twittService;

    public TwitController(TwittService twittService) {
        this.twittService = twittService;
    }

    @RequestMapping(method = POST, path = "/createTwit")
    @ResponseStatus(HttpStatus.CREATED)
    public void createTwitt(Authentication authentication,@RequestBody CreateTwittDto createTwittDto) throws EntityNotFoundException {
        if (authentication.isAuthenticated()) twittService.createTwitt(authentication.getName(),createTwittDto);
    }
    @RequestMapping(method = POST, path = "/like")
    @ResponseStatus(HttpStatus.CREATED)
    public void likeTwitt(Authentication authentication,@RequestParam long twittId) throws EntityNotFoundException {
        if (authentication.isAuthenticated()) twittService.likeTwitt(authentication.getName(),twittId);
    }
    @RequestMapping(method = POST, path = "/dislike")
    @ResponseStatus(HttpStatus.CREATED)
    public void dislikeTwitt(Authentication authentication,@RequestParam long twittId) throws EntityNotFoundException{
        if (authentication.isAuthenticated()) twittService.dislikeTwitt(authentication.getName(),twittId);
    }
    @RequestMapping(method = POST, path = "/findAllTwitt")
    public ResponseEntity<List<TwittFeedDto>> findAll(Authentication authentication){
        return new ResponseEntity<>(twittService.findAll(),HttpStatus.OK);
    }
    @RequestMapping(method = GET,path = "/searchTwittsByText")
    public ResponseEntity<List<TwittFeedDto>> searchTwittsByText(@RequestParam String text){
        return new ResponseEntity<>(twittService.searchTextTwitts(text),HttpStatus.OK);
    }
}
