package com.crowtor.backend.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.UNAUTHORIZED)
public class InvalidAuthException extends RuntimeException{
    private String nickName;
    private String password ;

    public InvalidAuthException(String nickName, String password) {
        super(String.format("'%s' invalid password : '%s'", nickName, password));
    }
    public InvalidAuthException(String message){
        super(message);
    }
}
