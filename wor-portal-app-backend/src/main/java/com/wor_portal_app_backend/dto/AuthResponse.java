package com.wor_portal_app_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthResponse {
    private String token;
    private String username;

    /** Global application role; retained under `role` for frontend compatibility. */
    private String role;
    private String guildName;
    private Long guildId;
    private String guildRole;
    private String inviteCode;

    /** Backward-compatible constructor for any remaining four-field callers. */
    public AuthResponse(String token, String username, String role, String guildName) {
        this(token, username, role, guildName, null, null, null);
    }
}
