package com.crowtor.backend.controller;

import com.crowtor.backend.data.dto.CreateTwittDto;
import com.crowtor.backend.data.dto.RegistPersonDto;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import com.crowtor.backend.service.TwittService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
@RequestMapping("/api/v1/twitt")
@Slf4j
public class TwitController {
    private static Logger logger = LoggerFactory.getLogger(SecurityController.class);
    @Autowired
    private TwittService twittService;
    @RequestMapping(method = POST, path = "/createTwit")
    @ResponseStatus(HttpStatus.CREATED)
    public void createTwitt(@RequestBody CreateTwittDto createTwittDto) throws EntityNotFoundException {
        twittService.createTwitt(createTwittDto);
    }
    @RequestMapping(method = POST, path = "/like")
    @ResponseStatus(HttpStatus.CREATED)
    public void likeTwitt(@RequestBody CreateTwittDto createTwittDto) throws EntityNotFoundException {
        twittService.createTwitt(createTwittDto);
    }
    @RequestMapping(method = POST, path = "/dislike")
    @ResponseStatus(HttpStatus.CREATED)
    public void dislikeTwitt(@RequestBody CreateTwittDto createTwittDto) throws EntityNotFoundException{
        twittService.createTwitt(createTwittDto);
    }
}
