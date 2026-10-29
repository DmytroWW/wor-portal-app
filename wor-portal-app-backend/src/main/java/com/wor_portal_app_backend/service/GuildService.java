package com.wor_portal_app_backend.service;

import com.wor_portal_app_backend.dto.ChangeGuildRoleRequest;
import com.wor_portal_app_backend.dto.GuildMemberResponse;
import com.wor_portal_app_backend.dto.GuildResponse;
import com.wor_portal_app_backend.dto.CreateGuildRequest;
import com.wor_portal_app_backend.entity.Guild;
import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.mapper.UserMapper;
import com.wor_portal_app_backend.repository.GuildRepository;
import com.wor_portal_app_backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class GuildService {

    private final GuildRepository guildRepository;
    private final UserRepository userRepository;

    @Transactional
    public GuildResponse createGuild(CreateGuildRequest request, String username) {
        User user = findUser(username);

        if (user.getGuild() != null) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Ти вже перебуваєш у гільдії.");
        }

        String name = request == null || request.getName() == null ? "" : request.getName().trim();
        if (name.isBlank() || name.length() > 100) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Назва гільдії має містити від 1 до 100 символів.");
        }

        Guild guild = new Guild();
        guild.setName(name);
        guild.setInviteCode(generateUniqueInviteCode());
        guild.setCreatedAt(LocalDateTime.now());
        Guild savedGuild = guildRepository.save(guild);

        user.setGuild(savedGuild);
        user.setGuildRole(User.GuildRole.LEADER);
        normalizeLegacyRole(user);
        userRepository.save(user);

        return mapToGuildResponse(savedGuild);
    }

    @Transactional
    public GuildResponse joinGuild(String inviteCode, String username) {
        User user = findUser(username);

        if (user.getGuild() != null) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Ти вже перебуваєш у гільдії.");
        }

        String normalizedCode = inviteCode == null ? "" : inviteCode.trim().toUpperCase(Locale.ROOT);
        if (normalizedCode.isBlank()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Введи інвайт-код гільдії.");
        }

        Guild guild = guildRepository.findByInviteCodeIgnoreCase(normalizedCode)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Інвайт-код гільдії не знайдено."));

        user.setGuild(guild);
        user.setGuildRole(User.GuildRole.MEMBER);
        normalizeLegacyRole(user);
        userRepository.save(user);

        return mapToGuildResponse(guild);
    }

    @Transactional(readOnly = true)
    public List<GuildMemberResponse> getMembers(String username) {
        User actor = findUser(username);
        Guild guild = requireGuild(actor);

        return userRepository.findAllByGuild_IdOrderByIdAsc(guild.getId()).stream()
                .map(member -> GuildMemberResponse.builder()
                        .id(member.getId())
                        .username(member.getUsername())
                        .role(member.getGuildRole() == null ? User.GuildRole.MEMBER.name() : member.getGuildRole().name())
                        .platformRole(UserMapper.resolvePlatformRole(member).name())
                        .createdAt(member.getCreatedAt())
                        .build())
                .toList();
    }

    @Transactional
    public void changeMemberRole(Long memberId, ChangeGuildRoleRequest request, String username) {
        User actor = requireLeader(username);
        User target = findUser(memberId);
        ensureSameGuild(actor, target);

        if (actor.getId().equals(target.getId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Не можна змінити власний ранг цією дією.");
        }
        if (target.getGuildRole() == User.GuildRole.LEADER) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Передача лідерства має виконуватися окремою дією.");
        }

        String requestedRole = request == null || request.getRole() == null
                ? ""
                : request.getRole().trim().toUpperCase(Locale.ROOT);
        User.GuildRole nextRole;
        try {
            nextRole = User.GuildRole.valueOf(requestedRole);
        } catch (IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Дозволені ранги: MEMBER або OFFICER.");
        }
        if (nextRole == User.GuildRole.LEADER) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Для передачі лідерства використай окрему дію.");
        }

        target.setGuildRole(nextRole);
        normalizeLegacyRole(target);
        userRepository.save(target);
    }

    @Transactional
    public void kickMember(Long memberId, String username) {
        User actor = requireLeader(username);
        User target = findUser(memberId);
        ensureSameGuild(actor, target);

        if (actor.getId().equals(target.getId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Лідер не може виключити себе. Спочатку передай лідерство.");
        }
        if (target.getGuildRole() == User.GuildRole.LEADER) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Не можна виключити лідера гільдії.");
        }

        target.setGuild(null);
        target.setGuildRole(null);
        normalizeLegacyRole(target);
        userRepository.save(target);
    }

    @Transactional
    public void transferLeadership(Long targetMemberId, String username) {
        User actor = requireLeader(username);
        User target = findUser(targetMemberId);
        ensureSameGuild(actor, target);

        if (actor.getId().equals(target.getId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Ти вже є лідером цієї гільдії.");
        }

        // Demote the current leader first to satisfy the partial unique index.
        actor.setGuildRole(User.GuildRole.OFFICER);
        normalizeLegacyRole(actor);
        userRepository.saveAndFlush(actor);

        target.setGuildRole(User.GuildRole.LEADER);
        normalizeLegacyRole(target);
        userRepository.save(target);
    }

    @Transactional
    public GuildResponse rotateInviteCode(String username) {
        User actor = requireLeader(username);
        Guild guild = requireGuild(actor);
        guild.setInviteCode(generateUniqueInviteCode());
        Guild savedGuild = guildRepository.save(guild);
        return mapToGuildResponse(savedGuild);
    }

    private User findUser(String username) {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));
    }

    private User findUser(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Користувача не знайдено."));
    }

    private User requireLeader(String username) {
        User actor = findUser(username);
        requireGuildRole(actor, User.GuildRole.LEADER);
        return actor;
    }

    private void requireGuildRole(User user, User.GuildRole requiredRole) {
        if (user.getGuild() == null || user.getGuildRole() != requiredRole) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Ця дія доступна лише лідеру твоєї гільдії.");
        }
    }

    private Guild requireGuild(User user) {
        if (user.getGuild() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Ти ще не перебуваєш у гільдії.");
        }
        return user.getGuild();
    }

    private void ensureSameGuild(User actor, User target) {
        if (actor.getGuild() == null || target.getGuild() == null
                || !actor.getGuild().getId().equals(target.getGuild().getId())) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Користувача не знайдено у твоїй гільдії.");
        }
    }

    private String generateUniqueInviteCode() {
        String code;
        do {
            code = "WOR-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase(Locale.ROOT);
        } while (guildRepository.existsByInviteCodeIgnoreCase(code));
        return code;
    }

    private void normalizeLegacyRole(User user) {
        user.setRole(UserMapper.resolvePlatformRole(user) == User.PlatformRole.ADMIN
                ? User.Role.ADMIN
                : User.Role.MEMBER);
    }

    private GuildResponse mapToGuildResponse(Guild guild) {
        int memberCount = Math.toIntExact(userRepository.countByGuild_Id(guild.getId()));
        return GuildResponse.builder()
                .id(guild.getId())
                .name(guild.getName())
                .inviteCode(guild.getInviteCode())
                .createdAt(guild.getCreatedAt())
                .memberCount(memberCount)
                .build();
    }
}
