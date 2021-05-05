package com.crowtor.backend.controller;

import com.crowtor.backend.service.PersonService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

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
}
