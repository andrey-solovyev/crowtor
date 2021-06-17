package com.crowtor.backend.controller;

import com.crowtor.backend.data.dto.PersonDto;
import com.crowtor.backend.service.PersonService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
@RequestMapping("/api/v1/person")
@Slf4j
public class PersonController {
    private static Logger logger = LoggerFactory.getLogger(PersonController.class);
    private PersonService personService;

    public PersonController(PersonService personService) {
        this.personService = personService;
    }

    @RequestMapping(method = POST, path = "/currentUser")
    public ResponseEntity<PersonDto> currentUser(Authentication authentication) {
        return new ResponseEntity<>(personService.getUserByNickName(authentication.getName(),null),HttpStatus.OK);
    }
    @RequestMapping(method = GET,path = "/getByNickName")
    public ResponseEntity<PersonDto> getByNickName(Authentication authentication,@RequestParam String nickName) {
        return new ResponseEntity<>(personService.getUserByNickName(nickName,authentication),HttpStatus.OK);
    }
    @RequestMapping(method = GET,path = "/getSubscribe")
    public ResponseEntity<List<PersonDto>> getSubscribeList(@RequestParam String nickName) {
        return new ResponseEntity<>(personService.getSubscriberListUsers(nickName),HttpStatus.OK);
    }
    @RequestMapping(method = GET,path = "/getSubscription")
    public ResponseEntity<List<PersonDto>> getSubscriptionList(@RequestParam String nickName) {
        return new ResponseEntity<>(personService.getSubscriptionListUsers(nickName),HttpStatus.OK);
    }
    @RequestMapping(method = POST, path = "/subscribe")
    @ResponseStatus(HttpStatus.CREATED)
    public void subscribe(Authentication authentication, @RequestParam long subscribeUser) {
        personService.subscribe(authentication.getName(),subscribeUser);
    }
    @RequestMapping(method = POST, path = "/unSubscribe")
    @ResponseStatus(HttpStatus.CREATED)
    public void unSubscribe(Authentication authentication,@RequestParam long subscribeUser) {
        personService.unSubscribe(authentication.getName(),subscribeUser);
    }

    @RequestMapping(method = GET, path = "/search")
    public ResponseEntity<List<PersonDto>> searchPersons(Authentication authentication,@RequestParam("nickName") String nickname) {
        return new ResponseEntity<>(personService.findPersonByNickNameAll(nickname, authentication),HttpStatus.OK);
    }

}
