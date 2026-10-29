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

        User.PlatformRole platformRole = resolvePlatformRole(user);
        boolean hasGuild = user.getGuild() != null;

        return UserProfileResponse.builder()
                .id(user.getId())
                .username(user.getUsername())
                .role(platformRole.name())
                .guildName(hasGuild ? user.getGuild().getName() : null)
                .guildId(hasGuild ? user.getGuild().getId() : null)
                .guildRole(hasGuild && user.getGuildRole() != null ? user.getGuildRole().name() : null)
                .inviteCode(hasGuild ? user.getGuild().getInviteCode() : null)
                .build();
    }

    public static User.PlatformRole resolvePlatformRole(User user) {
        if (user.getPlatformRole() != null) {
            return user.getPlatformRole();
        }
        return user.getRole() == User.Role.ADMIN
                ? User.PlatformRole.ADMIN
                : User.PlatformRole.USER;
    }
}
