package com.crowtor.backend.exceptions;
import lombok.Data;

import java.util.UUID;

@Data
public class EntityNotFoundException extends Exception {
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
        super(String.format("'%s' is not found ", clazzName));
    }
}
