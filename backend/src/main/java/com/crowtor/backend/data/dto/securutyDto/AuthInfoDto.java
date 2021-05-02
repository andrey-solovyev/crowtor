package com.crowtor.backend.data.dto.securutyDto;

import java.util.Objects;

public class AuthInfoDto {
    private String token;

    public AuthInfoDto(String token) {
        this.token = token;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AuthInfoDto authInfo = (AuthInfoDto) o;
        return Objects.equals(token, authInfo.token);
    }

    @Override
    public int hashCode() {
        return Objects.hash(token);
    }
}
