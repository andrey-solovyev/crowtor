package com.crowtor.backend.data.mapper.Impl;

import com.crowtor.backend.data.dto.PersonDto;
import com.crowtor.backend.data.dto.securutyDto.RegistPersonDto;
import com.crowtor.backend.data.mapper.BaseObjectMapper;
import com.crowtor.backend.data.models.Person;

public class PersonDtoToPersonObjectMapper extends BaseObjectMapper<RegistPersonDto, Person> {
    @Override
    public Person convert(RegistPersonDto obj) {
        var person=new Person();
        person.setBirthday(obj.getBirthday());
        person.setFirstName(obj.getFirstName());
        person.setLastName(obj.getLastName());
        person.setNickName(obj.getNickName());
        person.setNickName(obj.getEmail());
        return person;
    }

    @Override
    public Class<RegistPersonDto> getInClass() {
        return null;
    }

    @Override
    public Class<Person> getOutClass() {
        return null;
    }
}
