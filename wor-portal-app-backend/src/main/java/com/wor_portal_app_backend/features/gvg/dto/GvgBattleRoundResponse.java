package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.GvgBattleRoundStatus;
import com.wor_portal_app_backend.features.gvg.enums.GvgMapType;

import java.time.LocalDateTime;
import java.util.List;

public record GvgBattleRoundResponse(
        Long id,
        Integer roundNumber,
        String opponentName,
        GvgBattleRoundStatus status,
        LocalDateTime createdAt,
        LocalDateTime lockedAt,
        GvgMapType displayedMapType,
        List<GvgBattleSlotResponse> slots
) {}
