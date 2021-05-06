package com.crowtor.backend.data.mappers.Impl;

import com.crowtor.backend.data.dto.PersonDto;
import com.crowtor.backend.data.mappers.BaseObjectMapper;
import com.crowtor.backend.data.models.Person;
import org.springframework.stereotype.Component;

@Component
public class PersonToPersonDtoObjectMapper extends BaseObjectMapper<Person, PersonDto> {

    public Person convertFromPersonDto(PersonDto personDto){
        var person=new Person();
        person.setBirthday(personDto.getBirthday());
        person.setFirstName(personDto.getFirstName());
        person.setLastName(personDto.getLastName());
        person.setNickName(personDto.getNickName());
        return person;
    }

    @Override
    public PersonDto convert(Person obj) {
        var personDto =new PersonDto();
        personDto.setFirstName(obj.getFirstName());
        personDto.setLastName(obj.getLastName());
        personDto.setBirthday(obj.getBirthday());
        personDto.setDateRegistration(obj.getDateRegistration());
        personDto.setNickName(obj.getNickName());
        personDto.setIsPremium(obj.getIsPremium());
        personDto.setIsDeleted(obj.getIsDeleted());
        personDto.setSubscribers(obj.getSubscribers().size());
        personDto.setSubscription(obj.getSubscription().size());
        return personDto;
    }

    @Override
    public Class<Person> getInClass() {
        return Person.class;
    }

    @Override
    public Class<PersonDto> getOutClass() {
        return PersonDto.class;
    }
}
