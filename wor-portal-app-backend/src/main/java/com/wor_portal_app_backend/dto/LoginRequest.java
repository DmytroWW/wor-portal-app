package com.wor_portal_app_backend.dto;

import lombok.Data;

@Data
public class LoginRequest {
    private String username;
    private String password;
}