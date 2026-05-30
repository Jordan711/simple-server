package com.jordan711.simple_server;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "Welcome to your Java Backend! The server is alive.";
    }

    @GetMapping("/api/status")
public StatusResponse getApiStatus() {
    // Instead of raw text, we return a structured data object
    return new StatusResponse("success", "Connected to Java server successfully!");
}
}