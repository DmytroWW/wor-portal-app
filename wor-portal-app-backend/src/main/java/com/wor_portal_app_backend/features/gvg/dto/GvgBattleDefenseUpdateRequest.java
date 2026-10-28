package com.wor_portal_app_backend.features.gvg.dto;

import java.util.List;

public record GvgBattleDefenseUpdateRequest(
    Long mapId,
    List<GvgBattleDefenseHeroRequest> heroes,
    String opponentNickname,
    Long battlePower,
    String mirrorNote
) {}
