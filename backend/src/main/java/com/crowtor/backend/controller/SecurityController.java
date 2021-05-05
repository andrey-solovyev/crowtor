package com.crowtor.backend.controller;

import com.crowtor.backend.data.dto.securutyDto.AuthInfoDto;
import com.crowtor.backend.data.dto.securutyDto.LoginUserDto;
import com.crowtor.backend.data.dto.securutyDto.RegistPersonDto;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import com.crowtor.backend.service.PersonService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
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

    public SecurityController(PersonService personService) {
        this.personService = personService;
    }

    @RequestMapping(method = POST, path = "/register")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity registerNewUser(@RequestBody RegistPersonDto registerUserDto) {
        if (registerUserDto == null || registerUserDto.getNickName()==null || registerUserDto.getPassword()==null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        personService.createNewPerson(registerUserDto);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
    @RequestMapping(method = POST, path = "/login")
    public ResponseEntity<AuthInfoDto> loginUser(@RequestBody LoginUserDto loginUserDto) throws EntityNotFoundException {
        if (loginUserDto == null || loginUserDto.getEmail()==null || loginUserDto.getPassword()==null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        var auth = personService.loginPerson(loginUserDto);
        return auth != null
                ? new ResponseEntity<AuthInfoDto>(auth, HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }
}
