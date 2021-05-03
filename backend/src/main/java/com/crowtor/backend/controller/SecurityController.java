package com.crowtor.backend.controller;

import com.crowtor.backend.data.dto.RegistPersonDto;
import com.crowtor.backend.service.PersonService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestBody;
import static org.springframework.web.bind.annotation.RequestMethod.POST;


@RestController
@RequestMapping("/api/v1/security")
@Slf4j
public class SecurityController {
    private static Logger logger = LoggerFactory.getLogger(SecurityController.class);
    private PersonService personService;
    @RequestMapping(method = POST, path = "/register")
    @ResponseStatus(HttpStatus.CREATED)
    public void registerNewUser(@RequestBody RegistPersonDto registerUserDto) {
        personService.createNewPerson(registerUserDto);
    }
}