package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.GvgBattleRoundStatus;

import java.time.LocalDateTime;

public record GvgBattleRoundSummaryResponse(
        Long id,
        Integer roundNumber,
        String opponentName,
        GvgBattleRoundStatus status,
        LocalDateTime createdAt,
        LocalDateTime lockedAt
) {}
