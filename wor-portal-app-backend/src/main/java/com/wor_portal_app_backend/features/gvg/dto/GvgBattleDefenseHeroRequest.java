package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;

public record GvgBattleDefenseHeroRequest(
    Long heroId,
    Long tileId,
    AttackDirection attackDirection
) {}
