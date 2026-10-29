package com.wor_portal_app_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserProfileResponse {
    private Long id;
    private String username;

    /** Kept as `role` for existing frontend compatibility; now means platform role. */
    private String role;

    private String guildName;
    private Long guildId;
    private String guildRole;
    private String inviteCode;
}
