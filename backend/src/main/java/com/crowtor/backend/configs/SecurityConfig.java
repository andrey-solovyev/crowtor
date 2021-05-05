package com.crowtor.backend.configs;

import com.crowtor.backend.security.FIlterForJwt;
import com.crowtor.backend.security.JwtSupplier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import static org.springframework.http.HttpMethod.GET;
import static org.springframework.http.HttpMethod.POST;
import static org.springframework.security.config.http.SessionCreationPolicy.STATELESS;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private final FIlterForJwt jwtFilter;

    @Bean
    public BCryptPasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    public SecurityConfig(FIlterForJwt jwtFilter) {
        this.jwtFilter = jwtFilter;
    }

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception{
        httpSecurity
                .httpBasic().disable()
                .csrf().disable()
                .sessionManagement().sessionCreationPolicy(STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers(POST,"/api/v1/twitt/*").authenticated()
                .antMatchers(GET,"/api/v1/twitt/id").permitAll()
                .antMatchers(POST,"/api/v1/security/*").permitAll()
                .antMatchers(GET,"/api/v1/calculation/search/*").hasRole("USER")
                .antMatchers(GET,"/api/v1/calculation/search/*").hasRole("ADMIN")
                .and().addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);;
    }
}
