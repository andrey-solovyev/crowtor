package com.crowtor.backend.security;

import com.crowtor.backend.data.models.Role;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Component
public class JwtSupplier {
    private final Key key;
    private final JwtParser jwtParser;
    private static Logger logger = LoggerFactory.getLogger(JwtSupplier.class);


    public JwtSupplier(@Value("${jwtSecret}") String keys) {
        this.key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(keys));
        this.jwtParser = Jwts.parserBuilder()
                .setSigningKey(this.key)
                .build();
    }

    /**
     * генерируем токен
     */
    public String createTokenForUser(String name, String surname, List<Role> userRoles) {
        Date exDate = Date.from(
                LocalDate.now()
                        .plusDays(60)
                        .atStartOfDay(ZoneId.systemDefault()).toInstant()
        );

        return Jwts.builder()
                .setExpiration(exDate)
                .setSubject(name)
                .claim("surname", surname)
                .signWith(key)
                .compact();
    }

    public boolean isTokenValid(String token) {
        try {
            jwtParser.parse(token);
            return true;
        } catch (Exception e) {
            System.err.println("Invalid token");
            return false;
        }
    }

    public Claims getClaimsFromToken(String token) {
        return jwtParser.parseClaimsJws(token).getBody();
    }
}

