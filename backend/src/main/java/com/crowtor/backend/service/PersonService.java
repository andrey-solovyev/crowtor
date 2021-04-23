package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.PersonDto;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.repository.PersonRepository;
import org.springframework.stereotype.Service;

@Service
public class PersonService {
    private PersonRepository personRepository;

    public void createNewPerson(PersonDto personDto){

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
