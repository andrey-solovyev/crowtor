package com.crowtor.backend.controller;

import com.crowtor.backend.data.dto.ResponseDto;
import com.crowtor.backend.exceptions.EntityNotFoundException;
import com.crowtor.backend.exceptions.InvalidAuthException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
public class ExceptionHandlerController extends ResponseEntityExceptionHandler {
    @ExceptionHandler(EntityNotFoundException.class)
    protected ResponseEntity<ResponseDto> handleEntityNotFoundException(EntityNotFoundException notFoundException){

        ResponseDto response = new ResponseDto();
        if (notFoundException.getMessage()!=null) response.setMessage(notFoundException.getMessage());
        else response.setMessage("Not found entity");
        return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(InvalidAuthException.class)
    protected ResponseEntity<ResponseDto> handleInvalidAuthException(InvalidAuthException invalidAuthException){

        ResponseDto response = new ResponseDto();
        if (invalidAuthException.getMessage()!=null) response.setMessage(invalidAuthException.getMessage());
        else response.setMessage("Authorization error");
        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }
}
