package com.lab2.lab_two.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfiguration implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/registrations")
                .allowedOrigins("http://localhost:5731")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*");

        registry.addMapping("/api/users/login")
                .allowedOrigins("http://localhost:5731")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*");
        
        registry.addMapping("/api/assignments")
                .allowedOrigins("http://localhost:5731")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*");

        registry.addMapping("/api/users/enrolled-courses")
                .allowedOrigins("http://localhost:5731")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*");
                
        registry.addMapping("/api/previous-results")
                .allowedOrigins("http://localhost:5731")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*");

        registry.addMapping("/api/users/projects")
                .allowedOrigins("http://localhost:5731")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*");        
    }
}
