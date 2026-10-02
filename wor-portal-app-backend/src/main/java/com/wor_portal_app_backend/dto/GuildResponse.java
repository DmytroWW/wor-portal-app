package com.wor_portal_app_backend.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class GuildResponse {
    private Long id;
    private String name;
    private String inviteCode;
    private LocalDateTime createdAt;
    private int memberCount;
}