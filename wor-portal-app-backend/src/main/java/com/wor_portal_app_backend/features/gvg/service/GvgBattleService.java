package com.wor_portal_app_backend.features.gvg.service;

import com.wor_portal_app_backend.exception.ResourceNotFoundException;
import com.wor_portal_app_backend.exception.ValidationException;
import com.wor_portal_app_backend.features.gvg.dto.*;
import com.wor_portal_app_backend.features.gvg.entity.GvgBattleRound;
import com.wor_portal_app_backend.features.gvg.entity.GvgBattleDefenseHero;
import com.wor_portal_app_backend.features.gvg.entity.GvgBattleSlot;
import com.wor_portal_app_backend.features.gvg.entity.GvgMap;
import com.wor_portal_app_backend.features.gvg.entity.GvgMapTile;
import com.wor_portal_app_backend.features.gvg.entity.GvgPreset;
import com.wor_portal_app_backend.features.gvg.enums.GvgBattleRoundStatus;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;
import com.wor_portal_app_backend.entity.Hero;
import com.wor_portal_app_backend.features.gvg.repository.GvgBattleRoundRepository;
import com.wor_portal_app_backend.features.gvg.repository.GvgBattleSlotRepository;
import com.wor_portal_app_backend.features.gvg.repository.GvgPresetRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class GvgBattleService {
    private static final int TOWER_POSITIONS = 25;
    private static final int FORT_POSITIONS = 5;
    private static final int LANES_PER_POSITION = 2;
    private static final int MAX_BREACH_AUTHORS = 2;

    private final GvgBattleRoundRepository roundRepository;
    private final GvgBattleSlotRepository slotRepository;
    private final GvgPresetRepository presetRepository;
    private final GvgPresetService presetService;
    private final GvgPresetSearchService presetSearchService;
    private final GvgGuildContextService guildContextService;
    private final GvgMapValidationService mapValidationService;

    @Transactional(readOnly = true)
    public GvgBattleRoundResponse getActiveRound(GvgMapType mapType) {
        Long guildId = guildContextService.getCurrentGuildId();
        return roundRepository
                .findFirstByGuild_IdAndStatusOrderByRoundNumberDesc(guildId, GvgBattleRoundStatus.ACTIVE)
                .map(round -> toRoundResponse(round, mapType))
                .orElse(null);
    }

    @Transactional(readOnly = true)
    public GvgBattleRoundResponse getRound(Long roundId, GvgMapType mapType) {
        GvgBattleRound round = getGuildRound(roundId);
        return toRoundResponse(round, mapType);
    }

    @Transactional(readOnly = true)
    public List<GvgBattleRoundSummaryResponse> getHistory() {
        Long guildId = guildContextService.getCurrentGuildId();
        return roundRepository.findByGuild_IdOrderByRoundNumberDesc(guildId).stream()
                .map(this::toSummary)
                .toList();
    }

    @Transactional
    public GvgBattleRoundResponse createNextRound(GvgBattleRoundCreateRequest request, GvgMapType displayedMapType) {
        String opponentName = validateOpponentName(request == null ? null : request.opponentName());
        Long guildId = guildContextService.getCurrentGuildId();

        roundRepository.findByGuildAndStatusForUpdate(guildId, GvgBattleRoundStatus.ACTIVE)
                .ifPresent(active -> {
                    active.setStatus(GvgBattleRoundStatus.LOCKED);
                    active.setLockedAt(LocalDateTime.now());
                    roundRepository.save(active);
                });

        int nextNumber = roundRepository.findFirstByGuild_IdOrderByRoundNumberDesc(guildId)
                .map(round -> round.getRoundNumber() + 1)
                .orElse(1);

        GvgBattleRound round = roundRepository.save(GvgBattleRound.builder()
                .guild(guildContextService.getCurrentGuild())
                .roundNumber(nextNumber)
                .opponentName(opponentName)
                .status(GvgBattleRoundStatus.ACTIVE)
                .build());

        List<GvgBattleSlot> slots = new ArrayList<>(TOWER_POSITIONS * 2 + FORT_POSITIONS * 2);
        addSlotsForMap(round, GvgMapType.TOWER, TOWER_POSITIONS, slots);
        addSlotsForMap(round, GvgMapType.FORT, FORT_POSITIONS, slots);
        slotRepository.saveAll(slots);

        return toRoundResponse(round, displayedMapType);
    }

    @Transactional
    public GvgBattleRoundResponse renameOpponent(Long roundId, GvgBattleOpponentUpdateRequest request, GvgMapType displayedMapType) {
        GvgBattleRound round = getGuildRound(roundId);
        requireActive(round);
        round.setOpponentName(validateOpponentName(request == null ? null : request.opponentName()));
        roundRepository.save(round);
        return toRoundResponse(round, displayedMapType);
    }

    @Transactional
    public GvgBattleSlotResponse updateSlot(Long slotId, GvgBattleSlotUpdateRequest request) {
        if (request == null) throw new ValidationException("Slot update request must not be null");
        GvgBattleSlot slot = getGuildSlot(slotId);
        requireActive(slot.getRound());

        GvgPreset preset = null;
        if (request.defensePresetId() != null) {
            preset = presetRepository.findByIdAndGuild_Id(
                            request.defensePresetId(), guildContextService.getCurrentGuildId())
                    .orElseThrow(() -> new ResourceNotFoundException("GvG preset not found: " + request.defensePresetId()));
            GvgMap presetMap = preset.getMap();
            if (presetMap == null || presetMap.getMapType() != slot.getMapType()) {
                throw new ValidationException("Defense preset map type must match this battle slot.");
            }
        }

        if (request.battlePower() != null && request.battlePower() < 0) {
            throw new ValidationException("Battle power must be zero or greater.");
        }
        if (request.opponentNickname() != null && request.opponentNickname().length() > 100) {
            throw new ValidationException("Opponent nickname must not exceed 100 characters.");
        }

        String normalizedNickname = trimToNull(request.opponentNickname());
        slot.setDefensePreset(preset);
        slot.setOpponentNickname(normalizedNickname);
        slot.setBattlePower(request.battlePower());
        slot.setMirrorNote(trimToNull(request.mirrorNote()));
        slotRepository.save(slot);
        syncPairedNickname(slot, normalizedNickname);
        return toSlotResponse(slot);
    }

    @Transactional
    public GvgBattleSlotResponse updateDefense(Long slotId, GvgBattleDefenseUpdateRequest request) {
        if (request == null) throw new ValidationException("Defense update request must not be null.");

        GvgBattleSlot slot = getGuildSlot(slotId);
        requireActive(slot.getRound());

        if (request.mapId() == null) throw new ValidationException("Map ID must not be null.");
        GvgMap map = mapValidationService.getMap(request.mapId());
        if (map.getMapType() != slot.getMapType()) {
            throw new ValidationException("Defense map type must match this battle slot.");
        }

        List<GvgBattleDefenseHeroRequest> requestedHeroes =
                request.heroes() == null ? List.of() : request.heroes();
        if (!requestedHeroes.isEmpty() && requestedHeroes.size() != 5) {
            throw new ValidationException("Enemy defense must contain exactly 5 heroes, or 0 heroes to clear it.");
        }
        if (request.battlePower() != null && request.battlePower() < 0) {
            throw new ValidationException("Battle power must be zero or greater.");
        }
        if (request.opponentNickname() != null && request.opponentNickname().length() > 100) {
            throw new ValidationException("Opponent nickname must not exceed 100 characters.");
        }

        Set<Long> heroIds = new HashSet<>();
        Set<Long> tileIds = new HashSet<>();
        List<GvgBattleDefenseHero> newPlacements = new ArrayList<>();

        for (GvgBattleDefenseHeroRequest heroRequest : requestedHeroes) {
            if (heroRequest == null || heroRequest.heroId() == null || heroRequest.tileId() == null || heroRequest.attackDirection() == null) {
                throw new ValidationException("Each defense hero must have heroId, tileId, and attackDirection.");
            }
            if (!heroIds.add(heroRequest.heroId())) {
                throw new ValidationException("Duplicate hero ID in enemy defense: " + heroRequest.heroId());
            }
            if (!tileIds.add(heroRequest.tileId())) {
                throw new ValidationException("Duplicate tile ID in enemy defense: " + heroRequest.tileId());
            }

            Hero hero = mapValidationService.getHero(heroRequest.heroId());
            GvgMapTile tile = mapValidationService.getTile(heroRequest.tileId());
            mapValidationService.validateTileBelongsToMap(tile, map);
            mapValidationService.validateHeroTileCompatibility(hero, tile);

            newPlacements.add(GvgBattleDefenseHero.builder()
                    .slot(slot)
                    .hero(hero)
                    .tile(tile)
                    .attackDirection(heroRequest.attackDirection())
                    .build());
        }

        // Enemy defense is a battle-specific formation, not a shared attack preset.
        // Flush orphan removals before inserting the replacement rows: otherwise
        // Hibernate may execute INSERTs before DELETEs at transaction flush time,
        // violating uk_gvg_battle_defense_hero / uk_gvg_battle_defense_tile when
        // the same heroes or tiles are saved again for this slot.
        String normalizedNickname = trimToNull(request.opponentNickname());
        slot.getDefenseHeroes().clear();
        slot.setDefensePreset(null);
        slot.setOpponentNickname(normalizedNickname);
        slot.setBattlePower(request.battlePower());
        slot.setMirrorNote(trimToNull(request.mirrorNote()));

        // Ensure existing child rows are deleted before adding replacement rows.
        slotRepository.saveAndFlush(slot);

        slot.getDefenseHeroes().addAll(newPlacements);
        slotRepository.saveAndFlush(slot);
        syncPairedNickname(slot, normalizedNickname);
        return toSlotResponse(slot);
    }

    @Transactional
    public GvgBattleSlotResponse updateBreach(Long slotId, GvgBattleBreachRequest request) {
        if (request == null) throw new ValidationException("Breach request must not be null");
        GvgBattleSlot slot = getGuildSlot(slotId);
        requireActive(slot.getRound());
        String username = currentUsername();

        if (request.breached()) {
            if (Objects.equals(slot.getBreachedBy1(), username) || Objects.equals(slot.getBreachedBy2(), username)) {
                slot.setBreached(true);
            } else if (slot.getBreachedBy1() == null) {
                slot.setBreachedBy1(username);
                slot.setBreached(true);
            } else if (slot.getBreachedBy2() == null) {
                slot.setBreachedBy2(username);
                slot.setBreached(true);
            } else {
                // Keep the first two authors as requested; the breach itself stays marked.
                slot.setBreached(true);
            }
        } else {
            if (Objects.equals(slot.getBreachedBy1(), username)) {
                slot.setBreachedBy1(slot.getBreachedBy2());
                slot.setBreachedBy2(null);
            } else if (Objects.equals(slot.getBreachedBy2(), username)) {
                slot.setBreachedBy2(null);
            }
            slot.setBreached(slot.getBreachedBy1() != null || slot.getBreachedBy2() != null);
        }

        slotRepository.save(slot);
        return toSlotResponse(slot);
    }

    private void addSlotsForMap(GvgBattleRound round, GvgMapType mapType, int positions, List<GvgBattleSlot> target) {
        for (int number = 1; number <= positions; number++) {
            for (int lane = 1; lane <= LANES_PER_POSITION; lane++) {
                target.add(GvgBattleSlot.builder()
                        .round(round)
                        .mapType(mapType)
                        .slotNumber(number)
                        .laneNumber(lane)
                        .breached(false)
                        .build());
            }
        }
    }

    private GvgBattleRoundResponse toRoundResponse(GvgBattleRound round, GvgMapType mapType) {
        List<GvgBattleSlotResponse> slots = slotRepository
                .findByRound_IdAndMapTypeOrderBySlotNumberAscLaneNumberAsc(round.getId(), mapType)
                .stream()
                .map(this::toSlotResponse)
                .toList();

        return new GvgBattleRoundResponse(
                round.getId(), round.getRoundNumber(), round.getOpponentName(), round.getStatus(),
                round.getCreatedAt(), round.getLockedAt(), mapType, slots
        );
    }

    private GvgBattleSlotResponse toSlotResponse(GvgBattleSlot slot) {
        GvgBattlePresetSnapshotResponse defenseSnapshot = null;
        List<GvgBattlePresetSnapshotResponse> recommendations = List.of();
        Long defensePresetId = slot.getDefensePreset() == null ? null : slot.getDefensePreset().getId();
        List<GvgBattleDefenseHeroResponse> defenseHeroResponses = new ArrayList<>();
        Long searchMapId = null;
        List<GvgPresetHeroRequest> searchHeroes = new ArrayList<>();

        // Preferred path: a battle-specific enemy defense created in the modal.
        if (slot.getDefenseHeroes() != null && !slot.getDefenseHeroes().isEmpty()) {
            for (GvgBattleDefenseHero placement : slot.getDefenseHeroes()) {
                GvgMapTile tile = placement.getTile();
                defenseHeroResponses.add(new GvgBattleDefenseHeroResponse(
                        placement.getHero().getId(),
                        tile.getId(),
                        tile.getX(),
                        tile.getY(),
                        placement.getAttackDirection()
                ));
                if (searchMapId == null) searchMapId = tile.getMap().getId();
                searchHeroes.add(new GvgPresetHeroRequest(
                        placement.getHero().getId(), tile.getId(), placement.getAttackDirection()
                ));
            }
        } else if (defensePresetId != null) {
            // Compatibility path for battle slots assigned before the custom-defense editor.
            GvgPresetDetailsResponse defenseDetails = presetService.getPresetDetails(defensePresetId);
            defenseSnapshot = toSnapshot(defenseDetails);
            searchMapId = defenseDetails.map() == null ? null : defenseDetails.map().id();
            List<GvgPresetHeroDetailsResponse> legacyHeroes = defenseDetails.heroes() == null
                    ? List.of() : defenseDetails.heroes();
            for (GvgPresetHeroDetailsResponse hero : legacyHeroes) {
                defenseHeroResponses.add(new GvgBattleDefenseHeroResponse(
                        hero.heroId(), hero.tileId(), hero.x(), hero.y(), hero.attackDirection()
                ));
                searchHeroes.add(new GvgPresetHeroRequest(hero.heroId(), hero.tileId(), hero.attackDirection()));
            }
        }

        boolean searchable = searchMapId != null && searchHeroes.size() == 5
                && searchHeroes.stream().allMatch(hero -> hero.heroId() != null && hero.tileId() != null && hero.attackDirection() != null);
        if (searchable) {
            GvgPresetSearchRequest searchRequest = new GvgPresetSearchRequest(searchMapId, searchHeroes);
            recommendations = presetSearchService.searchExactPresets(searchRequest).stream()
                    .map(preset -> presetService.getPresetDetails(preset.id()))
                    .map(this::toSnapshot)
                    .toList();
        }

        List<String> breachAuthors = new ArrayList<>(2);
        if (slot.getBreachedBy1() != null && !slot.getBreachedBy1().isBlank()) breachAuthors.add(slot.getBreachedBy1());
        if (slot.getBreachedBy2() != null && !slot.getBreachedBy2().isBlank()) breachAuthors.add(slot.getBreachedBy2());

        String title = slot.getMapType().name() + " " + slot.getSlotNumber() + "." + slot.getLaneNumber();
        return new GvgBattleSlotResponse(
                slot.getId(), slot.getMapType(), slot.getSlotNumber(), slot.getLaneNumber(), title,
                slot.isBreached(), List.copyOf(breachAuthors), slot.getOpponentNickname(), slot.getBattlePower(),
                slot.getMirrorNote(), defensePresetId, defenseSnapshot, recommendations, List.copyOf(defenseHeroResponses)
        );
    }

    private GvgBattlePresetSnapshotResponse toSnapshot(GvgPresetDetailsResponse details) {
        return new GvgBattlePresetSnapshotResponse(
                details.preset(),
                details.heroes() == null ? List.of() : details.heroes(),
                details.soldiers() == null ? List.of() : details.soldiers()
        );
    }

    private GvgBattleRoundSummaryResponse toSummary(GvgBattleRound round) {
        return new GvgBattleRoundSummaryResponse(
                round.getId(), round.getRoundNumber(), round.getOpponentName(), round.getStatus(),
                round.getCreatedAt(), round.getLockedAt()
        );
    }

    private GvgBattleRound getGuildRound(Long roundId) {
        return roundRepository.findByIdAndGuild_Id(roundId, guildContextService.getCurrentGuildId())
                .orElseThrow(() -> new ResourceNotFoundException("GvG battle round not found: " + roundId));
    }

    private void syncPairedNickname(GvgBattleSlot sourceSlot, String nickname) {
        // A position (for example TOWER 1) contains two lanes: .1 and .2.
        // Keep only the opponent nickname shared; BM and mirror notes are lane-specific.
        if (nickname == null || nickname.isBlank()) return;
        Integer laneNumber = sourceSlot.getLaneNumber();
        if (laneNumber == null || (laneNumber != 1 && laneNumber != 2)) return;

        int pairedLaneNumber = laneNumber == 1 ? 2 : 1;
        slotRepository.findByRound_IdAndMapTypeAndSlotNumberAndLaneNumber(
                sourceSlot.getRound().getId(),
                sourceSlot.getMapType(),
                sourceSlot.getSlotNumber(),
                pairedLaneNumber
        ).ifPresent(pairedSlot -> {
            pairedSlot.setOpponentNickname(nickname);
            slotRepository.save(pairedSlot);
        });
    }

    private GvgBattleSlot getGuildSlot(Long slotId) {
        return slotRepository.findByIdAndRound_Guild_IdForUpdate(slotId, guildContextService.getCurrentGuildId())
                .orElseThrow(() -> new ResourceNotFoundException("GvG battle slot not found: " + slotId));
    }

    private void requireActive(GvgBattleRound round) {
        if (round.getStatus() != GvgBattleRoundStatus.ACTIVE) {
            throw new ValidationException("This battle round is locked and cannot be edited.");
        }
    }

    private String validateOpponentName(String name) {
        String normalized = trimToNull(name);
        if (normalized == null) throw new ValidationException("Opponent name must not be blank.");
        if (normalized.length() > 150) throw new ValidationException("Opponent name must not exceed 150 characters.");
        return normalized;
    }

    private String trimToNull(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String currentUsername() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                || authentication.getName().isBlank() || "anonymousUser".equals(authentication.getName())) {
            throw new ValidationException("Authenticated user is required to mark a breach.");
        }
        return authentication.getName().trim();
    }
}
