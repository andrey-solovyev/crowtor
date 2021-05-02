package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.securutyDto.LoginUserDto;
import com.crowtor.backend.data.dto.securutyDto.RegistPersonDto;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.repository.PersonRepository;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class PersonService {
    private PersonRepository personRepository;
    private PasswordEncoder passwordEncoder;
    private static Logger logger = LoggerFactory.getLogger(PersonService.class);

    public PersonService(PersonRepository personRepository, PasswordEncoder passwordEncoder) {
        this.personRepository = personRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Person findPersonByNickName(LoginUserDto loginUserDto) throws EntityNotFoundException {
        var person = personRepository.findByNickName(loginUserDto.getNickName());
        if (person != null) {
            if (passwordEncoder.matches(loginUserDto.getPassword(), person.getPassword())) {
                return person;
            }
        }
        else throw new EntityNotFoundException("Invalid login or password");
        return null;
    }
    public void createNewPerson(RegistPersonDto registPersonDto){
        var per = new Person();
        per.setBirthday(registPersonDto.getBirthday());
        per.setFirstName(registPersonDto.getFirstName());
        per.setLastName(registPersonDto.getLastName());
        per.setNickName(registPersonDto.getNickName());
        personRepository.save(per);
    }
    public void subscribe(Long currentIdUser, Long subscribeIdUser) {
        Person person = personRepository.getOne(currentIdUser);
        person.getSubscription().add(personRepository.getOne(subscribeIdUser));
        personRepository.save(person);
    }
    public void unSubscribe(Long currentIdUser, Long subscribeIdUser) {
        Person person = personRepository.getOne(currentIdUser);
        person.getSubscription().remove(personRepository.getOne(subscribeIdUser));
        personRepository.save(person);
    }
}
