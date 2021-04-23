package com.crowtor.backend.data.mapper;

import org.springframework.stereotype.Component;

import java.util.List;
@Component
public interface ObjectMapper<IN, OUT> {

    OUT convert(IN obj);
    List<OUT> convertList(List<IN> objList);

    Class<IN> getInClass();
    Class<OUT> getOutClass();
}
