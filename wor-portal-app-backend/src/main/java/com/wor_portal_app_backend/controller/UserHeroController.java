package com.wor_portal_app_backend.controller;

import com.wor_portal_app_backend.entity.User;
import com.wor_portal_app_backend.repository.UserRepository;
import com.wor_portal_app_backend.dto.UserHeroResponseDto;
import com.wor_portal_app_backend.service.UserHeroService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/user-heroes")
@RequiredArgsConstructor
public class UserHeroController {

    private final UserHeroService userHeroService;
    private final UserRepository userRepository;

    @GetMapping("/{userId}")
    public ResponseEntity<List<UserHeroResponseDto>> getUserHeroes(
            @PathVariable Long userId,
            Authentication authentication
    ) {
        authorizeUserId(userId, authentication);
        return ResponseEntity.ok(userHeroService.getUserHeroes(userId));
    }

    @PostMapping("/{userId}/hero/{heroId}")
    public ResponseEntity<UserHeroResponseDto> toggleOrUpgradeHero(
            @PathVariable Long userId,
            @PathVariable Long heroId,
            Authentication authentication
    ) {
        authorizeUserId(userId, authentication);
        return ResponseEntity.ok(userHeroService.toggleOrUpgradeHero(userId, heroId));
    }

    @DeleteMapping("/{userId}/hero/{heroId}")
    public ResponseEntity<Void> removeUserHero(
            @PathVariable Long userId,
            @PathVariable Long heroId,
            Authentication authentication
    ) {
        authorizeUserId(userId, authentication);
        userHeroService.removeUserHero(userId, heroId);
        return ResponseEntity.noContent().build();
    }

    private void authorizeUserId(Long requestedUserId, Authentication authentication) {
        if (authentication == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Потрібна авторизація.");
        }

        User actor = userRepository.findByUsername(authentication.getName())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Користувача не знайдено."));
        boolean isOwner = actor.getId().equals(requestedUserId);
        boolean isAdmin = actor.getPlatformRole() == User.PlatformRole.ADMIN
                || (actor.getPlatformRole() == null && actor.getRole() == User.Role.ADMIN);

        if (!isOwner && !isAdmin) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Не можна керувати ростером іншого користувача.");
        }
    }
}
