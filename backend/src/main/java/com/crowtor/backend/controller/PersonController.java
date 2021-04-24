package com.crowtor.backend.controller;

import com.crowtor.backend.data.dto.RegistPersonDto;
import com.crowtor.backend.service.PersonService;
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
@RequestMapping("/api/v1/person")
@Slf4j
public class PersonController {
    private static Logger logger = LoggerFactory.getLogger(PersonController.class);
    @Autowired
    private PersonService personService;

    @RequestMapping(method = POST, path = "/subscribe")
    @ResponseStatus(HttpStatus.CREATED)
    public void subscribe(@RequestBody long currentUserId,@RequestBody long subscribeUser) {
        personService.subscribe(currentUserId,subscribeUser);
    }
    @RequestMapping(method = POST, path = "/unSubscribe")
    @ResponseStatus(HttpStatus.CREATED)
    public void unSubscribe(@RequestBody long currentUserId,@RequestBody long subscribeUser) {
        personService.unSubscribe(currentUserId,subscribeUser);
    }
}
