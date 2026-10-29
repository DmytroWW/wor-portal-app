package com.wor_portal_app_backend.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class GuildMemberResponse {
    private Long id;
    private String username;
    /** Guild rank, not global platform role. */
    private String role;
    private String platformRole;
    private LocalDateTime createdAt;
}
