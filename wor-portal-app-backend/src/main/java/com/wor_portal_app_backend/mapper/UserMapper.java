package com.wor_portal_app_backend.mapper;

import com.wor_portal_app_backend.dto.UserProfileResponse;
import com.wor_portal_app_backend.entity.User;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {

    public UserProfileResponse toProfileResponse(User user) {
        if (user == null) {
            return null;
        }

        return UserProfileResponse.builder()
                .id(user.getId())
                .username(user.getUsername())
                .role(user.getRole().name())
                .guildName(user.getGuild() != null ? user.getGuild().getName() : null)
                .build();
    }
}