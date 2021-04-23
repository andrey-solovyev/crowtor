package com.crowtor.backend.service;

import com.crowtor.backend.data.dto.RegistPersonDto;
import com.crowtor.backend.data.models.Person;
import com.crowtor.backend.data.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonService {
    @Autowired
    private PersonRepository personRepository;

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
