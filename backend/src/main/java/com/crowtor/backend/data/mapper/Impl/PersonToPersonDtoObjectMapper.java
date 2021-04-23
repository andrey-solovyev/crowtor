package com.crowtor.backend.data.mapper.Impl;

import com.crowtor.backend.data.dto.PersonDto;
import com.crowtor.backend.data.mapper.BaseObjectMapper;
import com.crowtor.backend.data.models.Person;
import org.springframework.stereotype.Component;

import java.util.List;

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
        personDto.setNickName(obj.getNickName());
        personDto.setIsPremium(obj.getIsPremium());
        personDto.setIsDeleted(obj.getIsDeleted());
        personDto.setTwits(obj.getTwits());
        personDto.setSubscribers(obj.getSubscribers());
        personDto.setSubscription(obj.getSubscription());
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
