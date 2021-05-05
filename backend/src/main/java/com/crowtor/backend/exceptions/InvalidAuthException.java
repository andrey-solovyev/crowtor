package com.crowtor.backend.exceptions;

public class InvalidAuthException extends Exception{
    private String nickName;
    private String password ;

    public InvalidAuthException(String nickName, String password) {
        super(String.format("'%s' invalid password : '%s'", nickName, password));
    }
}
