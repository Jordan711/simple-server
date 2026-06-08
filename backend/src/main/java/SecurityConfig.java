package com.jordan711.simple_server;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // Disable CSRF for testing with mobile apps
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/**").permitAll() // Allow anyone to hit /api endpoints
                .anyRequest().authenticated()
            );
        return http.build();
    }
}