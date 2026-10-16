package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;

public record GvgPresetHeroDetailsResponse(
        Long id,
        Long heroId,
        Long tileId,
        Integer x,
        Integer y,
        AttackDirection attackDirection
) {
}