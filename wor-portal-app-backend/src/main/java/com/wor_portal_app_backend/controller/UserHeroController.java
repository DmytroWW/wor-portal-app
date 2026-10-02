
package com.wor_portal_app_backend.controller;

import com.wor_portal_app_backend.dto.UserHeroResponseDto;
import com.wor_portal_app_backend.service.UserHeroService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user-heroes")
@RequiredArgsConstructor
public class UserHeroController {

    private final UserHeroService userHeroService;

    // Отримати весь ростер конкретного користувача
    @GetMapping("/{userId}")
    public ResponseEntity<List<UserHeroResponseDto>> getUserHeroes(
            @PathVariable Long userId
    ) {
        return ResponseEntity.ok(
                userHeroService.getUserHeroes(userId)
        );
    }

    // Додати героя або підвищити рівень пробудження
    @PostMapping("/{userId}/hero/{heroId}")
    public ResponseEntity<UserHeroResponseDto> toggleOrUpgradeHero(
            @PathVariable Long userId,
            @PathVariable Long heroId
    ) {
        return ResponseEntity.ok(
                userHeroService.toggleOrUpgradeHero(userId, heroId)
        );
    }

    // Видалити героя з ростера
    @DeleteMapping("/{userId}/hero/{heroId}")
    public ResponseEntity<Void> removeUserHero(
            @PathVariable Long userId,
            @PathVariable Long heroId
    ) {
        userHeroService.removeUserHero(userId, heroId);
        return ResponseEntity.noContent().build();
    }
}