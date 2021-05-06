package com.crowtor.backend.exceptions;
import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.UUID;
@ResponseStatus(code = HttpStatus.NOT_FOUND)
public class EntityNotFoundException extends RuntimeException {
    private UUID uuid;
    private int id;
    private String clazzName;

    public EntityNotFoundException(UUID id, String clazzName) {
        super(String.format("'%s' is not found with id : '%s'", clazzName, id));
    }

    public EntityNotFoundException(long id, String clazzName) {
        super(String.format("'%s' is not found with id : '%s'", clazzName, id));
    }

    public EntityNotFoundException(String clazzName) {
        super( clazzName);
    }
}
