package com.wor_portal_app_backend.features.gvg.dto;

public record GvgBattleSlotUpdateRequest(
        Long defensePresetId,
        String opponentNickname,
        Long battlePower,
        String mirrorNote
) {}
