package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.entity.DemonSoldier;
import com.wor_portal_app_backend.entity.Guild;
import com.wor_portal_app_backend.entity.Hero;
import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.exception.ValidationException;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetCreateRequest;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetDetailsResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetHeroDetailsResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetHeroRequest;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetHeroResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetSoldierRequest;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetSoldierResponse;
import com.wor_portal_app_backend.features.gvg.dto.GvgPresetUpdateRequest;
import com.wor_portal_app_backend.features.gvg.entity.GvgMap;
import com.wor_portal_app_backend.features.gvg.entity.GvgMapTile;
import com.wor_portal_app_backend.features.gvg.entity.GvgPreset;
import com.wor_portal_app_backend.features.gvg.entity.GvgPresetHero;
import com.wor_portal_app_backend.features.gvg.entity.GvgPresetSoldier;
import com.wor_portal_app_backend.features.gvg.mapper.GvgMapMapper;
import com.wor_portal_app_backend.features.gvg.mapper.GvgPresetHeroDetailsMapper;
import com.wor_portal_app_backend.features.gvg.mapper.GvgPresetHeroMapper;
import com.wor_portal_app_backend.features.gvg.mapper.GvgPresetMapper;
import com.wor_portal_app_backend.features.gvg.mapper.GvgPresetSoldierMapper;
import com.wor_portal_app_backend.features.gvg.repository.GvgPresetHeroRepository;
import com.wor_portal_app_backend.features.gvg.repository.GvgPresetRepository;
import com.wor_portal_app_backend.features.gvg.repository.GvgPresetSoldierRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class GvgPresetService {

    private final GvgPresetRepository presetRepository;
    private final GvgPresetHeroRepository presetHeroRepository;
    private final GvgPresetSoldierRepository presetSoldierRepository;

    private final GvgPresetMapper presetMapper;
    private final GvgPresetHeroMapper presetHeroMapper;
    private final GvgPresetSoldierMapper presetSoldierMapper;
    private final GvgMapMapper mapMapper;
    private final GvgPresetHeroDetailsMapper presetHeroDetailsMapper;

    private final GvgGuildContextService guildContextService;
    private final GvgMapValidationService mapValidationService;

    /*
     * =========================
     * PRESET
     * =========================
     */

    public List<GvgPresetResponse> getMyGuildPresets() {
        Long guildId = guildContextService.getCurrentGuildId();

        return presetRepository
                .findByGuild_IdOrderByCreatedAtDesc(guildId)
                .stream()
                .map(presetMapper::toResponse)
                .toList();
    }

    public GvgPresetResponse getPreset(Long presetId) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        return presetMapper.toResponse(preset);
    }

    public GvgPresetDetailsResponse getPresetDetails(Long presetId) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        GvgMap map = preset.getMap();

        List<GvgPresetHeroDetailsResponse> heroes = presetHeroRepository
                .findByPreset_Id(preset.getId())
                .stream()
                .map(presetHeroDetailsMapper::toResponse)
                .toList();

        List<GvgPresetSoldierResponse> soldiers = presetSoldierRepository
                .findByPreset_Id(preset.getId())
                .stream()
                .map(presetSoldierMapper::toResponse)
                .toList();

        return new GvgPresetDetailsResponse(
                presetMapper.toResponse(preset),
                mapMapper.toResponse(map),
                heroes,
                soldiers
        );
    }

    @Transactional
    public GvgPresetResponse createPreset(
            GvgPresetCreateRequest request
    ) {
        validatePresetCode(request.presetCode());

        Guild guild = guildContextService.getCurrentGuild();

        if (presetRepository.existsByGuild_IdAndPresetCode(
                guild.getId(),
                request.presetCode()
        )) {
            throw new ValidationException(
                    "Preset code already exists: " + request.presetCode()
            );
        }

        GvgMap map = mapValidationService.getMap(request.mapId());

        GvgPreset preset = GvgPreset.builder()
                .guild(guild)
                .map(map)
                .presetCode(request.presetCode())
                .name(request.name())
                .description(request.description())
                .build();

        return presetMapper.toResponse(
                presetRepository.save(preset)
        );
    }

    @Transactional
    public GvgPresetResponse updatePreset(
            Long presetId,
            GvgPresetUpdateRequest request
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        validatePresetCode(request.presetCode());

        boolean codeChanged =
                !preset.getPresetCode().equals(request.presetCode());

        if (codeChanged &&
                presetRepository.existsByGuild_IdAndPresetCode(
                        preset.getGuild().getId(),
                        request.presetCode()
                )) {

            throw new ValidationException(
                    "Preset code already exists: " + request.presetCode()
            );
        }

        preset.setPresetCode(request.presetCode());
        preset.setName(request.name());
        preset.setDescription(request.description());

        return presetMapper.toResponse(
                presetRepository.save(preset)
        );
    }

    @Transactional
    public void deletePreset(Long presetId) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        /*
         * Children have ON DELETE CASCADE in the database,
         * so deleting the preset removes its heroes/soldiers too.
         */
        presetRepository.delete(preset);
    }

    /*
     * =========================
     * HEROES
     * =========================
     */

    public List<GvgPresetHeroResponse> getPresetHeroes(Long presetId) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        return presetHeroRepository
                .findByPreset_Id(preset.getId())
                .stream()
                .map(presetHeroMapper::toResponse)
                .toList();
    }

    @Transactional
    public GvgPresetHeroResponse addHero(
            Long presetId,
            GvgPresetHeroRequest request
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        validateHeroRequest(request);

        if (presetHeroRepository.existsByPreset_IdAndHero_Id(
                presetId,
                request.heroId()
        )) {
            throw new ValidationException(
                    "Hero is already added to this preset: "
                            + request.heroId()
            );
        }

        Hero hero = mapValidationService.getHero(request.heroId());

        GvgMapTile tile = mapValidationService.getTile(
                request.tileId()
        );

        mapValidationService.validateTileBelongsToMap(
                tile,
                preset.getMap()
        );

        mapValidationService.validateHeroTileCompatibility(
                hero,
                tile
        );

        if (presetHeroRepository.existsByPreset_IdAndTile_Id(
                presetId,
                request.tileId()
        )) {
            throw new ValidationException(
                    "Tile is already occupied in this preset: "
                            + request.tileId()
            );
        }

        GvgPresetHero presetHero = GvgPresetHero.builder()
                .preset(preset)
                .hero(hero)
                .tile(tile)
                .attackDirection(request.attackDirection())
                .build();

        return presetHeroMapper.toResponse(
                presetHeroRepository.save(presetHero)
        );
    }

    @Transactional
    public GvgPresetHeroResponse updateHero(
            Long presetId,
            Long heroId,
            GvgPresetHeroRequest request
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        validateHeroRequest(request);

        GvgPresetHero presetHero =
                presetHeroRepository
                        .findByPreset_IdAndHero_Id(presetId, heroId)
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Hero is not added to this preset: "
                                                + heroId
                                )
                        );

        if (!heroId.equals(request.heroId())) {
            throw new ValidationException(
                    "Hero ID in path and request must match"
            );
        }

        GvgMapTile tile = mapValidationService.getTile(
                request.tileId()
        );

        mapValidationService.validateTileBelongsToMap(
                tile,
                preset.getMap()
        );

        mapValidationService.validateHeroTileCompatibility(
                presetHero.getHero(),
                tile
        );

        /*
         * If the hero changes its tile, make sure
         * another hero doesn't already occupy it.
         */
        Long currentTileId =
                presetHero.getTile() != null
                        ? presetHero.getTile().getId()
                        : null;

        boolean tileChanged =
                !request.tileId().equals(currentTileId);

        if (tileChanged &&
                presetHeroRepository.existsByPreset_IdAndTile_Id(
                        presetId,
                        request.tileId()
                )) {

            throw new ValidationException(
                    "Tile is already occupied in this preset: "
                            + request.tileId()
            );
        }

        presetHero.setTile(tile);
        presetHero.setAttackDirection(
                request.attackDirection()
        );

        return presetHeroMapper.toResponse(
                presetHeroRepository.save(presetHero)
        );
    }

    @Transactional
    public void removeHero(
            Long presetId,
            Long heroId
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        GvgPresetHero presetHero =
                presetHeroRepository
                        .findByPreset_IdAndHero_Id(
                                preset.getId(),
                                heroId
                        )
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Hero is not added to this preset: "
                                                + heroId
                                )
                        );

        presetHeroRepository.delete(presetHero);
    }

    /*
     * =========================
     * SOLDIERS
     * =========================
     */

    public List<GvgPresetSoldierResponse> getPresetSoldiers(
            Long presetId
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        return presetSoldierRepository
                .findByPreset_Id(preset.getId())
                .stream()
                .map(presetSoldierMapper::toResponse)
                .toList();
    }

    @Transactional
    public GvgPresetSoldierResponse addSoldier(
            Long presetId,
            GvgPresetSoldierRequest request
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        validateSoldierRequest(request);

        if (presetSoldierRepository.existsByPreset_IdAndSoldier_Id(
                presetId,
                request.soldierId()
        )) {
            throw new ValidationException(
                    "Soldier is already added to this preset: "
                            + request.soldierId()
            );
        }

        DemonSoldier soldier =
                mapValidationService.getSoldier(
                        request.soldierId()
                );

        mapValidationService.validateSoldierLevel(
                request.level()
        );

        GvgPresetSoldier presetSoldier =
                GvgPresetSoldier.builder()
                        .preset(preset)
                        .soldier(soldier)
                        .level(request.level())
                        .build();

        return presetSoldierMapper.toResponse(
                presetSoldierRepository.save(presetSoldier)
        );
    }

    @Transactional
    public GvgPresetSoldierResponse updateSoldier(
            Long presetId,
            Long soldierId,
            GvgPresetSoldierRequest request
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        validateSoldierRequest(request);

        if (!soldierId.equals(request.soldierId())) {
            throw new ValidationException(
                    "Soldier ID in path and request must match"
            );
        }

        GvgPresetSoldier presetSoldier =
                presetSoldierRepository
                        .findByPreset_IdAndSoldier_Id(
                                preset.getId(),
                                soldierId
                        )
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Soldier is not added to this preset: "
                                                + soldierId
                                )
                        );

        mapValidationService.validateSoldierLevel(
                request.level()
        );

        presetSoldier.setLevel(request.level());

        return presetSoldierMapper.toResponse(
                presetSoldierRepository.save(presetSoldier)
        );
    }

    @Transactional
    public void removeSoldier(
            Long presetId,
            Long soldierId
    ) {
        GvgPreset preset = getCurrentGuildPreset(presetId);

        GvgPresetSoldier presetSoldier =
                presetSoldierRepository
                        .findByPreset_IdAndSoldier_Id(
                                preset.getId(),
                                soldierId
                        )
                        .orElseThrow(() ->
                                new ResourceNotFoundException(
                                        "Soldier is not added to this preset: "
                                                + soldierId
                                )
                        );

        presetSoldierRepository.delete(presetSoldier);
    }

    /*
     * =========================
     * INTERNAL
     * =========================
     */

    private GvgPreset getCurrentGuildPreset(Long presetId) {
        Long guildId = guildContextService.getCurrentGuildId();

        return presetRepository
                .findByIdAndGuild_Id(presetId, guildId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "GVG preset not found: " + presetId
                        )
                );
    }

    private void validatePresetCode(String presetCode) {
        if (presetCode == null || presetCode.isBlank()) {
            throw new ValidationException(
                    "Preset code must not be blank"
            );
        }

        if (presetCode.length() > 100) {
            throw new ValidationException(
                    "Preset code must not exceed 100 characters"
            );
        }
    }

    private void validateHeroRequest(
            GvgPresetHeroRequest request
    ) {
        if (request == null) {
            throw new ValidationException(
                    "Hero request must not be null"
            );
        }

        if (request.heroId() == null) {
            throw new ValidationException(
                    "Hero ID must not be null"
            );
        }

        /*
         * For the current GVG rule every added hero
         * must occupy exactly one tile.
         */
        if (request.tileId() == null) {
            throw new ValidationException(
                    "Tile ID must not be null"
            );
        }

        if (request.attackDirection() == null) {
            throw new ValidationException(
                    "Attack direction must not be null"
            );
        }
    }

    private void validateSoldierRequest(
            GvgPresetSoldierRequest request
    ) {
        if (request == null) {
            throw new ValidationException(
                    "Soldier request must not be null"
            );
        }

        if (request.soldierId() == null) {
            throw new ValidationException(
                    "Soldier ID must not be null"
            );
        }

        if (request.level() == null) {
            throw new ValidationException(
                    "Soldier level must not be null"
            );
        }
    }
}