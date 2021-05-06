package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.PersonDto;
import com.crowtor.backend.data.dto.securutyDto.AuthInfoDto;
import com.crowtor.backend.data.dto.securutyDto.LoginUserDto;
import com.crowtor.backend.data.dto.securutyDto.RegistPersonDto;
import com.crowtor.backend.data.mappers.Mapper;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.repository.PersonRepository;
import com.crowtor.backend.data.repository.RoleRepository;
import com.crowtor.backend.data.repository.TwittRepository;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import com.crowtor.backend.exceptions.InvalidAuthException;
import com.crowtor.backend.security.JwtSupplier;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

@Service
public class PersonService {
    private PersonRepository personRepository;
    private PasswordEncoder passwordEncoder;
    private JwtSupplier jwtSupplier;
    private Mapper mapper;
    private RoleRepository roleRepository;
    private TwittRepository twittRepository;
    private static Logger logger = LoggerFactory.getLogger(PersonService.class);

    public PersonService(PersonRepository personRepository, PasswordEncoder passwordEncoder, JwtSupplier jwtSupplier, Mapper mapper, RoleRepository roleRepository, TwittRepository twittRepository) {
        this.personRepository = personRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtSupplier = jwtSupplier;
        this.mapper = mapper;
        this.roleRepository = roleRepository;
        this.twittRepository = twittRepository;
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
    public void createNewPerson(RegistPersonDto registPersonDto) throws InvalidAuthException {
        var per = new Person();
        if (personRepository.existsByEmail(registPersonDto.getEmail())) throw new InvalidAuthException("Email is exists!");
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

    public PersonDto getUserByNickName(String nickName) {
        var person = personRepository.findByNickName(nickName.toLowerCase());
        if (person == null) throw new EntityNotFoundException("User not found");
        var personDto=mapper.convert(person,PersonDto.class);
        personDto.setTwitts(twittRepository.findAllTwittsFromUser(person.getId()));
        return personDto;
    }

    public List<PersonDto> getSubscriberListUsers(String nickName) {
        var person = personRepository.findByNickName(nickName.toLowerCase());
        if (person == null) throw new EntityNotFoundException("User not found");
        var personsDto=new ArrayList<PersonDto>();
        for (Person p:person.getSubscribers()) {
            var personDto = new PersonDto();
            personDto.setNickName(p.getNickName());
            person.setFirstName(p.getFirstName());
            person.setLastName(p.getLastName());
            personsDto.add(personDto);
        }
        return personsDto;
    }
    public List<PersonDto> getSubscriptionListUsers(String nickName) {
        var person = personRepository.findByNickName(nickName.toLowerCase());
        if (person == null) throw new EntityNotFoundException("User not found");
        var personsDto=new ArrayList<PersonDto>();
        for (Person p:person.getSubscription()) {
            var personDto = new PersonDto();
            personDto.setNickName(p.getNickName());
            person.setFirstName(p.getFirstName());
            person.setLastName(p.getLastName());
            personsDto.add(personDto);
        }
        return personsDto;
    }
}
