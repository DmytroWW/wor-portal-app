package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.CreateGuildRequest;
import com.wor_portal_app_backend.dto.GuildResponse;
import com.wor_portal_app_backend.entity.Guild;
import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.repository.GuildRepository;
import com.wor_portal_app_backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class GuildService {

    private final GuildRepository guildRepository;
    private final UserRepository userRepository;

    @Transactional
    public GuildResponse createGuild(CreateGuildRequest request, String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

        // Якщо звичайний юзер створює гільдію, перевіряємо чи він вже не в гільдії
        if (user.getGuild() != null && user.getRole() != User.Role.ADMIN) {
            throw new IllegalStateException("User is already in a guild");
        }

        String inviteCode;
        do {
            inviteCode = generateInviteCode();
        } while (guildRepository.existsByInviteCode(inviteCode));

        Guild guild = new Guild();
        guild.setName(request.getName());
        guild.setInviteCode(inviteCode);
        guild.setCreatedAt(LocalDateTime.now());

        Guild savedGuild = guildRepository.save(guild);
        user.setGuild(savedGuild);
        userRepository.save(user);


        return mapToGuildResponse(savedGuild, 0);
    }

    @Transactional
    public GuildResponse joinGuild(String inviteCode, String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

        if (user.getGuild() != null) {
            throw new IllegalStateException("User is already in a guild");
        }

        Guild guild = guildRepository.findByInviteCode(inviteCode)
                .orElseThrow(() -> new IllegalArgumentException("Invalid invite code: " + inviteCode));

        user.setGuild(guild);
        userRepository.save(user);

        int memberCount = (int) userRepository.countByGuildId(guild.getId());

        return mapToGuildResponse(guild, memberCount);
    }

    private String generateInviteCode() {
        return "WOR-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    private GuildResponse mapToGuildResponse(Guild guild, int memberCount) {
        return GuildResponse.builder()
                .id(guild.getId())
                .name(guild.getName())
                .inviteCode(guild.getInviteCode())
                .createdAt(guild.getCreatedAt())
                .memberCount(memberCount)
                .build();
    }
}