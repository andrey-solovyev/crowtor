package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.securutyDto.AuthInfoDto;
import com.crowtor.backend.data.dto.securutyDto.LoginUserDto;
import com.crowtor.backend.data.dto.securutyDto.RegistPersonDto;
import com.crowtor.backend.data.mappers.Mapper;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.repository.PersonRepository;
import com.crowtor.backend.data.repository.RoleRepository;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import com.crowtor.backend.security.JwtSupplier;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class PersonService {
    private PersonRepository personRepository;
    private PasswordEncoder passwordEncoder;
    private JwtSupplier jwtSupplier;
    private Mapper mapper;
    private RoleRepository roleRepository;
    private static Logger logger = LoggerFactory.getLogger(PersonService.class);

    public PersonService(PersonRepository personRepository, PasswordEncoder passwordEncoder, JwtSupplier jwtSupplier, Mapper mapper, RoleRepository roleRepository) {
        this.personRepository = personRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtSupplier = jwtSupplier;
        this.mapper = mapper;
        this.roleRepository = roleRepository;
    }

    public Person findPersonByNickName(String nickName) throws EntityNotFoundException {
        var person = personRepository.findByNickName(nickName);
        if (person == null) {
            throw new EntityNotFoundException("Invalid login or password");

        }
        return person;
    }
    public Person findPersonByEmail(String email) throws EntityNotFoundException {
        var person = personRepository.findByEmail(email);
        if (person == null) {
            throw new EntityNotFoundException("Invalid login or password");

        }
        return person;
    }
    public void createNewPerson(RegistPersonDto registPersonDto){
        var per = new Person();
        per.setBirthday(registPersonDto.getBirthday());
        per.setFirstName(registPersonDto.getFirstName());
        per.setLastName(registPersonDto.getLastName());
        per.setNickName(registPersonDto.getNickName());
        per.setEmail(registPersonDto.getEmail());
        per.setPassword(passwordEncoder.encode(registPersonDto.getPassword()));
        var userRole = roleRepository.findByName("ROLE_USER");
        per.setRoles(Collections.singletonList(userRole));
        personRepository.save(per);
    }
    public void subscribe(String nickName, Long subscribeIdUser) {
        Person person = personRepository.findByNickName(nickName);
        person.getSubscription().add(personRepository.getOne(subscribeIdUser));
        personRepository.save(person);
    }
    public void unSubscribe(String nickName, Long subscribeIdUser) {
        Person person = personRepository.findByNickName(nickName);
        person.getSubscription().remove(personRepository.getOne(subscribeIdUser));
        personRepository.save(person);
    }
    public AuthInfoDto loginPerson(LoginUserDto loginUserDto) throws EntityNotFoundException {
        var user = findPersonByEmail(loginUserDto.getEmail());
        if (passwordEncoder.matches(loginUserDto.getPassword(), user.getPassword())) {
            var token = jwtSupplier.createTokenForUser(user.getId(),user.getNickName(), user.getRoles());
            return new AuthInfoDto(token);
        } else{
            throw new EntityNotFoundException("Invalid login or password");
        }
    }
}
