package com.crowtor.backend.security;

import com.crowtor.backend.controller.SecurityController;
import io.jsonwebtoken.Claims;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import javax.persistence.Column;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

import static org.springframework.util.StringUtils.hasText;

@Component
public class FIlterForJwt extends GenericFilterBean {
    private JwtSupplier jwtSupplier;
    private static Logger logger = LoggerFactory.getLogger(JwtSupplier.class);

    public FIlterForJwt(JwtSupplier jwtSupplier) {
        this.jwtSupplier = jwtSupplier;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String actualToken = getTokenFromRequest((HttpServletRequest) request);
        if (actualToken != null && jwtSupplier.isTokenValid(actualToken)) {
            Claims claims = jwtSupplier.getClaimsFromToken(actualToken);
            UserDetails customUserDetails = SecurityUser.fromClaimsToCustomUserDetails(claims);
            Authentication authentication = new PreAuthenticatedAuthenticationToken(
                    customUserDetails,
                    null,
                    customUserDetails.getAuthorities()
            );
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        chain.doFilter(request, response);
    }

    private String getTokenFromRequest(HttpServletRequest httpServletRequest) {
        String token = httpServletRequest.getHeader(HttpHeaders.AUTHORIZATION);
        if (hasText(token) && token.startsWith("Bearer ")) {
            return token.substring(7);
        }
        return null;
    }

}
