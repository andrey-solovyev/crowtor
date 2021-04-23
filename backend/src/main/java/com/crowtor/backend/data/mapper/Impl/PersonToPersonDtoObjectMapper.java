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
        personDto
        return null;
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
