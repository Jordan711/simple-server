package com.jordan711.simple_server;

public class StatusResponse {
    private String status;
    private String message;

    // Constructor
    public StatusResponse(String status, String message) {
        this.status = status;
        this.message = message;
    }

    // Getters (Spring Boot needs these to build the JSON)
    public String getStatus() { return status; }
    public String getMessage() { return message; }
}