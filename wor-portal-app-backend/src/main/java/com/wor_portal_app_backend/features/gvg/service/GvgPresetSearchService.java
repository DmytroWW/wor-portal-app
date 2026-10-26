package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.exception.ValidationException;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetHeroRequest;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetSearchRequest;
import com.wor_portal_app_backend.features.gvg.entity.GvgPreset;
import com.wor_portal_app_backend.features.gvg.entity.GvgPresetHero;
import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;
import com.wor_portal_app_backend.features.gvg.mapper.GvgPresetMapper;
import com.wor_portal_app_backend.features.gvg.repository.GvgPresetHeroRepository;
import com.wor_portal_app_backend.features.gvg.repository.GvgPresetRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GvgPresetSearchService {

    private final GvgPresetRepository presetRepository;
    private final GvgPresetHeroRepository presetHeroRepository;

    private final GvgPresetMapper presetMapper;

    private final GvgGuildContextService guildContextService;
    private final GvgMapValidationService mapValidationService;



    public List<GvgPresetResponse> searchExactPresets(
            GvgPresetSearchRequest request
    ) {
        // 1. Валідація запиту.
        validateSearchRequest(request);

        // 2. Перевіряємо існування карти.
        mapValidationService.getMap(request.mapId());

        // 3. Отримуємо поточну гільдію.
        Long guildId = guildContextService.getCurrentGuildId();

        // 4. Отримуємо пресети гільдії для цієї карти.
        List<GvgPreset> presets =
                presetRepository.findByGuild_IdAndMap_Id(
                        guildId,
                        request.mapId()
                );

        if (presets.isEmpty()) {
            return List.of();
        }

        // 5. Отримуємо ID пресетів.
        List<Long> presetIds = presets.stream()
                .map(GvgPreset::getId)
                .toList();


        List<GvgPresetHero> presetHeroes =
                presetHeroRepository.findByPreset_IdIn(
                        presetIds
                );


        Map<Long, Set<HeroPosition>> positionsByPreset =
                new HashMap<>();

        for (GvgPresetHero presetHero : presetHeroes) {

            Long presetId =
                    presetHero.getPreset().getId();

            HeroPosition position = new HeroPosition(
                    presetHero.getHero().getId(),
                    presetHero.getTile() != null
                            ? presetHero.getTile().getId()
                            : null,
                    presetHero.getAttackDirection()
            );

            positionsByPreset
                    .computeIfAbsent(
                            presetId,
                            id -> new HashSet<>()
                    )
                    .add(position);
        }

        // 8. Перетворюємо запит у Set для порівняння.
        Set<HeroPosition> requestedPositions =
                new HashSet<>();

        for (GvgPresetHeroRequest hero : request.heroes()) {
            requestedPositions.add(
                    new HeroPosition(
                            hero.heroId(),
                            hero.tileId(),
                            hero.attackDirection()
                    )
            );
        }


        return presets.stream()
                .filter(preset -> {

                    Set<HeroPosition> presetPositions =
                            positionsByPreset.getOrDefault(
                                    preset.getId(),
                                    Set.of()
                            );

                    return requestedPositions.equals(
                            presetPositions
                    );
                })
                .map(presetMapper::toResponse)
                .toList();
    }



    private void validateSearchRequest(
            GvgPresetSearchRequest request
    ) {
        if (request == null) {
            throw new ValidationException(
                    "Search request must not be null"
            );
        }

        if (request.mapId() == null) {
            throw new ValidationException(
                    "Map ID must not be null"
            );
        }

        if (request.heroes() == null
                || request.heroes().size() != 5) {
            throw new ValidationException(
                    "Exactly 5 heroes must be provided"
            );
        }

        Set<Long> heroIds = new HashSet<>();
        Set<Long> tileIds = new HashSet<>();

        for (GvgPresetHeroRequest hero : request.heroes()) {

            if (hero == null) {
                throw new ValidationException(
                        "Hero must not be null"
                );
            }

            if (hero.heroId() == null) {
                throw new ValidationException(
                        "Hero ID must not be null"
                );
            }

            if (hero.tileId() == null) {
                throw new ValidationException(
                        "Tile ID must not be null"
                );
            }

            if (hero.attackDirection() == null) {
                throw new ValidationException(
                        "Attack direction must not be null"
                );
            }

            if (!heroIds.add(hero.heroId())) {
                throw new ValidationException(
                        "Duplicate hero ID: " + hero.heroId()
                );
            }

            if (!tileIds.add(hero.tileId())) {
                throw new ValidationException(
                        "Duplicate tile ID: " + hero.tileId()
                );
            }
        }
    }

    /*
     * =========================
     * INTERNAL
     * =========================
     */

    /**
     * Represents the exact placement of a hero.
     *
     * Two positions are equal only when:
     * - heroId matches
     * - tileId matches
     * - attackDirection matches
     */
    private record HeroPosition(
            Long heroId,
            Long tileId,
            AttackDirection attackDirection
    ) {
    }
}