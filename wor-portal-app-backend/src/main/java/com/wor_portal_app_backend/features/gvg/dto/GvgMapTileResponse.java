package com.wor_portal_app_backend.features.gvg.dto;

import com.wor_portal_app_backend.features.gvg.enums.AttackDirection;
import com.wor_portal_app_backend.features.gvg.enums.GvgTileType;

public record GvgMapTileResponse(
        Long id,
        Long mapId,
        Integer x,
        Integer y,
        GvgTileType tileType,
        AttackDirection attackDirection
) {
}