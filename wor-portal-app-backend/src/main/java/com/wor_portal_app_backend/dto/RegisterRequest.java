package com.wor_portal_app_backend.dto;
import lombok.Data;


@Data
public class RegisterRequest {
    private String username;
    private String password;
    private String inviteCode;
}