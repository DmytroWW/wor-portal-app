package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;

import java.util.List;

public record GvgBattleSlotResponse(
        Long id,
        GvgMapType mapType,
        Integer slotNumber,
        Integer laneNumber,
        String title,
        boolean breached,
        List<String> breachedBy,
        String opponentNickname,
        Long battlePower,
        String mirrorNote,
        Long defensePresetId,
        GvgBattlePresetSnapshotResponse defensePreset,
        List<GvgBattlePresetSnapshotResponse> recommendedAttacks,
        List<GvgBattleDefenseHeroResponse> defenseHeroes
) {}
