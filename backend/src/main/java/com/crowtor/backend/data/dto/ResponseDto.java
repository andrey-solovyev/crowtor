package com.crowtor.backend.data.dto;

public class ResponseDto {
    private String message;

    public ResponseDto() {
    }

    public ResponseDto(String message) {
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
