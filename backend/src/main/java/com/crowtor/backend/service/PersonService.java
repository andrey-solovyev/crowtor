package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.PersonDto;
import com.crowtor.backend.data.dto.TwittFeedDto;
import com.crowtor.backend.data.dto.securutyDto.AuthInfoDto;
import com.crowtor.backend.data.dto.securutyDto.LoginUserDto;
import com.crowtor.backend.data.dto.securutyDto.RegistPersonDto;
import com.crowtor.backend.data.mappers.Mapper;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.models.Role;
import com.crowtor.backend.data.models.Twitt;
import com.crowtor.backend.data.repository.PersonRepository;
import com.crowtor.backend.data.repository.RoleRepository;
import com.crowtor.backend.data.repository.TwittRepository;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import com.crowtor.backend.exceptions.InvalidAuthException;
import com.crowtor.backend.security.JwtSupplier;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
            throw new EntityNotFoundException("Entity Not Found Exception");
        }
        return person;
    }

    public List<PersonDto> findPersonByNickNameAll(String nickName, Authentication authentication) {
        List<PersonDto> result = new ArrayList<>();
        Person person = null;
        if (authentication != null) {
            person = personRepository.findByNickName(authentication.getName());
        }
        var persons = personRepository.findByNickNameAll(nickName + "%");
        for (Person p : persons) {
            var q = mapper.convert(p, PersonDto.class);
            if (person != null && p.getSubscribers().contains(person)) {
                q.setIsSubscriber(true);
            }
            result.add(q);
        }
        return result;
    }

    public Person findPersonByEmail(String email) throws EntityNotFoundException {
        var person = personRepository.findByEmail(email);
        if (person == null) {
            throw new EntityNotFoundException("Entity Not Found Exception");
        }
        return person;
    }

    public void createNewPerson(RegistPersonDto registPersonDto) throws InvalidAuthException {
        var per = new Person();
        if (personRepository.existsByEmail(registPersonDto.getEmail()))
            throw new InvalidAuthException("Email is exists!");
        else if (personRepository.existsByNickName(registPersonDto.getNickName()))
            throw new InvalidAuthException("Nickname is exists!");
        per.setBirthday(registPersonDto.getBirthday());
        per.setFirstName(registPersonDto.getFirstName());
        per.setLastName(registPersonDto.getLastName());
        per.setNickName(registPersonDto.getNickName());
        per.setEmail(registPersonDto.getEmail());
        per.setPassword(passwordEncoder.encode(registPersonDto.getPassword()));
        var userRole = roleRepository.findByName("USER_ROLE");
        var roles = new ArrayList<Role>();
        roles.add(userRole);
        per.setRoles(new ArrayList<Role>(roles));
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
            var token = jwtSupplier.createTokenForUser(user.getId(), user.getNickName(), user.getRoles());
            return new AuthInfoDto(token);
        } else {
            throw new EntityNotFoundException("Invalid login or password");
        }
    }

    public PersonDto getUserByNickName(String nickName, Authentication authentication) {
        Person current = null;
        if (authentication != null) {
            current = personRepository.findByNickName(authentication.getName());
        }
        var person = personRepository.findByNickName(nickName.toLowerCase());
        if (person == null) throw new EntityNotFoundException("User not found");
        var personDto = mapper.convert(person, PersonDto.class);
        if (current!=null && current.getId() != person.getId()){
            personDto.setTwitts(twittRepository.findAllDtoForCurrentAndAuthor(current,person.getId()));
        } else{
            Set<TwittFeedDto> result = new HashSet<>();
            for (Twitt twitt : person.getTwitts()) {
                var twittDto = mapper.convert(twitt,TwittFeedDto.class);
                twitt.getPersonLikes().forEach(person1 -> {
                    if (person.getId() == person1.getId()){
                        twittDto.setLike(true);
                    }
                });
                twitt.getPersonDisLikes().forEach(person1 -> {
                    if (person.getId() == person1.getId()){
                        twittDto.setLike(true);
                    }
                });

                result.add(twittDto);
            }
            personDto.setTwitts(result);
            List<String> lists = new ArrayList<>();
            person.getRoles().stream().forEach(role -> {
                lists.add(role.getName());
            });
            personDto.setRoles(lists);
        }
        if (current != null && person.getSubscribers().contains(current)) {
            personDto.setIsSubscriber(true);
        }
        return personDto;
    }

    public List<PersonDto> getSubscriberListUsers(String nickName) {
        var person = personRepository.findByNickName(nickName.toLowerCase());
        if (person == null) throw new EntityNotFoundException("User not found");
        var personsDto = new ArrayList<PersonDto>();
        for (Person p : person.getSubscribers()) {
            var personDto = new PersonDto();
            personDto.setNickName(p.getNickName());
            personDto.setFirstName(p.getFirstName());
            personDto.setLastName(p.getLastName());
            personsDto.add(personDto);
            if (person.getSubscribers().contains(p)) {
                personDto.setIsSubscriber(true);
            }
        }
        return personsDto;
    }

    public List<PersonDto> getSubscriptionListUsers(String nickName) {
        var person = personRepository.findByNickName(nickName.toLowerCase());
        if (person == null) throw new EntityNotFoundException("User not found");
        var personsDto = new ArrayList<PersonDto>();
        for (Person p : person.getSubscription()) {
            var personDto = new PersonDto();
            personDto.setNickName(p.getNickName());
            personDto.setFirstName(p.getFirstName());
            personDto.setLastName(p.getLastName());
            personsDto.add(personDto);
            personDto.setIsSubscriber(true);
        }
        return personsDto;
    }
}
