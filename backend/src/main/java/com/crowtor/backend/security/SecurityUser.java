package com.crowtor.backend.security;

import io.jsonwebtoken.Claims;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;

public class SecurityUser implements UserDetails {

    private long id;
    private String nickName;
    private Collection<? extends GrantedAuthority> grantedAuthorities;
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return grantedAuthorities;
    }

    public static SecurityUser fromClaimsToCustomUserDetails(Claims claims) {
        SecurityUser userDetails = new SecurityUser();
        userDetails.nickName = claims.getSubject();
        var roles = claims.get("roles", String.class).split(",");
        userDetails.grantedAuthorities = Arrays.stream(roles)
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());

        return userDetails;
    }
    @Override
    public String getPassword() {
        return null;
    }

    @Override
    public String getUsername() {
        return nickName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

//    public static UserDetails fromUser(User user){
//
//    }
}
