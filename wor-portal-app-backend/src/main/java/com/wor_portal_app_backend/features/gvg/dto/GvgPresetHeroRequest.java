package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;

public record GvgPresetHeroRequest(
        Long heroId,
        Long tileId,
        AttackDirection attackDirection
) {
}